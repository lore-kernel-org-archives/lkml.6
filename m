Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992793-1525122299-2-10551357544458122420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525122298; b=ViwjaOgM1f6udbrndEC17Jl2sgkJTR5ax0XUFQML9LXVYJXB+Z
    sTGENnMqlofdNd4EDEDye/KymKbc7pf194sDirz4l1Xu90zUp1ch59i/S+ahpn6g
    KTre8jirRRGOq5CK5iMdPX5RDnCCYzWQHNUphBVyg4niBwzmWI1sgV36zyArQe3Z
    0FqW6cfFLYtNLN7boYDzDIep7FS5mM+gW80SYP6lEljNTTFM6s24BQ3XGJwhf0Tc
    s8ekoDHoShcy8hLMlSX6wkheU7PoxCfbZs5WsMCb3yHTflESSndw26aZUC+0DFdK
    a+GxnO97L7QbL2gFDiu5FCTl1kmzJP4VgbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:in-reply-to:references
    :content-type:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525122298; bh=VYPqd0EPnstIXTaxNQWFz6GHqHLI1+Ex0cegRHPwv2s=; b=
    AdojfVkSzYe8PlAfpwiqZNAD1574lozLoJZhxAQ0Op6USxRlKu6uLXf8DPpS4CuF
    cVRGQRycJc7WFw7jT0pVmrarX/E3Qn8oV8p7Dye8offXI0Lf3KCOFdjgosHIq8dO
    47TvCRG/Ssuzi8qeLvy1syoE8EIc7OOlwYPhOuSbsJB4Fl5imGARPUfVLLYfXzIP
    10A1pYxkvyDpQ0hzO6ukRlV/XBjt5m70RxUD4OTFoB1b4FIcHaEPGN1kgmoQqNf/
    KbPOqhYCYUo6dUTLs4Yl1QN5ORU94v9EIlqHSqtVbsaKDKv4uvhUAUSLE+JdFZc5
    Z0a+zhRX64yi6KBaBJkbpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=m91my8Sf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=m91my8Sf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAqEarDrDn/f7Y+ZnkhIBWAJE7QvokPFWdOYHvG4+MQs/yUfv7VPyauUjN00xAiLFMVwCkDPtFebighRV0m5xXIWgnyhH5zU2UP+RIHMiJqlrGw/d6w/
    ccn+UDdGNvARLMymvlCSJlZUo4Y0GzW3TnBTFT/5tQgKxyTEg0ieheaXwY/ES29nnueXUDx4YiEw4DiKCgbFZNWjEFmZ3lFtWoVtSO7Hn/6+S9aF0yHOCFgE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=VG_YtCQ8e_QGshZ8ExUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755315AbeD3VDF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:03:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47873 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755281AbeD3VDD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:03:03 -0400
X-ME-Sender: <xms:h4TnWjXNmPC9UBQNf1hhXpCNtnewGK-U8kSzvfGXES_jZ2L2vEn_Xg>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] xen-netfront: add range check for Tx response id
Date: Mon, 30 Apr 2018 23:01:48 +0200
Message-Id: <960c6d6300fd3450ae9fb1de1c412bef7dbae992.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tx response ID is fetched from shared page, so make sure it is sane
before using it as an array index.

CC: stable@vger.kernel.org
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/net/xen-netfront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 934b8a4..55c9b25 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -394,6 +394,7 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
 				continue;
 
 			id  = txrsp.id;
+			BUG_ON(id >= NET_TX_RING_SIZE);
 			skb = queue->tx_skbs[id].skb;
 			if (unlikely(gnttab_query_foreign_access(
 				queue->grant_tx_ref[id]) != 0)) {
-- 
git-series 0.9.1
