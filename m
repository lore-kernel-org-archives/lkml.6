Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeBQTkT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:40:19 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36870 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbeBQTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:40:17 -0500
X-Google-Smtp-Source: AH8x226Sp1Zuf358HUzZhAYoJGvv1GoZmjVs8QfpZfUQIBXR0xhvNgHN1NHSDZP9B5hsLvtf4vaXvw==
Date: Sat, 17 Feb 2018 20:39:55 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: w@1wt.eu, geert@linux-m68k.org, triad@df.lth.se, robin@protonic.nl,
        paul.burton@mips.com, linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
Message-ID: <20180217193955.shfhvp3afwiurzfm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <triad@df.lth.se>
Cc: Robin van der Gracht <robin@protonic.nl>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
Please let me know if you agree for your files and I will queue it up.
Thanks!

 drivers/auxdisplay/arm-charlcd.c        |  2 +-
 drivers/auxdisplay/cfag12864b.c         | 16 +---------------
 drivers/auxdisplay/cfag12864bfb.c       | 16 +---------------
 drivers/auxdisplay/charlcd.c            |  6 +-----
 drivers/auxdisplay/hd44780.c            |  6 +-----
 drivers/auxdisplay/ht16k33.c            | 10 +---------
 drivers/auxdisplay/img-ascii-lcd.c      |  6 +-----
 drivers/auxdisplay/ks0108.c             | 16 +---------------
 drivers/auxdisplay/panel.c              |  6 +-----
 include/linux/cfag12864b.h              | 16 +---------------
 include/linux/ks0108.h                  | 16 +---------------
 samples/auxdisplay/cfag12864b-example.c | 16 +---------------
 12 files changed, 12 insertions(+), 120 deletions(-)

diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
index b3176ee92b90..ec5bd065d0d5 100644
--- a/drivers/auxdisplay/arm-charlcd.c
+++ b/drivers/auxdisplay/arm-charlcd.c
@@ -1,10 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for the on-board character LCD found on some ARM reference boards
  * This is basically an Hitachi HD44780 LCD with a custom IP block to drive it
  * http://en.wikipedia.org/wiki/HD44780_Character_LCD
  * Currently it will just display the text "ARM Linux" and the linux version
  *
- * License terms: GNU General Public License (GPL) version 2
  * Author: Linus Walleij <triad@df.lth.se>
  */
 #include <linux/init.h>
diff --git a/drivers/auxdisplay/cfag12864b.c b/drivers/auxdisplay/cfag12864b.c
index 41ce4bd96813..6bd2f65e116a 100644
--- a/drivers/auxdisplay/cfag12864b.c
+++ b/drivers/auxdisplay/cfag12864b.c
@@ -1,26 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Filename: cfag12864b.c
  *     Version: 0.1.0
  * Description: cfag12864b LCD driver
- *     License: GPLv2
  *     Depends: ks0108
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis
  *        Date: 2006-10-31
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #include <linux/init.h>
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index a3874034e2ce..898d14ca8ac8 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -1,26 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Filename: cfag12864bfb.c
  *     Version: 0.1.0
  * Description: cfag12864b LCD framebuffer driver
- *     License: GPLv2
  *     Depends: cfag12864b
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis
  *        Date: 2006-10-31
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #include <linux/init.h>
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 642afd88870b..dc187a7a1a67 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Character LCD driver for Linux
  *
  * Copyright (C) 2000-2008, Willy Tarreau <w@1wt.eu>
  * Copyright (C) 2016-2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/atomic.h>
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 036eec404289..78d8f1986fec 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * HD44780 Character LCD driver for Linux
  *
  * Copyright (C) 2000-2008, Willy Tarreau <w@1wt.eu>
  * Copyright (C) 2016-2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index fbfa5b4cc567..a43276c76fc6 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * HT16K33 driver
  *
  * Author: Robin van der Gracht <robin@protonic.nl>
  *
  * Copyright: (C) 2016 Protonic Holland.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 9180b9bd5821..85d964c4b7b2 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -1,11 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Imagination Technologies
  * Author: Paul Burton <paul.burton@mips.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 
 #include <generated/utsrelease.h>
diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index 816de9eaac26..abfe3fa9e6f4 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -1,26 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Filename: ks0108.c
  *     Version: 0.1.0
  * Description: ks0108 LCD Controller driver
- *     License: GPLv2
  *     Depends: parport
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis
  *        Date: 2006-10-31
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index ea7869c0d7f9..ab8f2a374864 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Front panel driver for Linux
  * Copyright (C) 2000-2008, Willy Tarreau <w@1wt.eu>
  * Copyright (C) 2016-2017 Glider bvba
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * This code drives an LCD module (/dev/lcd), and a keypad (/dev/keypad)
  * connected to a parallel printer port.
  *
diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
index b454dfce60d9..aa960efc32f6 100644
--- a/include/linux/cfag12864b.h
+++ b/include/linux/cfag12864b.h
@@ -1,25 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Filename: cfag12864b.h
  *     Version: 0.1.0
  * Description: cfag12864b LCD driver header
- *     License: GPLv2
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis
  *        Date: 2006-10-12
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #ifndef _CFAG12864B_H_
diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
index cb311798e0bc..2a1c985fedea 100644
--- a/include/linux/ks0108.h
+++ b/include/linux/ks0108.h
@@ -1,25 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Filename: ks0108.h
  *     Version: 0.1.0
  * Description: ks0108 LCD Controller driver header
- *     License: GPLv2
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis
  *        Date: 2006-10-31
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #ifndef _KS0108_H_
diff --git a/samples/auxdisplay/cfag12864b-example.c b/samples/auxdisplay/cfag12864b-example.c
index e7823ffb1ca0..85571e90191f 100644
--- a/samples/auxdisplay/cfag12864b-example.c
+++ b/samples/auxdisplay/cfag12864b-example.c
@@ -1,25 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Filename: cfag12864b-example.c
  *     Version: 0.1.0
  * Description: cfag12864b LCD userspace example program
- *     License: GPLv2
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis
  *        Date: 2006-10-31
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 /*
-- 
2.14.1
