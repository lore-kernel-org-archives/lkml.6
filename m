Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BODY_8BITS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B855208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B855208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966217AbeFOQbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:31:42 -0400
Received: from osg.samsung.com ([64.30.133.232]:56326 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965969AbeFOQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id C00F422C42;
        Fri, 15 Jun 2018 09:31:33 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5n9WA2x1exI1; Fri, 15 Jun 2018 09:31:25 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id A79FB22B50;
        Fri, 15 Jun 2018 09:30:58 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTrcl-00083B-VY; Fri, 15 Jun 2018 13:30:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@zh-kernel.org, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v4 04/26] docs: fix broken references with multiple hints
Date:   Fri, 15 Jun 2018 13:30:32 -0300
Message-Id: <75c14f6d84eef8c10787e85ddc172afebee116d6.1529079119.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script:
	./scripts/documentation-file-ref-check --fix

Gives multiple hints for broken references on some files.
Manually use the one that applies for some files.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-gpio                     | 2 +-
 .../devicetree/bindings/display/bridge/tda998x.txt        | 2 +-
 Documentation/trace/events.rst                            | 2 +-
 Documentation/trace/tracepoint-analysis.rst               | 2 +-
 Documentation/translations/zh_CN/SubmittingDrivers        | 2 +-
 Documentation/translations/zh_CN/gpio.txt                 | 4 ++--
 MAINTAINERS                                               | 2 +-
 drivers/hid/usbhid/Kconfig                                | 2 +-
 drivers/input/Kconfig                                     | 4 ++--
 drivers/input/joystick/Kconfig                            | 4 ++--
 drivers/input/joystick/iforce/Kconfig                     | 4 ++--
 drivers/input/serio/Kconfig                               | 4 ++--
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt           | 2 +-
 drivers/video/fbdev/skeletonfb.c                          | 8 ++++----
 include/linux/tracepoint.h                                | 2 +-
 security/device_cgroup.c                                  | 2 +-
 16 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-gpio b/Documentation/ABI/obsolete/sysfs-gpio
index 32513dc2eec9..40d41ea1a3f5 100644
--- a/Documentation/ABI/obsolete/sysfs-gpio
+++ b/Documentation/ABI/obsolete/sysfs-gpio
@@ -11,7 +11,7 @@ Description:
   Kernel code may export it for complete or partial access.
 
   GPIOs are identified as they are inside the kernel, using integers in
-  the range 0..INT_MAX.  See Documentation/gpio/gpio.txt for more information.
+  the range 0..INT_MAX.  See Documentation/gpio for more information.
 
     /sys/class/gpio
 	/export ... asks the kernel to export a GPIO to userspace
diff --git a/Documentation/devicetree/bindings/display/bridge/tda998x.txt b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
index 1a4eaca40d94..f5a02f61dd36 100644
--- a/Documentation/devicetree/bindings/display/bridge/tda998x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
@@ -30,7 +30,7 @@ Optional properties:
   - nxp,calib-gpios: calibration GPIO, which must correspond with the
 	gpio used for the TDA998x interrupt pin.
 
-[1] Documentation/sound/alsa/soc/DAI.txt
+[1] Documentation/sound/soc/dai.rst
 [2] include/dt-bindings/display/tda998x.h
 
 Example:
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 1afae55dc55c..696dc69b8158 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -8,7 +8,7 @@ Event Tracing
 1. Introduction
 ===============
 
-Tracepoints (see Documentation/trace/tracepoints.txt) can be used
+Tracepoints (see Documentation/trace/tracepoints.rst) can be used
 without creating custom kernel modules to register probe functions
 using the event tracing infrastructure.
 
diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
index a4d3ff2e5efb..bef37abf4ad3 100644
--- a/Documentation/trace/tracepoint-analysis.rst
+++ b/Documentation/trace/tracepoint-analysis.rst
@@ -6,7 +6,7 @@ Notes on Analysing Behaviour Using Events and Tracepoints
 1. Introduction
 ===============
 
-Tracepoints (see Documentation/trace/tracepoints.txt) can be used without
+Tracepoints (see Documentation/trace/tracepoints.rst) can be used without
 creating custom kernel modules to register probe functions using the event
 tracing infrastructure.
 
