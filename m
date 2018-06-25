Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3A9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5503125A6E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5503125A6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeFYNbH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:31:07 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:56204 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933583AbeFYNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:31:05 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2018 09:31:05 EDT
Received: from faui49man10 (faui49man10.informatik.uni-erlangen.de [131.188.42.182])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 813AF58C4B6;
        Mon, 25 Jun 2018 15:21:55 +0200 (CEST)
Received: by faui49man10 (sSMTP sendmail emulation); Mon, 25 Jun 2018 15:21:55 +0200
From:   Daniel Graefe <daniel.graefe@fau.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.graefe@fau.de,
        linux-kernel@i4.cs.fau.de, Roman Sommer <roman.sommer@fau.de>
Subject: [PATCH] staging: media: omap4iss: Added SPDX license identifiers
Date:   Mon, 25 Jun 2018 15:21:32 +0200
Message-Id: <1529932892-9036-1-git-send-email-daniel.graefe@fau.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing SPDX license identifiers to all files of the omap4iss
driver.

Most files already have license texts which clearly state them to be
licensed under GPL 2.0 or later. SPDX identifiers were added accordingly.

Some files do not have any license text. SPDX identifiers for GPL 2.0
were added to them, in accordance with the default license of the
kernel.

Signed-off-by: Daniel Graefe <daniel.graefe@fau.de>
Signed-off-by: Roman Sommer <roman.sommer@fau.de>
---
 drivers/staging/media/omap4iss/Kconfig       | 2 ++
 drivers/staging/media/omap4iss/Makefile      | 3 +++
 drivers/staging/media/omap4iss/iss.c         | 1 +
 drivers/staging/media/omap4iss/iss.h         | 1 +
 drivers/staging/media/omap4iss/iss_csi2.c    | 1 +
 drivers/staging/media/omap4iss/iss_csi2.h    | 1 +
 drivers/staging/media/omap4iss/iss_csiphy.c  | 1 +
 drivers/staging/media/omap4iss/iss_csiphy.h  | 1 +
 drivers/staging/media/omap4iss/iss_ipipe.c   | 1 +
 drivers/staging/media/omap4iss/iss_ipipe.h   | 1 +
 drivers/staging/media/omap4iss/iss_ipipeif.c | 1 +
 drivers/staging/media/omap4iss/iss_ipipeif.h | 1 +
 drivers/staging/media/omap4iss/iss_regs.h    | 1 +
 drivers/staging/media/omap4iss/iss_resizer.c | 1 +
 drivers/staging/media/omap4iss/iss_resizer.h | 1 +
 drivers/staging/media/omap4iss/iss_video.c   | 1 +
 drivers/staging/media/omap4iss/iss_video.h   | 1 +
 17 files changed, 20 insertions(+)

diff --git a/drivers/staging/media/omap4iss/Kconfig b/drivers/staging/media/omap4iss/Kconfig
index dddd273..841cc0b 100644
--- a/drivers/staging/media/omap4iss/Kconfig
+++ b/drivers/staging/media/omap4iss/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 config VIDEO_OMAP4
 	tristate "OMAP 4 Camera support"
 	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && I2C
diff --git a/drivers/staging/media/omap4iss/Makefile b/drivers/staging/media/omap4iss/Makefile
index a716ce9..e64d489 100644
--- a/drivers/staging/media/omap4iss/Makefile
+++ b/drivers/staging/media/omap4iss/Makefile
@@ -1,4 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
 # Makefile for OMAP4 ISS driver
+#
 
 omap4-iss-objs += \
 	iss.o iss_csi2.o iss_csiphy.o iss_ipipeif.o iss_ipipe.o iss_resizer.o iss_video.o
diff --git a/drivers/staging/media/omap4iss/iss.c b/drivers/staging/media/omap4iss/iss.c
index b1036ba..0c41939 100644
--- a/drivers/staging/media/omap4iss/iss.c
+++ b/drivers/staging/media/omap4iss/iss.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver
  *
diff --git a/drivers/staging/media/omap4iss/iss.h b/drivers/staging/media/omap4iss/iss.h
index 760ee27..b16a5c0 100644
--- a/drivers/staging/media/omap4iss/iss.h
+++ b/drivers/staging/media/omap4iss/iss.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver
  *
