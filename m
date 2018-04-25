Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDYEUi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:20:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16193 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751249AbeDYEUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:20:17 -0400
X-UUID: d5d54df19d6147708b489d46bf9031f5-20180425
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Garlic Tseng <garlic.tseng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 6/6] ASoC: mediatek: switch to SPDX license tag
Date: Wed, 25 Apr 2018 12:19:59 +0800
Message-ID: <4df7061e4eb1d7bc13b969e81eca4ac1face3366.1524628914.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
References: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifiers to all remaining files in sound/soc/mediatek/

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 sound/soc/mediatek/Makefile                         |  1 +
 sound/soc/mediatek/common/Makefile                  | 14 +-------------
 sound/soc/mediatek/common/mtk-afe-fe-dai.c          | 10 +---------
 sound/soc/mediatek/common/mtk-afe-fe-dai.h          | 10 +---------
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 10 +---------
 sound/soc/mediatek/common/mtk-afe-platform-driver.h | 10 +---------
 sound/soc/mediatek/common/mtk-base-afe.h            | 10 +---------
 sound/soc/mediatek/mt2701/Makefile                  | 14 +-------------
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c   | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h   | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-afe-common.h       | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c          | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-cs42448.c          | 13 ++-----------
 sound/soc/mediatek/mt2701/mt2701-reg.h              | 10 +---------
 sound/soc/mediatek/mt2701/mt2701-wm8960.c           | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-afe-common.h       | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c          | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-max98090.c         | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c    | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c    | 10 +---------
 sound/soc/mediatek/mt8173/mt8173-rt5650.c           | 10 +---------
 21 files changed, 22 insertions(+), 190 deletions(-)

diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 6bcab35..2867958 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
 obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index a55d33b..cdadabc 100644
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
index ac61ff3c..cf4978b 100644
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
index 28cb178..55074fb 100644
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
index 53215b5..404fbe1 100644
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
index 8dcdbed..1c81d91 100644
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
index e50adc9..c2c5a6c 100644
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
index c91deb6..21d5e69 100644
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
index 1793c8d..ae62089 100644
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
index 1957219..580fead 100644
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
index 1ebac4b..d44faba 100644
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
index 3bc13b3..236f313 100644
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
index 70f61d5..666282b 100644
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
index dbe7d60..c84d14c 100644
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
index a08ce23..89f34ef 100644
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
index 9a4837c..396fe23 100644
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
index 22881a9..c0b6697 100644
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
index b49b527..902d111 100644
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
index 904f3ee..582174d 100644
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
index 9c61b8c..b3670c8 100644
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
index 84aa09d..7a89b4a 100644
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
1.9.1
