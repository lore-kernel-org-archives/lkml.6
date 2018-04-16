Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755188AbeDPMAD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:00:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754061AbeDPMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:00:02 -0400
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: max9860: switch to SPDX license tag" to the asoc tree
In-Reply-To: <20180413114751.6464-2-peda@axentia.se>
Message-Id: <E1f82nb-00006x-Jp@debutante>
Date: Mon, 16 Apr 2018 12:59:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max9860: switch to SPDX license tag

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

>From a93532dbdc8d6b96b8c51eea333cb40bfa7c490c Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Fri, 13 Apr 2018 13:47:50 +0200
Subject: [PATCH] ASoC: max9860: switch to SPDX license tag

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 31 +++++++++++--------------------
 sound/soc/codecs/max9860.h | 10 +---------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index c1bd9de5e4a3..de3d44e9199b 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -1,23 +1,14 @@
-/*
- * Driver for the MAX9860 Mono Audio Voice Codec
- *
- * https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
- *
- * The driver does not support sidetone since the DVST register field is
- * backwards with the mute near the maximum level instead of the minimum.
- *
- * Author: Peter Rosin <peda@axentia.s>
- *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the MAX9860 Mono Audio Voice Codec
+//
+// https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
+//
+// The driver does not support sidetone since the DVST register field is
+// backwards with the mute near the maximum level instead of the minimum.
+//
+// Author: Peter Rosin <peda@axentia.s>
+//         Copyright 2016 Axentia Technologies
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/max9860.h b/sound/soc/codecs/max9860.h
index 22041bd67a7d..e07b905eaf50 100644
--- a/sound/soc/codecs/max9860.h
+++ b/sound/soc/codecs/max9860.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the MAX9860 Mono Audio Voice Codec
  *
  * Author: Peter Rosin <peda@axentia.s>
  *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #ifndef _SND_SOC_MAX9860
-- 
2.17.0
