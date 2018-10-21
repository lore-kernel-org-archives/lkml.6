Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1AAECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD2D20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD2D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJUTxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 15:53:00 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:42348 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJUTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 15:53:00 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Oct 2018 15:53:00 EDT
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 31A1A1A40228; Sun, 21 Oct 2018 04:33:03 -0700 (PDT)
Date:   Sun, 21 Oct 2018 04:33:03 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] af_unix.h: trivial whitespace cleanup
Message-ID: <20181021113303.wohss6rb3qi6tphv@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spurious spaces with a tab and remove superfluous tab from
unix_sock struct.

Signed-off-by: Vito Caputo <vcaputo@pengaru.com>
---
 include/net/af_unix.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index a5ba41b3b867..e2695c4bf358 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -52,7 +52,7 @@ struct unix_skb_parms {
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
 	struct sock		sk;
-	struct unix_address     *addr;
+	struct unix_address	*addr;
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
@@ -63,7 +63,7 @@ struct unix_sock {
 #define UNIX_GC_CANDIDATE	0
 #define UNIX_GC_MAYBE_CYCLE	1
 	struct socket_wq	peer_wq;
-	wait_queue_entry_t		peer_wake;
+	wait_queue_entry_t	peer_wake;
 };
 
 static inline struct unix_sock *unix_sk(const struct sock *sk)
-- 
2.11.0