diff --git a/Documentation/translations/zh_CN/SubmittingDrivers b/Documentation/translations/zh_CN/SubmittingDrivers
index 929385e4b194..15e73562f710 100644
--- a/Documentation/translations/zh_CN/SubmittingDrivers
+++ b/Documentation/translations/zh_CN/SubmittingDrivers
@@ -107,7 +107,7 @@ Linux 2.6:
 		程序测试的指导，请参阅
 		Documentation/power/drivers-testing.txt。有关驱动程序电
 		源管理问题相对全面的概述，请参阅
-		Documentation/power/admin-guide/devices.rst。
+		Documentation/driver-api/pm/devices.rst。
 
 管理：		如果一个驱动程序的作者还在进行有效的维护，那么通常除了那
 		些明显正确且不需要任何检查的补丁以外，其他所有的补丁都会
diff --git a/Documentation/translations/zh_CN/gpio.txt b/Documentation/translations/zh_CN/gpio.txt
index 4f8bf30a41dc..4cb1ba8b8fed 100644
--- a/Documentation/translations/zh_CN/gpio.txt
+++ b/Documentation/translations/zh_CN/gpio.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/gpio.txt
+Chinese translated version of Documentation/gpio
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -10,7 +10,7 @@ Maintainer: Grant Likely <grant.likely@secretlab.ca>
 		Linus Walleij <linus.walleij@linaro.org>
 Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
 ---------------------------------------------------------------------
-Documentation/gpio.txt 的中文翻译
+Documentation/gpio 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/MAINTAINERS b/MAINTAINERS
index cb468a535f32..653a2c29ca43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13312,7 +13312,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://alsa-project.org/main/index.php/ASoC
 S:	Supported
 F:	Documentation/devicetree/bindings/sound/
-F:	Documentation/sound/alsa/soc/
+F:	Documentation/sound/soc/
 F:	sound/soc/
 F:	include/sound/soc*
 
diff --git a/drivers/hid/usbhid/Kconfig b/drivers/hid/usbhid/Kconfig
index 0108c5991a04..e50d8fe4d36c 100644
--- a/drivers/hid/usbhid/Kconfig
+++ b/drivers/hid/usbhid/Kconfig
@@ -14,7 +14,7 @@ config USB_HID
 
 	  You can't use this driver and the HIDBP (Boot Protocol) keyboard
 	  and mouse drivers at the same time. More information is available:
-	  <file:Documentation/input/input.txt>.
+	  <file:Documentation/input/input.rst>.
 
 	  If unsure, say Y.
 
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index ff8037798779..c5992cd195a1 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -16,7 +16,7 @@ config INPUT
 
 	  Say N here if you have a headless (no monitor, no keyboard) system.
 
-	  More information is available: <file:Documentation/input/input.txt>
+	  More information is available: <file:Documentation/input/input.rst>
 
 	  If unsure, say Y.
 
@@ -144,7 +144,7 @@ config INPUT_JOYDEV
 
 	  If unsure, say Y.
 
-	  More information is available: <file:Documentation/input/joystick.txt>
+	  More information is available: <file:Documentation/input/joydev/joystick.rst>
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called joydev.
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 9591fc04a8ab..32ec4cee6716 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -9,7 +9,7 @@ menuconfig INPUT_JOYSTICK
 	  and the list of supported devices will be displayed. This option
 	  doesn't affect the kernel.
 
-	  Please read the file <file:Documentation/input/joystick.txt> which
+	  Please read the file <file:Documentation/input/joydev/joystick.rst> which
 	  contains more information.
 
 if INPUT_JOYSTICK
@@ -25,7 +25,7 @@ config JOYSTICK_ANALOG
 	  Flightstick Pro, ThrustMaster FCS, 6 and 8 button gamepads, or
 	  Saitek Cyborg joysticks.
 
-	  Please read the file <file:Documentation/input/joystick.txt> which
+	  Please read the file <file:Documentation/input/joydev/joystick.rst> which
 	  contains more information.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/input/joystick/iforce/Kconfig b/drivers/input/joystick/iforce/Kconfig