diff --git a/drivers/staging/media/omap4iss/iss_csi2.c b/drivers/staging/media/omap4iss/iss_csi2.c
index f6acc54..cdfd12f 100644
--- a/drivers/staging/media/omap4iss/iss_csi2.c
+++ b/drivers/staging/media/omap4iss/iss_csi2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver - CSI PHY module
  *
diff --git a/drivers/staging/media/omap4iss/iss_csi2.h b/drivers/staging/media/omap4iss/iss_csi2.h
index 24ab378..cee02ee 100644
--- a/drivers/staging/media/omap4iss/iss_csi2.h
+++ b/drivers/staging/media/omap4iss/iss_csi2.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - CSI2 module
  *
diff --git a/drivers/staging/media/omap4iss/iss_csiphy.c b/drivers/staging/media/omap4iss/iss_csiphy.c
index 748607f..253b6aa 100644
--- a/drivers/staging/media/omap4iss/iss_csiphy.c
+++ b/drivers/staging/media/omap4iss/iss_csiphy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver - CSI PHY module
  *
diff --git a/drivers/staging/media/omap4iss/iss_csiphy.h b/drivers/staging/media/omap4iss/iss_csiphy.h
index a0f2d97..f264c51 100644
--- a/drivers/staging/media/omap4iss/iss_csiphy.h
+++ b/drivers/staging/media/omap4iss/iss_csiphy.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - CSI PHY module
  *
diff --git a/drivers/staging/media/omap4iss/iss_ipipe.c b/drivers/staging/media/omap4iss/iss_ipipe.c
index d86ef8a..9f90641 100644
--- a/drivers/staging/media/omap4iss/iss_ipipe.c
+++ b/drivers/staging/media/omap4iss/iss_ipipe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver - ISP IPIPE module
  *
diff --git a/drivers/staging/media/omap4iss/iss_ipipe.h b/drivers/staging/media/omap4iss/iss_ipipe.h
index d5b441d..54718f0 100644
--- a/drivers/staging/media/omap4iss/iss_ipipe.h
+++ b/drivers/staging/media/omap4iss/iss_ipipe.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - ISP IPIPE module
  *
diff --git a/drivers/staging/media/omap4iss/iss_ipipeif.c b/drivers/staging/media/omap4iss/iss_ipipeif.c
index cb88b2b..6cc9a43 100644
--- a/drivers/staging/media/omap4iss/iss_ipipeif.c
+++ b/drivers/staging/media/omap4iss/iss_ipipeif.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver - ISP IPIPEIF module
  *
diff --git a/drivers/staging/media/omap4iss/iss_ipipeif.h b/drivers/staging/media/omap4iss/iss_ipipeif.h
index bad32b1..f915aa0 100644
--- a/drivers/staging/media/omap4iss/iss_ipipeif.h
+++ b/drivers/staging/media/omap4iss/iss_ipipeif.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - ISP IPIPEIF module
  *
diff --git a/drivers/staging/media/omap4iss/iss_regs.h b/drivers/staging/media/omap4iss/iss_regs.h
index cb415e8..274dd97 100644
--- a/drivers/staging/media/omap4iss/iss_regs.h
+++ b/drivers/staging/media/omap4iss/iss_regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - Register defines
  *
diff --git a/drivers/staging/media/omap4iss/iss_resizer.c b/drivers/staging/media/omap4iss/iss_resizer.c
index 4bbfa20..2d02a86 100644
--- a/drivers/staging/media/omap4iss/iss_resizer.c
+++ b/drivers/staging/media/omap4iss/iss_resizer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver - ISP RESIZER module
  *
diff --git a/drivers/staging/media/omap4iss/iss_resizer.h b/drivers/staging/media/omap4iss/iss_resizer.h
index 8b7c5fe..8b16b31 100644
--- a/drivers/staging/media/omap4iss/iss_resizer.h
+++ b/drivers/staging/media/omap4iss/iss_resizer.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - ISP RESIZER module
  *
diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index a3a8342..39ffba0 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * TI OMAP4 ISS V4L2 Driver - Generic video node
  *
diff --git a/drivers/staging/media/omap4iss/iss_video.h b/drivers/staging/media/omap4iss/iss_video.h
index d7e05d0..3acbb38 100644
--- a/drivers/staging/media/omap4iss/iss_video.h
+++ b/drivers/staging/media/omap4iss/iss_video.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * TI OMAP4 ISS V4L2 Driver - Generic video node
  *
-- 
2.7.4

