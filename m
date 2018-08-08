Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD40DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A2216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EV+9BtZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525A2216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeHHN11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:27:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35242 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHN10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FPIyGR+WCl6cN1sR3pIgQPVtFYejwqir+MtRmQfI9lk=; b=EV+9BtZSSSTe
        5R1v5tL6rMouIYZfapTSyJKN3JGk/1uyaS2cnCVosOWm7sM3187K7wwzXSOSGqBfouQvf2FhA9Y15
        oErTmAVEk5QkdOQJBe3Z4KV2mRFrDjZo009S31uu2EOu8qImz56hxmxrF5X2VlqXe3Y1Jzhw4/Hti
        H1A48=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnMK4-0001tR-F3; Wed, 08 Aug 2018 11:08:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 31D431124340; Wed,  8 Aug 2018 12:08:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: maxim: Add SPDX license identifiers" to the regulator tree
In-Reply-To: 
Message-Id: <20180808110812.31D431124340@debutante.sirena.org.uk>
Date:   Wed,  8 Aug 2018 12:08:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: maxim: Add SPDX license identifiers

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 5e9384c705fcfa6bf6d3937967df3ab1f5e414cb Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 7 Aug 2018 18:18:25 +0200
Subject: [PATCH] regulator: maxim: Add SPDX license identifiers

Replace GPL v2.0 and v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max14577-regulator.c        | 22 ++++--------
 drivers/regulator/max77686-regulator.c        | 32 +++++------------
 drivers/regulator/max77693-regulator.c        | 32 +++++------------
 drivers/regulator/max77802-regulator.c        | 34 +++++++------------
 drivers/regulator/max8997-regulator.c         | 30 +++++-----------
 drivers/regulator/max8998.c                   | 28 ++++-----------
 .../dt-bindings/regulator/maxim,max77802.h    |  5 +--
 7 files changed, 52 insertions(+), 131 deletions(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 0db288ce319c..bc7f4751bf9c 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -1,19 +1,9 @@
-/*
- * max14577.c - Regulator driver for the Maxim 14577/77836
- *
- * Copyright (C) 2013,2014 Samsung Electronics
- * Krzysztof Kozlowski <krzk@kernel.org>
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
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max14577.c - Regulator driver for the Maxim 14577/77836
+//
+// Copyright (C) 2013,2014 Samsung Electronics
+// Krzysztof Kozlowski <krzk@kernel.org>
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index c301f3733475..bee060937f56 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -1,26 +1,12 @@
-/*
- * max77686.c - Regulator driver for the Maxim 77686
- *
- * Copyright (C) 2012 Samsung Electronics
- * Chiwoong Byun <woong.byun@samsung.com>
- * Jonghwa Lee <jonghwa3.lee@samsung.com>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * This driver is based on max8997.c
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max77686.c - Regulator driver for the Maxim 77686
+//
+// Copyright (C) 2012 Samsung Electronics
+// Chiwoong Byun <woong.byun@samsung.com>
+// Jonghwa Lee <jonghwa3.lee@samsung.com>
+//
+// This driver is based on max8997.c
 
 #include <linux/kernel.h>
 #include <linux/bug.h>
diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index e7000e777292..077ecbbfdf76 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -1,26 +1,12 @@
-/*
- * max77693.c - Regulator driver for the Maxim 77693 and 77843
- *
- * Copyright (C) 2013-2015 Samsung Electronics
- * Jonghwa Lee <jonghwa3.lee@samsung.com>
- * Krzysztof Kozlowski <krzk@kernel.org>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * This driver is based on max77686.c
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max77693.c - Regulator driver for the Maxim 77693 and 77843
+//
+// Copyright (C) 2013-2015 Samsung Electronics
+// Jonghwa Lee <jonghwa3.lee@samsung.com>
+// Krzysztof Kozlowski <krzk@kernel.org>
+//
+// This driver is based on max77686.c
 
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index b6261903818c..c30cf5c9f2de 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -1,25 +1,15 @@
-/*
- * max77802.c - Regulator driver for the Maxim 77802
- *
- * Copyright (C) 2013-2014 Google, Inc
- * Simon Glass <sjg@chromium.org>
- *
- * Copyright (C) 2012 Samsung Electronics
- * Chiwoong Byun <woong.byun@samsung.com>
- * Jonghwa Lee <jonghwa3.lee@samsung.com>
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
- *
- * This driver is based on max8997.c
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max77802.c - Regulator driver for the Maxim 77802
+//
+// Copyright (C) 2013-2014 Google, Inc
+// Simon Glass <sjg@chromium.org>
+//
+// Copyright (C) 2012 Samsung Electronics
+// Chiwoong Byun <woong.byun@samsung.com>
+// Jonghwa Lee <jonghwa3.lee@samsung.com>
+//
+// This driver is based on max8997.c
 
 #include <linux/kernel.h>
 #include <linux/bug.h>
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 029a6ee426ab..ad0c806b0737 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -1,25 +1,11 @@
-/*
- * max8997.c - Regulator driver for the Maxim 8997/8966
- *
- * Copyright (C) 2011 Samsung Electronics
- * MyungJoo Ham <myungjoo.ham@samsung.com>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * This driver is based on max8998.c
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max8997.c - Regulator driver for the Maxim 8997/8966
+//
+// Copyright (C) 2011 Samsung Electronics
+// MyungJoo Ham <myungjoo.ham@samsung.com>
+//
+// This driver is based on max8998.c
 
 #include <linux/bug.h>
 #include <linux/err.h>
diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 6b9f262ebbb0..271bb736f3f5 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -1,24 +1,10 @@
-/*
- * max8998.c - Voltage regulator driver for the Maxim 8998
- *
- *  Copyright (C) 2009-2010 Samsung Electronics
- *  Kyungmin Park <kyungmin.park@samsung.com>
- *  Marek Szyprowski <m.szyprowski@samsung.com>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max8998.c - Voltage regulator driver for the Maxim 8998
+//
+//  Copyright (C) 2009-2010 Samsung Electronics
+//  Kyungmin Park <kyungmin.park@samsung.com>
+//  Marek Szyprowski <m.szyprowski@samsung.com>
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/include/dt-bindings/regulator/maxim,max77802.h b/include/dt-bindings/regulator/maxim,max77802.h
index cf28631d7109..d0baba1973d4 100644
--- a/include/dt-bindings/regulator/maxim,max77802.h
+++ b/include/dt-bindings/regulator/maxim,max77802.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Google, Inc
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for the Maxim 77802 PMIC regulators
  */
 
-- 
2.18.0