index 8fde22a021b3..ab4dbcbcbf50 100644
--- a/drivers/input/joystick/iforce/Kconfig
+++ b/drivers/input/joystick/iforce/Kconfig
@@ -27,6 +27,6 @@ config JOYSTICK_IFORCE_232
 	  connected to your serial (COM) port.
 
 	  You will need an additional utility called inputattach, see
-	  <file:Documentation/input/joystick.txt>
-	  and <file:Documentation/input/ff.txt>.
+	  <file:Documentation/input/joydev/joystick.rst>
+	  and <file:Documentation/input/ff.rst>.
 
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index ca4530eb3378..d90d9f1098ff 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -47,7 +47,7 @@ config SERIO_SERPORT
 	  Say Y here if you plan to use an input device (mouse, joystick,
 	  tablet, 6dof) that communicates over the RS232 serial (COM) port.
 
-	  More information is available: <file:Documentation/input/input.txt>
+	  More information is available: <file:Documentation/input/input.rst>
 
 	  If unsure, say Y.
 
@@ -78,7 +78,7 @@ config SERIO_PARKBD
 	  Say Y here if you built a simple parallel port adapter to attach
 	  an additional AT keyboard, XT keyboard or PS/2 mouse.
 
-	  More information is available: <file:Documentation/input/input.txt>
+	  More information is available: <file:Documentation/input/input.rst>
 
 	  If unsure, say N.
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
index 0ba6771654f7..72ba9da3d179 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
@@ -11,7 +11,7 @@ pool management for network interfaces.
 This document provides an overview the Linux DPIO driver, its
 subcomponents, and its APIs.
 
-See Documentation/dpaa2/overview.txt for a general overview of DPAA2
+See Documentation/networking/dpaa2/overview.rst for a general overview of DPAA2
 and the general DPAA2 driver architecture in Linux.
 
 Driver Overview
diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index 7f4e908330bf..812a36cb60c3 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -836,7 +836,7 @@ static void xxxfb_remove(struct pci_dev *dev)
  *	@dev: PCI device
  *	@msg: the suspend event code.
  *
- *      See Documentation/power/admin-guide/devices.rst for more information
+ *      See Documentation/driver-api/pm/devices.rst for more information
  */
 static int xxxfb_suspend(struct pci_dev *dev, pm_message_t msg)
 {
@@ -851,7 +851,7 @@ static int xxxfb_suspend(struct pci_dev *dev, pm_message_t msg)
  *	xxxfb_resume - Optional but recommended function. Resume the device.
  *	@dev: PCI device
  *
- *      See Documentation/power/admin-guide/devices.rst for more information
+ *      See Documentation/driver-api/pm/devices.rst for more information
  */
 static int xxxfb_resume(struct pci_dev *dev)
 {
@@ -915,7 +915,7 @@ static void __exit xxxfb_exit(void)
  *	@dev: platform device
  *	@msg: the suspend event code.
  *
- *      See Documentation/power/admin-guide/devices.rst for more information
+ *      See Documentation/driver-api/pm/devices.rst for more information
  */
 static int xxxfb_suspend(struct platform_device *dev, pm_message_t msg)
 {
@@ -930,7 +930,7 @@ static int xxxfb_suspend(struct platform_device *dev, pm_message_t msg)
  *	xxxfb_resume - Optional but recommended function. Resume the device.
  *	@dev: platform device
  *
- *      See Documentation/power/admin-guide/devices.rst for more information
+ *      See Documentation/driver-api/pm/devices.rst for more information
  */
 static int xxxfb_resume(struct platform_dev *dev)
 {
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..19a690b559ca 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -4,7 +4,7 @@
 /*
  * Kernel Tracepoint API.
  *
- * See Documentation/trace/tracepoints.txt.
+ * See Documentation/trace/tracepoints.rst.
  *
  * Copyright (C) 2008-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index c65b39bafdfe..cd97929fac66 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -509,7 +509,7 @@ static inline int may_allow_all(struct dev_cgroup *parent)
  * This is one of the three key functions for hierarchy implementation.
  * This function is responsible for re-evaluating all the cgroup's active
  * exceptions due to a parent's exception change.
- * Refer to Documentation/cgroups/devices.txt for more details.
+ * Refer to Documentation/cgroup-v1/devices.txt for more details.
  */
 static void revalidate_active_exceptions(struct dev_cgroup *devcg)
 {
-- 
2.17.1

