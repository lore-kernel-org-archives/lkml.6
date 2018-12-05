Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0CA20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="H0ttuS+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0CA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeLEMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:54:42 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36873 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLEMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:54:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wB5Crhot009794;
        Wed, 5 Dec 2018 21:53:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wB5Crhot009794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544014423;
        bh=6ojn8QLQxjKjZHgrqR7C529KdWUpugi1vGg10uYITdI=;
        h=From:To:Cc:Subject:Date:From;
        b=H0ttuS+gUrLHAoIjUVf2pdUCvwSgxwtWex3w22hxm1+abIZP7lxQEnovA5cqbBwfO
         NQAxrwvyJst+cdG2zjlolstdNBZKl8PaYOR/Yv/eN5I2fPFj/ikuHZicU0Af4yz29B
         bEHjk9+dV1scDdzlVo7PRbHD3uQN+0kmuWDYyu7tpfb14+UgxW1ueX+Vkwar3aOX7T
         7V1RNsLFfDhICUT8UskrSmgFPfTzA29iZf02VFf4dhR873aNsQRhFfdK2liZ7Y8cG/
         VZ6YlZhGBPJUyjY6kzO67j3wW1f/JAA+Arxn5jKBgEB2jZRjyIXg2f151eXRbEtbJo
         eXM6G6Xj7TX0g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: uniphier: convert to SPDX License Identifier
Date:   Wed,  5 Dec 2018 21:53:39 +0900
Message-Id: <1544014419-5028-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl suggests to use SPDX license tag. I am happy to
follow it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 18 ++++--------------
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      | 11 +----------
 11 files changed, 41 insertions(+), 150 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index add8e87..b2412f1 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/list.h>
 #include <linux/mfd/syscon.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 280dca7..ce7cde0 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2016-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2016-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index d2d56c9..91670913 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2016-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2016-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 03d87ad..4e7a99f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 31f36ea..2b089d1 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 4326f5c..583a2cd 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program5 is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index ae79815..92d85cc 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program5 is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 7975bd7..436e23c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index b16ce28..91d77c1 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index cb44568..8b17f23 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index c63e3c8..3b30ca0 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2015-2017 Socionext Inc.
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
 
 #ifndef __PINCTRL_UNIPHIER_H__
-- 
2.7.4

