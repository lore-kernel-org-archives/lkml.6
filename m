Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527164673-2-10141009555996688395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164673; b=ksJOdUUNJfDAA2XoiBbHhLMsVZYXe0ezTPKe/DPcYgmSMq1K+T
    mjEwQ9nee4HI6ixTl6SI9fRFsVYVrqslbUEL+pVLM/OhY1Nq49zMejo6BxVMhIbu
    hd16NtnN58LYQful0bbYrr/8yRrbYY/6hse/9H4OHkqzeWM+1fODyizdyCw2xoXT
    5jns/SiuTz+Oyut8OGjwOFIbtKuJyntPUz3tvbf/PoHv0d8EBSjB0l0OcdfSo5sB
    9T21hb9JYnNwJZSjYlsrZJuW1JKKTL5m0JGebcyo1fN1HH9/G4gcRuqpJjTr5lCT
    UnyKQh+UGyjIeQ603AvqavHXLhTJnhVrxqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164673; bh=aI3d/rXK4P/B+PbNvPsMD64yjHMCnr
    R8tNkgQcmeudU=; b=Co8VHkEEj1Y2TW7uuRaT2E4jNduUz4vro3BaVbIx+TfIOY
    jSLgOaReKciGcQQNIYE1zYYf9BtNbCOQNXtHsvbeIk9ymezv6doovOLNP604dApk
    kSK7HG761CvCju+jRHKMYmAS7JxZUuBOcNwWeB0/q9btz5t56JJA+EalK/CRr9Ku
    JEzIHt8chOcKqxU+xubkfKq9aUJkYNnZ7L88ojrCXscGfQ08jAhFNU66znXpHfqV
    m63xANnCEJEI8iLN/LMtGlbEhyz5V4HIw1fO9Yof+tEeBfmyXfYG6l3S75GhUOgF
    n6QCcEUNLcNStBJmQN7bQGI0ZGGwy6zhseo7S4FA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QZGa+gHh x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=QZGa+gHh x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAdw++aChQMp7lIM0pD0eyJeY/sJWI/uxAy6SCZjFJoDoVTY6+DCvP5vgm80HXRyRsYuNDm2t37rfF0CjktXWPXuJ6gu7Vff42YQnkP3L0KJCtF9QyqR
    RqRlyqoRvg/lrPK29ZvCI7tZCRbQZa8K+oTttMoXAjvH2by5qWLVrMWw+rV+3CcWuvkzSRUPXJ/SvSAHPs7CcjNQ5w7AyS+KZAP9Zuc2Qvm4/oMc50hneInx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Q-fNiiVtAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=JRk18abXo-UP5clGnZsA:9 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966097AbeEXMXa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965995AbeEXJkz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:40:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 12/45] tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().
Date: Thu, 24 May 2018 11:38:20 +0200
Message-Id: <20180524093122.018978144@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit d89a2adb8bfe6f8949ff389acdb9fa298b6e8e12 ]

tg3_free_consistent() calls dma_free_coherent() to free tp->hw_stats
under spinlock and can trigger BUG_ON() in vunmap() because vunmap()
may sleep.  Fix it by removing the spinlock and relying on the
TG3_FLAG_INIT_COMPLETE flag to prevent race conditions between
tg3_get_stats64() and tg3_free_consistent().  TG3_FLAG_INIT_COMPLETE
is always cleared under tp->lock before tg3_free_consistent()
and therefore tg3_get_stats64() can safely access tp->hw_stats
under tp->lock if TG3_FLAG_INIT_COMPLETE is set.

Fixes: f5992b72ebe0 ("tg3: Fix race condition in tg3_get_stats64().")
Reported-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -8705,14 +8705,15 @@ static void tg3_free_consistent(struct t
 	tg3_mem_rx_release(tp);
 	tg3_mem_tx_release(tp);
 
-	/* Protect tg3_get_stats64() from reading freed tp->hw_stats. */
-	tg3_full_lock(tp, 0);
+	/* tp->hw_stats can be referenced safely:
+	 *     1. under rtnl_lock
+	 *     2. or under tp->lock if TG3_FLAG_INIT_COMPLETE is set.
+	 */
 	if (tp->hw_stats) {
 		dma_free_coherent(&tp->pdev->dev, sizeof(struct tg3_hw_stats),
 				  tp->hw_stats, tp->stats_mapping);
 		tp->hw_stats = NULL;
 	}
-	tg3_full_unlock(tp);
 }
 
 /*
@@ -14137,7 +14138,7 @@ static struct rtnl_link_stats64 *tg3_get
 	struct tg3 *tp = netdev_priv(dev);
 
 	spin_lock_bh(&tp->lock);
-	if (!tp->hw_stats) {
+	if (!tp->hw_stats || !tg3_flag(tp, INIT_COMPLETE)) {
 		*stats = tp->net_stats_prev;
 		spin_unlock_bh(&tp->lock);
 		return stats;
