Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE36C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE36C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeH2MKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42392 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbeH2MKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68C85207EB; Wed, 29 Aug 2018 10:14:50 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3D5882072F;
        Wed, 29 Aug 2018 10:14:50 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] MAINTAINERS: remove myself as FBTFT maintainer
Date:   Wed, 29 Aug 2018 10:14:48 +0200
Message-Id: <20180829081448.20374-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though I did introduce the fbtft code in staging a while ago to
stop seeing this being developed out-of-tree, I don't intend to
maintain it, and I don't use it actively. So be honest and remove
myself from the MAINTAINERS file for this subsystem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..1820f2e4d5f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5623,8 +5623,7 @@ F:	Documentation/fault-injection/
 F:	lib/fault-inject.c
 
 FBTFT Framebuffer drivers
-M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-S:	Maintained
+S:	Orphan
 F:	drivers/staging/fbtft/
 
 FC0011 TUNER DRIVER
-- 
2.14.4

