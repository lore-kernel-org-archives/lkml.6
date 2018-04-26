Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756629AbeDZOVi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:21:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756433AbeDZOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:19:23 -0400
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: switch to SPDX license tag" to the asoc tree
In-Reply-To: <4df7061e4eb1d7bc13b969e81eca4ac1face3366.1524628914.git.ryder.lee@mediatek.com>
Message-Id: <E1fBhju-00040q-CF@debutante>
Date: Thu, 26 Apr 2018 15:19:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: switch to SPDX license tag

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

>From 3a280ed132aa024126630551ac97f2c53b58a90f Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 25 Apr 2018 12:19:59 +0800
Subject: [PATCH] ASoC: mediatek: switch to SPDX license tag

Add SPDX identifiers to all remaining files in sound/soc/mediatek/

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Makefile                        |  1 +
 sound/soc/mediatek/common/Makefile                 | 14 +-------------
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         | 10 +---------
 sound/soc/mediatek/common/mtk-afe-fe-dai.h         | 10 +---------
 .../soc/mediatek/common/mtk-afe-platform-driver.c  | 10 +---------
 .../soc/mediatek/common/mtk-afe-platform-driver.h  | 10 +---------
 sound/soc/mediatek/common/mtk-base-afe.h           | 10 +---------
 sound/soc/mediatek/mt2701/Makefile                 | 14 +-------------
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         | 13 ++-----------
 sound/soc/mediatek/mt2701/mt2701-reg.h             | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-max98090.c        | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          | 10 +---------
 21 files changed, 22 insertions(+), 190 deletions(-)

diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 6bcab35dc828..28679589ad2a 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
 obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index a55d33bc7b01..cdadabc5fd16 100644
--- a/sound/soc/mediatek/common/Makefile
+++ b/sound/soc/mediatek/common/Makefile
@@ -1,16 +1,4 @@
-#
-# Copyright (C) 2015 MediaTek Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-# GNU General Public License for more details.
-#
-
+# SPDX-License-Identifier: GPL-2.0
 # platform driver
 snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
 obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index ac61ff3ccbe4..cf4978be062f 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mtk-afe-fe-dais.c  --  Mediatek afe fe dai operator
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.h b/sound/soc/mediatek/common/mtk-afe-fe-dai.h
index 28cb17854da1..55074fb9861a 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.h
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtk-afe-fe-dais.h  --  Mediatek afe fe dai operator definition
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MTK_AFE_FE_DAI_H_
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 53215b52e4f2..404fbe19e1a3 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mtk-afe-platform-driver.c  --  Mediatek afe platform driver
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.h b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
index 8dcdbed959ea..1c81d911cf2a 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.h
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtk-afe-platform-driver.h  --  Mediatek afe platform driver definition
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MTK_AFE_PLATFORM_DRIVER_H_
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index e50adc9116cf..c2c5a6c5751d 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtk-base-afe.h  --  Mediatek base afe structure
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MTK_BASE_AFE_H_
diff --git a/sound/soc/mediatek/mt2701/Makefile b/sound/soc/mediatek/mt2701/Makefile
index c91deb6aca21..21d5e697cfa7 100644
--- a/sound/soc/mediatek/mt2701/Makefile
+++ b/sound/soc/mediatek/mt2701/Makefile
@@ -1,16 +1,4 @@
-#
-# Copyright (C) 2015 MediaTek Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-# GNU General Public License for more details.
-#
-
+# SPDX-License-Identifier: GPL-2.0
 # platform driver
 snd-soc-mt2701-afe-objs := mt2701-afe-pcm.o mt2701-afe-clock-ctrl.o
 obj-$(CONFIG_SND_SOC_MT2701) += snd-soc-mt2701-afe.o
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index 1793c8da521f..ae620890bb3a 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt2701-afe-clock-ctrl.c  --  Mediatek 2701 afe clock ctrl
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
  *	   Ryder Lee <ryder.lee@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include "mt2701-afe-common.h"
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
index 1957219cc3fe..580fead2ab05 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt2701-afe-clock-ctrl.h  --  Mediatek 2701 afe clock ctrl definition
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
  *	   Ryder Lee <ryder.lee@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT2701_AFE_CLOCK_CTRL_H_
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index 1ebac4bcf767..d44faba27d3c 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-common.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt2701-afe-common.h  --  Mediatek 2701 audio driver definitions
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT_2701_AFE_COMMON_H_
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 21652db6e6a3..d6eeb4c36fcc 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mediatek ALSA SoC AFE platform driver for 2701
  *
@@ -5,15 +6,6 @@
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
  *	   Ir Lian <ir.lian@mediatek.com>
  *	   Ryder Lee <ryder.lee@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/delay.h>
diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 70f61d53fe05..666282b865a8 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -1,19 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt2701-cs42448.c  --  MT2701 CS42448 ALSA SoC machine driver
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Ir Lian <ir.lian@mediatek.com>
- *              Garlic Tseng <garlic.tseng@mediatek.com>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ *	   Garlic Tseng <garlic.tseng@mediatek.com>
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/mt2701/mt2701-reg.h b/sound/soc/mediatek/mt2701/mt2701-reg.h
index dbe7d607c566..c84d14cdd7ae 100644
--- a/sound/soc/mediatek/mt2701/mt2701-reg.h
+++ b/sound/soc/mediatek/mt2701/mt2701-reg.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt2701-reg.h  --  Mediatek 2701 audio driver reg definition
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT2701_REG_H_
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index a08ce2323bdc..89f34efd9747 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt2701-wm8960.c  --  MT2701 WM8960 ALSA SoC machine driver
  *
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Ryder Lee <ryder.lee@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-common.h b/sound/soc/mediatek/mt8173/mt8173-afe-common.h
index 9a4837cc181a..396fe2355eea 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-common.h
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt8173_afe_common.h  --  Mediatek 8173 audio driver common definitions
  *
@@ -6,15 +7,6 @@
  *             Sascha Hauer <s.hauer@pengutronix.de>
  *             Hidalgo Huang <hidalgo.huang@mediatek.com>
  *             Ir Lian <ir.lian@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT8173_AFE_COMMON_H_
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 22881a9e111e..c0b6697503fd 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mediatek 8173 ALSA SoC AFE platform driver
  *
@@ -6,15 +7,6 @@
  *             Sascha Hauer <s.hauer@pengutronix.de>
  *             Hidalgo Huang <hidalgo.huang@mediatek.com>
  *             Ir Lian <ir.lian@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/delay.h>
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index b49b527a7cf9..902d111016d6 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt8173-max98090.c  --  MT8173 MAX98090 ALSA SoC machine driver
  *
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Koro Chen <koro.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 904f3ee6b0eb..582174d98c6c 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt8173-rt5650-rt5514.c  --  MT8173 machine driver with RT5650/5514 codecs
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Koro Chen <koro.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 9c61b8c099c5..b3670c8a5b8d 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt8173-rt5650-rt5676.c  --  MT8173 machine driver with RT5650/5676 codecs
  *
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Koro Chen <koro.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 84aa09d3dd98..7a89b4aad182 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt8173-rt5650.c  --  MT8173 machine driver with RT5650 codecs
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Koro Chen <koro.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
-- 
2.17.0
