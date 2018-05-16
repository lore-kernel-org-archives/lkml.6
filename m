Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeEPIvS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:51:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38084 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeEPIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:51:11 -0400
X-Google-Smtp-Source: AB8JxZrfiEVEm8J88jRCwyernwtUPzhWvPdx8nuCEI6SdGm8ozTiMRGGcG4h3CiT1LKgd029F6sPEQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2] clk: meson: use SPDX license identifiers consistently
Date: Wed, 16 May 2018 10:50:40 +0200
Message-Id: <20180516085040.6771-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace every license notices in drivers/clk/meson by SPDX license
identifiers, as described in license-rules.rst

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Changes since v1: [0]
 * GPL-2.0+ errors reported by Stephen and Fabio (Thx!)

[0]: https://lkml.kernel.org/r/20180515164229.4606-1-jbrunet@baylibre.com

 drivers/clk/meson/clk-audio-divider.c | 13 +--------
 drivers/clk/meson/clk-mpll.c          | 52 +----------------------------------
 drivers/clk/meson/clk-pll.c           | 13 +--------
 drivers/clk/meson/clk-regmap.c        |  6 ++--
 drivers/clk/meson/clk-regmap.h        |  8 ++++--
 drivers/clk/meson/clkc.h              | 13 +--------
 drivers/clk/meson/gxbb-aoclk-32k.c    |  3 +-
 drivers/clk/meson/gxbb-aoclk.c        | 51 +---------------------------------
 drivers/clk/meson/gxbb-aoclk.h        |  3 +-
 drivers/clk/meson/gxbb.c              | 15 +---------
 drivers/clk/meson/gxbb.h              | 52 +----------------------------------
 drivers/clk/meson/meson8b.c           | 16 +----------
 drivers/clk/meson/meson8b.h           | 13 +--------
 13 files changed, 20 insertions(+), 238 deletions(-)

diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
index f7ab5b1db342..58f546e04807 100644
--- a/drivers/clk/meson/clk-audio-divider.c
+++ b/drivers/clk/meson/clk-audio-divider.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2017 AmLogic, Inc.
  * Author: Jerome Brunet <jbrunet@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index d233549de244..650f75cc15a9 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -1,57 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright (c) 2016 AmLogic, Inc.
- * Author: Michael Turquette <mturquette@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING
- *
- * BSD LICENSE
- *
  * Copyright (c) 2016 AmLogic, Inc.
  * Author: Michael Turquette <mturquette@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 /*
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 65a7bd903551..3e04617ac47f 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -1,21 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  *
  * Copyright (c) 2018 Baylibre, SAS.
  * Author: Jerome Brunet <jbrunet@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index 3645fdb62343..bd8dbcbdc73c 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 BayLibre, SAS.
-// Author: Jerome Brunet <jbrunet@baylibre.com>
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
 
 #include "clk-regmap.h"
 
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index 627c888026d7..ed2d4348dbe2 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -1,6 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 BayLibre, SAS.
-// Author: Jerome Brunet <jbrunet@baylibre.com>
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
 
 #ifndef __CLK_REGMAP_H
 #define __CLK_REGMAP_H
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 8cc265cd3d2b..2fb084330ee9 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef __CLKC_H
diff --git a/drivers/clk/meson/gxbb-aoclk-32k.c b/drivers/clk/meson/gxbb-aoclk-32k.c
index 491634dbc985..680467141a1d 100644
--- a/drivers/clk/meson/gxbb-aoclk-32k.c
+++ b/drivers/clk/meson/gxbb-aoclk-32k.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2017 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * SPDX-License-Identifier: GPL-2.0+
  */
 
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 408e3e2fca18..42ed61d3c3fb 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -1,56 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING.
- *
- * BSD LICENSE
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index 65962fc9ecdc..3aa638d4ed21 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2017 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * SPDX-License-Identifier: GPL-2.0+
  */
 
 #ifndef __GXBB_AOCLKC_H
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index a893b1edda22..240658404367 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * AmLogic S905 / GXBB Clock Controller Driver
- *
  * Copyright (c) 2016 AmLogic, Inc.
  * Michael Turquette <mturquette@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index b3ef54f65a9d..ec1a812bf1fd 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -1,57 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright (c) 2016 AmLogic, Inc.
  * Author: Michael Turquette <mturquette@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING
- *
- * BSD LICENSE
- *
- * Copyright (c) 2016 BayLibre, Inc.
- * Author: Michael Turquette <mturquette@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifndef __GXBB_H
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index e6e9a9db1095..54dcb60f2dd5 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * AmLogic S802 (Meson8) / S805 (Meson8b) / S812 (Meson8m2) Clock Controller
- * Driver
- *
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  *
  * Copyright (c) 2016 BayLibre, Inc.
  * Michael Turquette <mturquette@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index a687dc60b6d0..5d09412b5084 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -1,21 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  *
  * Copyright (c) 2016 BayLibre, Inc.
  * Michael Turquette <mturquette@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef __MESON8B_H
-- 
2.14.3
