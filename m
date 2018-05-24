Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161102-2-9212845277923645507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endask.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161102; b=VtY2tp/LsFmEbpDhFhh0HOJme8UEEZpDHvro2h1zGaYD2AyUM8
    O04rKUv0/Ni3o5Wnrtj7+oHzm5WbIW5Pfk5QMaSv37B1V3/6oH3u96fXxhER+AlE
    TNjLF4t/eg4pffNNb0aYIzeNORYfzqXXdhLaw7QFXcS3s5POOW4m1d0h2+Jjye9P
    Zw1LSS+LPCDnRgTvivGlUIDiTHska0qVQT4w1u2NA1Lf9cHn2elMI7QOi/rDD/hF
    7Y3JMpZDohC2ZyojBViljK+UyxbpTC16Uo/rbUw8/Pi4NDDhQEygGqQRmlPUN+4Y
    ehF2pNwFRAf9bxGoee8XKnHIMQCPqrAblJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161102; bh=VkUnHwBRRCSw7Z+c20EkhM/KRcKMC3
    VBmHXGmNjmCnY=; b=GvC8t1/jZKUTEdpo+xYPMtOO3cwYJPRiMMWsCi9kzocIJm
    CT22gA1pWeeObydnHCwBiMPO+eykGa0YPmndslSoFdOeeSY6R1FwwDcGoLu7Z/4f
    iG7MSXfr98mCNWh3D5dZoW/LcrXqhjNz2T5bWPpjiKqkSZtSdNKyEU7VWgsCJ02K
    1cW8YU45PJ2sO4UeNBXCbGgJM+bjGuydfnP/I7nNteRcfdW2oK0AQsBL8S165Ri5
    a8vREmcjbEeo+UDyU3k1ZCVoqnhqKvH+Z6Bp/gjQ0xOUvzBT6tdE4YYlqboa6ydv
    GH1EZLY9g0sKP4bAV9VS09dnWx/k0VoYeRD2BXaQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=YI9CwqGQ x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=YI9CwqGQ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDfVbEg8lg51ym85xgNTo4Qr+iX4TVW4zUT1vZvIUzY01yKKTOzuwR5vsQO+TONCbn6hKevZiP72y6vJ8tks4+y3Qgjsgl8bvz0H3JggLcw4RU/l0pIp
    pO6MJyWL72hB8imRZILnRZ87bCKA3cxPBZzvJarAoO4fZWaeDBNC9z28XcD3pzGJ2BF4w+MjPkyX1F0iu6EXeUN0f3FKH5guYND1gA494IwWTwifWu0/q5WA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=40Sf997Ef6FVB49e-4oA:9
    a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967776AbeEXJvu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967380AbeEXJvq (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 014/165] hv_netvsc: Rename tx_send_table to tx_table
Date: Thu, 24 May 2018 11:37:00 +0200
Message-Id: <20180524093622.562075743@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Commit 39e91cfbf6f5fb26ba64cc2e8874372baf1671e7 upstream. ]

Simplify the variable name: tx_send_table

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h |    2 +-
 drivers/net/hyperv/netvsc.c     |    2 +-
 drivers/net/hyperv/netvsc_drv.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -734,7 +734,7 @@ struct net_device_context {
 
 	u32 tx_checksum_mask;
 
-	u32 tx_send_table[VRSS_SEND_TAB_SIZE];
+	u32 tx_table[VRSS_SEND_TAB_SIZE];
 
 	/* Ethtool settings */
 	bool udp4_l4_hash;
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1107,7 +1107,7 @@ static void netvsc_send_table(struct hv_
 		      nvmsg->msg.v5_msg.send_table.offset);
 
 	for (i = 0; i < count; i++)
-		net_device_ctx->tx_send_table[i] = tab[i];
+		net_device_ctx->tx_table[i] = tab[i];
 }
 
 static void netvsc_send_vf(struct net_device_context *net_device_ctx,
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -234,8 +234,8 @@ static inline int netvsc_get_tx_queue(st
 	struct sock *sk = skb->sk;
 	int q_idx;
 
-	q_idx = ndc->tx_send_table[netvsc_get_hash(skb, ndc) &
-				   (VRSS_SEND_TAB_SIZE - 1)];
+	q_idx = ndc->tx_table[netvsc_get_hash(skb, ndc) &
+			      (VRSS_SEND_TAB_SIZE - 1)];
 
 	/* If queue index changed record the new value */
 	if (q_idx != old_idx &&
