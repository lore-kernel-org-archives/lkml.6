Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E3C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693552087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693552087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeLCKXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:23:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56830 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLCKXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:23:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9AB7820787; Mon,  3 Dec 2018 11:23:28 +0100 (CET)
Received: from localhost.localdomain (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 289C6206FF;
        Mon,  3 Dec 2018 11:23:18 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Update my email address
Date:   Mon,  3 Dec 2018 11:23:15 +0100
Message-Id: <20181203102315.1163-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my korg address instead of the bootlin one.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 .mailmap    | 7 ++++---
 MAINTAINERS | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 28fecafa6506..b4b0b0b768dd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,9 +36,10 @@ Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Ben Gardner <bgardner@wabtec.com>
 Ben M Cahill <ben.m.cahill@intel.com>
 Björn Steinbrink <B.Steinbrink@gmx.de>
-Boris Brezillon <boris.brezillon@bootlin.com> <boris.brezillon@free-electrons.com>
-Boris Brezillon <boris.brezillon@bootlin.com> <b.brezillon.dev@gmail.com>
-Boris Brezillon <boris.brezillon@bootlin.com> <b.brezillon@overkiz.com>
+Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
+Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
+Boris Brezillon <bbrezillon@kernel.org> <b.brezillon.dev@gmail.com>
+Boris Brezillon <bbrezillon@kernel.org> <b.brezillon@overkiz.com>
 Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
 Christoph Hellwig <hch@lst.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528dac..a22b0c23f419 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4821,7 +4821,7 @@ F:	Documentation/gpu/meson.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR ATMEL HLCDC
-M:	Boris Brezillon <boris.brezillon@bootlin.com>
+M:	Boris Brezillon <bbrezillon@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/atmel-hlcdc/
@@ -8872,7 +8872,7 @@ F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
 
 MARVELL CRYPTO DRIVER
-M:	Boris Brezillon <boris.brezillon@bootlin.com>
+M:	Boris Brezillon <bbrezillon@kernel.org>
 M:	Arnaud Ebalard <arno@natisbad.org>
 F:	drivers/crypto/marvell/
 S:	Maintained
@@ -9576,7 +9576,7 @@ F:	mm/
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	David Woodhouse <dwmw2@infradead.org>
 M:	Brian Norris <computersforpeace@gmail.com>
-M:	Boris Brezillon <boris.brezillon@bootlin.com>
+M:	Boris Brezillon <bbrezillon@kernel.org>
 M:	Marek Vasut <marek.vasut@gmail.com>
 M:	Richard Weinberger <richard@nod.at>
 L:	linux-mtd@lists.infradead.org
@@ -10166,7 +10166,7 @@ S:	Supported
 F:	drivers/net/ethernet/myricom/myri10ge/
 
 NAND FLASH SUBSYSTEM
-M:	Boris Brezillon <boris.brezillon@bootlin.com>
+M:	Boris Brezillon <bbrezillon@kernel.org>
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 R:	Richard Weinberger <richard@nod.at>
 L:	linux-mtd@lists.infradead.org
-- 
2.17.1

