Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELuBsmQcz7k5d0WJ7L3gEpwGCisc7e5C1G5pTHCK8SG0N229FmAUTB7UmcXN5iZEin9aHBHH
ARC-Seal: i=1; a=rsa-sha256; t=1520687943; cv=none;
        d=google.com; s=arc-20160816;
        b=cJtPJoCqd6BX66CGe4TjA2re3789v0oDeZJR6DjgTV5IGNeBWpCJhObzMUdYFgu6ff
         ZM24TzGERGbC4dHyX/wB7GqvMlwI1FrYDtRvVbpyXiCHjRcPLGgea6uxi2+HYc/f8KLS
         iOZ85ow7HVZ+Kzv7IqCYG2W9QCikNUDc8K50feEPrc15/SDNjHoZsgOOl689cZNcO9nb
         l9oIrQV2ztk9EizKYtTw5FOl4ehj+zWu5kInprI4FrSeXgs360B3Lx1QD4WXQ4JeBovU
         dfAfiAMVgGe5CBbouKCprYHyxGjxtYZHEyKKVTtWL2nuduQuwcSrYcN+H589RQBqdl6E
         VNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=pGmV9cTVuHJMW/62rfCRxqlARoTSA+CIUe5nLjdhDbw=;
        b=UFauR6yfR/V8lPMNQicx+5efwETUXvdM2Z0aCT9kEcV42j/uC9FQuKOv6nLf8d3byi
         0TyN7VEuGVQObOyJzRFF89dSfMtMrqVZMKLcZYfUpxdoluyoYAdjFq0UlxN9cWgQ1Lgr
         oIyyK5LTPR0GFTwLvZMEYFs46EIDNit0rh1szzKJINU10svU0hWS6JuBsrnYxQAcutmJ
         sXKytWXpttVJ+uSVnOEyA9bCKW1FgZJO8wVi7c0pr2YX/jbwrQKkHRqZYRdcnZ3hmZ86
         2p+Hwn+CuJ6IbDAwP0Qe470onMddyWoRo7wLJ7zJQM0CfcP57E2kZZCAbKPraTKWAueE
         bfpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oOr5AZIj;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oOr5AZIj;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2ADIRTK006498
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: dts: uniphier: use proper SPDX-License-Identifier style
Date: Sat, 10 Mar 2018 22:18:01 +0900
Message-Id: <1520687881-31399-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594556880760719962?=
X-GMAIL-MSGID: =?utf-8?q?1594556880760719962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

According to Documentation/process/license-rules.rst, move the SPDX
License Identifier to the very top of the file.  I used C++ comment
style not only for the SPDX line but for the entire block because
this seems Linus' preference [1].  I also dropped the parentheses to
follow the examples in that document.

[1] https://lkml.org/lkml/2017/11/25/133

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts       | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ld4.dtsi          | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ld6b.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pinctrl.dtsi      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4-ace.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4-ref.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4-sanji.dts    | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro5.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts    | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pxs2.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi | 14 ++++++--------
 arch/arm/boot/dts/uniphier-sld8-ref.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-sld8.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-support-card.dtsi | 14 ++++++--------
 17 files changed, 102 insertions(+), 136 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index a3afd0c..21407e1 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD4 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD4 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 0459e84..37950ad 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD4 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD4 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 9327f6b..a0a44a4 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD6b Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD6b Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld6b.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ld6b.dtsi b/arch/arm/boot/dts/uniphier-ld6b.dtsi
index 9a7b25c..4d07a94 100644
--- a/arch/arm/boot/dts/uniphier-ld6b.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld6b.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD6b SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD6b SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /*
  * LD6b consists of two silicon dies: D-chip and A-chip.
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index de481c3..0468d9a 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier SoCs default pinctrl settings
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier SoCs default pinctrl settings
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 &pinctrl {
 	pinctrl_aout: aout {
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 92b5cbb..db1b089 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 Ace Board
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 Ace Board
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pro4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 629bc14..efb0849 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pro4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index 7c4326a..dac4d66 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 Sanji Board
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 Sanji Board
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pro4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index f77d739..844124b 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index f291dd6..06c2cef 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro5 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro5 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 / {
 	compatible = "socionext,uniphier-pro5";
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index d09acb8..59608de 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs2 Gentil Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs2 Gentil Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pxs2.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 6f13a25..4170676 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs2 Vodka Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs2 Vodka Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pxs2.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 18f336e..c0a8207 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs2 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs2 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
index 7a1c29b..04e60c2 100644
--- a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
+++ b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Reference Daughter Board
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Reference Daughter Board
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 &i2c0 {
 	eeprom@50 {
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index e052ea3..fe386fa 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier sLD8 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier sLD8 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-sld8.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index bc8c240..e9b9b4f 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier sLD8 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier sLD8 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index e4e7e1b..bf441c2 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Support Card (Expansion Board)
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Support Card (Expansion Board)
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 &system_bus {
 	status = "okay";
-- 
2.7.4
