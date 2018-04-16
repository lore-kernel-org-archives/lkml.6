Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbeDPLjr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:39:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeDPLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:39:46 -0400
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: tfa9879: switch to SPDX license tag" to the asoc tree
In-Reply-To: <20180413114751.6464-3-peda@axentia.se>
Message-Id: <E1f82U4-0007XJ-Os@debutante>
Date: Mon, 16 Apr 2018 12:39:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tfa9879: switch to SPDX license tag

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3d5fa5270b1f4cc47b300a943b2a82727c6c6b07 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Fri, 13 Apr 2018 13:47:51 +0200
Subject: [PATCH] ASoC: tfa9879: switch to SPDX license tag

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tfa9879.c | 18 ++++++------------
 sound/soc/codecs/tfa9879.h |  7 +------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 4ed020262a27..abc114a3ae2b 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -1,15 +1,9 @@
-/*
- * tfa9879.c  --  driver for NXP Semiconductors TFA9879
- *
- * Copyright (C) 2014 Axentia Technologies AB
- * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// tfa9879.c  --  driver for NXP Semiconductors TFA9879
+//
+// Copyright (C) 2014 Axentia Technologies AB
+// Author: Peter Rosin <peda@axentia.se>
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/sound/soc/codecs/tfa9879.h b/sound/soc/codecs/tfa9879.h
index 3408c90c4628..66c88d0396fe 100644
--- a/sound/soc/codecs/tfa9879.h
+++ b/sound/soc/codecs/tfa9879.h
@@ -1,14 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * tfa9879.h  --  driver for NXP Semiconductors TFA9879
  *
  * Copyright (C) 2014 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #ifndef _TFA9879_H
-- 
2.17.0
