Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32DAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78323208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78323208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeH1ItX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:49:23 -0400
Received: from eggs.gnu.org ([208.118.235.92]:58961 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1ItX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
        (envelope-from <nikolas@gnu.org>)
        id 1fuW6C-0002Qr-Ow
        for linux-kernel@vger.kernel.org; Tue, 28 Aug 2018 00:59:31 -0400
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:34862)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <nikolas@gnu.org>)
        id 1fuW5q-0002GO-RP; Tue, 28 Aug 2018 00:59:06 -0400
Received: from pool-173-77-18-102.nycmny.east.verizon.net ([173.77.18.102]:46380 helo=acid.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <nikolas@gnu.org>)
        id 1fuW5q-0003nn-2Z; Tue, 28 Aug 2018 00:59:06 -0400
From:   Nikolas Nyby <nikolas@gnu.org>
To:     trivial@kernel.org, logang@deltatee.com, sbates@raithlin.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Cc:     Nikolas Nyby <nikolas@gnu.org>
Subject: [PATCH] lib/genalloc.c: Fix trivial typo
Date:   Tue, 28 Aug 2018 00:58:54 -0400
Message-Id: <20180828045854.27532-1-nikolas@gnu.org>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4830:134:3::e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a typo in the gen_pool_best_fit docs.

Signed-off-by: Nikolas Nyby <nikolas@gnu.org>
---
 lib/genalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index ca06adc4f445..d8f534db5562 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);
 
 /**
  * gen_pool_best_fit - find the best fitting region of memory
- * macthing the size requirement (no alignment constraint)
+ * matching the size requirement (no alignment constraint)
  * @map: The address to base the search on
  * @size: The bitmap size in bits
  * @start: The bitnumber to start searching at
-- 
2.18.0

