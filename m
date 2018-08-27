Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE26C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221BA20C51
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221BA20C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeH0IQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 04:16:27 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:39730 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeH0IQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 04:16:27 -0400
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        by mx.tkos.co.il (Postfix) with ESMTP id 59AEC440633;
        Mon, 27 Aug 2018 07:31:30 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] MAINTAINERS: libata pata: fix Jens Axboe's email address
Date:   Mon, 27 Aug 2018 07:29:35 +0300
Message-Id: <d99162f25e4860bb04f1f56f031d11ceab1fc725.1535344175.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7634ccd2da (libata: maintainership update) added an invalid email
address. Fix that.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..9ae5cdef37a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8255,7 +8255,7 @@ F:	drivers/ata/pata_arasan_cf.c
 
 LIBATA PATA DRIVERS
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-M:	Jens Axboe <kernel.dk>
+M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
 S:	Maintained
-- 
2.18.0

