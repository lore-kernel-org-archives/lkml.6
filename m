Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D3C21019
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D3C21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeKKBUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:20:44 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKKBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:20:44 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McHQA-1fnGOr0pa8-00cjCk; Sat, 10 Nov 2018 16:34:57 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Kauer <florian.kauer@koalo.de>
Subject: [PATCH 06/17] dma: bcm2835: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 16:34:40 +0100
Message-Id: <1541864080-7320-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:9VYSHHDq6ePopjdPZlKb+RS93ZFTzhF1QdXixEjIAgXnTuUJMgR
 J8pbJlZQALwb+Xw2aS+162jkYEWCAErqEEAK26rnODFfFosS5lytCWRQPGtz/bW0X66o7jf
 3fT41EPS4kKLSlUBjka44NXR5ZLriVeKIjVVpEUzAawrDDyGuvIaWc/1koGGW8U4gwXjq4x
 7BgrNox1Ffv/caen8XRJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+ZLEoVoU5fw=:DGGwVxMQGRktwIueI+SMpl
 NqNoLun9KxSqMOz0AT5gjsnPoA5soGqwBMEzv+pSHYkdm0elsohj4+Hr3XhOLUiTo59QWWeLc
 M0lu3epqCqcprlsbnT6M44OXeYS8O2OnCt3g7o9LAdUKYVeEP8snpLaOG9TZ+qKh407KeS18+
 ENmV/JhKbk3k+76eoP1hn/aTshclHDzAWU6aUD2xkkOzmTwJmO9Aa1Gtq0rKjBQov18SupWaV
 YFzKFf+g8djUhlAnnL6XmYI4Zf5W2ku5WI4Ai7HwcLnybF4cyl6klDyO7mmsytowNGgPKyJaZ
 MnV8wyO1vrM64xyY4owmcEUATxpsKTnNcnxdeJuyDMN8eeQHkaWjutiFJ1TlBUzTWyYKTVPtn
 mZ+Qsgq8tPEQVw4KCrcKUcRD2HxkAlqYk1Epmu+cLgvSbQx0uZOhAO8QM6pLR54YQx5TDAtHe
 +1drFDHHkbXlCs6u5Q0MDNonj9d29+G4t9hqJRlymR0G2NoXAOfW5w+knJ6Vg2hWDKgQbNdxB
 RdN4v4Yby507C4OIh9I6oK+H56iEeyQGIjb/gBjn2g6kR6H+ALwJy1+SmO3bYU0KMFLpIq/q3
 0h2OA5Gh1wCsfbB6zNZ4k8HXWOtdzmtO8grJdO6vC4fTguPlSu51VlVH+9OOgN/Z97PAJgyP8
 haEzUc6eLGKcyyTx4L4JIP4jJd4r83aor37CYBb0PMR+i45Qw6iw05h39ZZXvD0jbUCkza14M
 aURj9MzoI0hk5j0d6UTUt8Mac07a2haq7dmY/zyPPIcElSYOCHf7yV/p5iPEozNjcWi/xFz5i
 UKsw8pvujTRjwr+FCHHXP/mJO6iFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Florian Kauer <florian.kauer@koalo.de>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index ed871eb..1a44c80 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * BCM2835 DMA engine support
  *
@@ -18,16 +19,6 @@
  *
  *	MARVELL MMP Peripheral DMA Driver
  *	Copyright 2012 Marvell International Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-- 
2.7.4

