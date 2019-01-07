Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B97C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369362183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887582;
	bh=k2wL+0O3lrerHgZWuZjxT3VdTEaFIlEWHmxp3/mVwgs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SlPzm+ekjQUE6ASoYuLb8UCT9SXNXL4MclNnYLzVVov4sVHFJdRrIDFD0K1Lq70IL
	 0Nt98RuONtsZmigoQISOJLLabnrX3OeWS6ssJTePbEFg7lViV8XqeO/b9ME3wGX+gI
	 dh+TkWNINk+IfbCe5KN5ef4uhTZROpgv+8gwY8rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfAGS7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43158 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfAGS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DA2s2RemSz1pcvHSbWHLwFv5bZiSM+AMu9DabOL4r1Q=; b=NEHLjoUzEOnV
        aaJ6mFInYQzkA+/aS7B5bgRcKo70QH+PuOJPMxQuMhBTwxHWWNcStdUqrxEMDGVyBaeQzDJ3EfQV/
        9Uc8MmqNseUczskJFd64lf63fYK5spLoL3sfkcLhrZq3luU8GTDEO4dvFjgpxmkhX6/2jxpYUep+6
        dI5Fw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7K-0007rh-QX; Mon, 07 Jan 2019 18:59:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7ACEA1127491; Mon,  7 Jan 2019 18:59:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Gapinski <cezary.gapinski@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: stm32: switch to SPDX identifier" to the spi tree
In-Reply-To:  <1545688840-23992-2-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185918.7ACEA1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: switch to SPDX identifier

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d57a984ff7aa1f8aac617c5ccfcd4cca061d2eb3 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:27 +0100
Subject: [PATCH] spi: stm32: switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ad1e55d3d5d5..5f30578a4224 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1,23 +1,10 @@
-/*
- * STMicroelectronics STM32 SPI Controller driver (master mode only)
- *
- * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
- * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
- *
- * License terms: GPL V2.0.
- *
- * spi_stm32 driver is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * spi_stm32 driver is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * spi_stm32 driver. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// STMicroelectronics STM32 SPI Controller driver (master mode only)
+//
+// Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+// Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
+
 #include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.20.1

