Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeD0Kxr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:53:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeD0Kxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:53:45 -0400
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: remove boilerplate from lisence comment" to the asoc tree
In-Reply-To: <20180427052734.3506-1-suzuki.katsuhiro@socionext.com>
Message-Id: <E1fC10U-0003Q0-5e@debutante>
Date: Fri, 27 Apr 2018 11:53:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: remove boilerplate from lisence comment

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

>From e19f77ee0e8ade56564dad07f904b75dd5c37e31 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 27 Apr 2018 14:27:34 +0900
Subject: [PATCH] ASoC: uniphier: remove boilerplate from lisence comment

This patch removes boilerplate of GPLv2, use only SPDX identifier as
same as other recently ASoC DAI drivers.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-compress.c | 13 -------------
 sound/soc/uniphier/aio-core.c     | 13 -------------
 sound/soc/uniphier/aio-cpu.c      | 13 -------------
 sound/soc/uniphier/aio-dma.c      | 13 -------------
 sound/soc/uniphier/aio-ld11.c     | 13 -------------
 sound/soc/uniphier/aio-reg.h      | 13 -------------
 sound/soc/uniphier/aio.h          | 13 -------------
 7 files changed, 91 deletions(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 4c1027aa615e..17f773ac5ca1 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO Compress Audio driver.
 //
 // Copyright (c) 2017-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 6d50042a4571..e37b80921abb 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO ALSA common driver.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 1e5eb8e6f8c7..00b6441bf195 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO ALSA CPU DAI driver.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/clk.h>
 #include <linux/errno.h>
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index ef7bafa8e171..4ec6b65bfb44 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO DMA driver.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index 4c4dd3dd4dee..ab04d3331be9 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO ALSA driver for LD11/LD20.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/module.h>
 
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
index 136d3563cf44..511ea3c01847 100644
--- a/sound/soc/uniphier/aio-reg.h
+++ b/sound/soc/uniphier/aio-reg.h
@@ -3,19 +3,6 @@
  * Socionext UniPhier AIO ALSA driver.
  *
  * Copyright (c) 2016-2018 Socionext Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef SND_UNIPHIER_AIO_REG_H__
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 8cab4a553a97..52670126084f 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -3,19 +3,6 @@
  * Socionext UniPhier AIO ALSA driver.
  *
  * Copyright (c) 2016-2018 Socionext Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef SND_UNIPHIER_AIO_H__
-- 
2.17.0
