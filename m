Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZpX6ZakOinE+sz2lnItootKx/G+x34BP4yFC1Xk5hajHLiRWP8r3NTMPmRRAzk8ssxUatG+
ARC-Seal: i=1; a=rsa-sha256; t=1525871981; cv=none;
        d=google.com; s=arc-20160816;
        b=xSGBGBceBg0pbLXPHpKawFY+5eIzlqtcWdkD8hAw9Dpz8Wfr1EDSZF2EEg66O1Vazj
         d35pUmeJ2GJhu9vUFVg2kPINaHELB02WTU9qTbA0moV9bVnNbRH3hijnW/7y1JCsCxIR
         ou1V516gSwiJxGy9uI0qS58y8DoUGTkFvEDgG4N+e7a3NfkX8nVJ1vGfL82tfv8zsQPe
         t7afGyOccnZ/RBKI8EbzhWtd0S1CqRipE95QSaX7QjFiKorBs42wYVd88gt5zlfA6lFy
         rXI0IWs4CQe+fX66xzvWSHXmJVT4ahyKbAHROTJO70U5MVcULPbB5ZE4uq3g/0/vbpoJ
         VcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:content-transfer-encoding:references:in-reply-to
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=eTfejPfCRQf2N4sZMEJYPWP1f1y8WWcZoxs6en2Qu/0=;
        b=M21oa/y1A5QsM0GhOu4bNzG5bFqmINd+EtlzUhuJTfaRw/b5bPv1BlphSMp92H7RBo
         gobQshn4oyaBi9AEeCGgs90nz+A5LwyFzOVKKRUGq6ZvGgrcRm8gC+EzUDndLW6sz+04
         F/IOF5pBbxfpIhhmfZWTpiUaxKyscdpz2n7AZaxlIeWe9kZTd7GBE7SllrMBCDuRDJPS
         axagptTygIUir6HCyRWtAGD9wTvWP1xD0TX1mgb0GKXE5V0GYyHSZWm0GkKGKCcAYIDe
         qgMp3TK1ZkTsePkp36WdptOS4681uZwGZfvsKGmyW8oG1aKGSXVG/h0NtiFQBd4wdrUV
         LJuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	David Airlie <airlied@linux.ie>,
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
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@zh-kernel.org,
	linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 11/11] docs: fix broken references with multiple hints
Date: Wed,  9 May 2018 10:18:54 -0300
Message-Id: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992738415856815?=
X-GMAIL-MSGID: =?utf-8?q?1599992738415856815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The script:
	./scripts/documentation-file-ref-check --fix-rst

Gives multiple hints for broken references on some files.
Manually use the one that applies for some files.

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
 drivers/input/joystick/iforce/Kconfig                     | 2 +-
 drivers/input/serio/Kconfig                               | 4 ++--
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt           | 2 +-
 drivers/video/fbdev/skeletonfb.c                          | 8 ++++----
 include/linux/tracepoint.h                                | 2 +-
 security/device_cgroup.c                                  | 2 +-
 16 files changed, 23 insertions(+), 23 deletions(-)

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
index 24cc2466185a..3484af33c879 100644
--- a/Documentation/devicetree/bindings/display/bridge/tda998x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
@@ -27,7 +27,7 @@ Optional properties:
 	in question is used. The implementation allows one or two DAIs. If two
 	DAIs are defined, they must be of different type.
 
-[1] Documentation/sound/alsa/soc/DAI.txt
+[1] Documentation/sound/soc/dai.rst
 [2] include/dt-bindings/display/tda998x.h
 
 Example:
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 7b6b1236ec2e..c292117b83a9 100644
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
index b0c9c21f129d..716326b9f152 100644
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
index 8e21c5d826ff..0eec80698cf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13149,7 +13149,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
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
index 242c6a88d9cc..d8f9c6e1fc08 100644
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
index 1eea5fd6a5c5..ab4dbcbcbf50 100644
--- a/drivers/input/joystick/iforce/Kconfig
+++ b/drivers/input/joystick/iforce/Kconfig
@@ -27,6 +27,6 @@ config JOYSTICK_IFORCE_232
 	  connected to your serial (COM) port.
 
 	  You will need an additional utility called inputattach, see
-	  <file:Documentation/input/joystick.txt>
+	  <file:Documentation/input/joydev/joystick.rst>
 	  and <file:Documentation/input/ff.rst>.
 
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
2.17.0
