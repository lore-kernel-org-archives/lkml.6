Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159887-2-2008451095933263004
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
    1527159886; b=Q45ZXKnEpkAvpCA87OTL4xJywocE2Z8pOrbVp1q+LvVsABzqlU
    H33L76Hz/0Jkwktm845xP+6QcC0YIvVe/G9L3yS1mfkTwDUQ2/YRt+ZgAj2gFnds
    22Lj4+yZ8sumDEdewlOZHJTbqwDVyhyOheWoV5jMnexWlT4/djNE86R25Qg/sY1Y
    ygV8T2I9EZUZgzkk3Ol/PMMDPcqsFhXd22eh1ZM36E0ZdJr9fx+5rODi/CiKcaBi
    Fr6GXy6260Yuwte7oZKbyxRAPw3RQBF2vtU10r4mUDjHOfSatW6vliSC5yXR2sc9
    RhExq5NYO1nR1VXvt8dmHl+UAzxIm7ltHfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159886; bh=e2+P9MOMT6hd9Lc4Xhju6idD4pKsII
    5q99nU7GGGSNI=; b=Rca4OVm8bR6HFCzfowggKORfg4nrp3FgsLN1L4DBbGnAZD
    mb8Va8jADOQh9jagntOIwj5Mkh5bTPK2WuJACAMvEA70WjuRvsW0qVB074f6Ilff
    Q604OkigrTRZ4aLHSxV18gX8ARuPznJRxtqVAtWc1JUjnAeUA1offkvG+mwi3s+q
    8a6HyyYaqWrPqhVUKxjv1vU33Ch1zS9/mhv3cmN7O7ClPHeEw/ro65+oRJWL96Sk
    EIfnSCmuuZX4GiboAahV6LExU4u4HzpgB897S7JRKpAPzt3tl2Qh6wFyQLm+Ktj0
    FS2Q0DmV87uxkDqe1dhjB+LbRPeZD5dc49HAVKlQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=T7jthiHd x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=T7jthiHd x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFIhk7PMW7Wxj0smF5qXARm7OWdeXfEKVDiijd6wGSaOAxjjOlz7EoaGLJpnIffvtw/UoKxy5/nIF6c7javGW8guhRxFfID7mcT1rZo0oyJbZCaXMeZQ
    8sTrpcXjgrclfbUoSvt8kCi3NkLRgXtNLUEjysT1WmwYLRK5B5UjbflJdhAM9LzWLx4/hg/NIiXNAN6SnF83O30vvf/G5jE2Gmcgkqf7GN4pGgcx0jJIKax9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=py21UxDLYLCECys3kJ0A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968067AbeEXLEp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968351AbeEXJzY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 094/165] crypto: inside-secure - do not process request if no command was issued
Date: Thu, 24 May 2018 11:38:20 +0200
Message-Id: <20180524093625.824194216@linuxfoundation.org>
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

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 95831ceafc0de7d94a5fe86ebb1c2042317cc2cd ]

This patch adds a check in the SafeXcel dequeue function, to avoid
processing request further if no hardware command was issued. This can
happen in certain cases where the ->send() function caches all the data
that would have been send.

Fixes: 809778e02cd4 ("crypto: inside-secure - fix hash when length is a multiple of a block")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -462,6 +462,15 @@ void safexcel_dequeue(struct safexcel_cr
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
 
+		/* In case the send() helper did not issue any command to push
+		 * to the engine because the input data was cached, continue to
+		 * dequeue other requests as this is valid and not an error.
+		 */
+		if (!commands && !results) {
+			kfree(request);
+			continue;
+		}
+
 		spin_lock_bh(&priv->ring[ring].egress_lock);
 		list_add_tail(&request->list, &priv->ring[ring].list);
 		spin_unlock_bh(&priv->ring[ring].egress_lock);
