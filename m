Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELtD7rT9bUJrpnQ+XdJrTovtl6NA9Rz6vEOERFfhcxzj6Oc3Xp1Xh6XEASiGwl8SKwrmV1wZ
ARC-Seal: i=1; a=rsa-sha256; t=1520687959; cv=none;
        d=google.com; s=arc-20160816;
        b=C9/yLL6LX7pNCqnLs+k1PQo64yx0b3dZIp2VyHIgxYYjgph5hshlPBjhG+h76qWSRL
         pu9gCZfaMTe6g/UTehNbA5GKDdV3qVPL9kfEEuSNQQppK/oup944/nStz7Y0Ug42M86G
         pTdJYcaBRTZCntmG43Z7HYXixTUdKm0Z8U9adiK6Ebpa+juxlV1Yb/NIxaeqNaVfs14B
         RtI1MSywWlXZyx9zwq75askgyrjyQKLN09eytGGWY9QpIZk+EZH4e0DHwBbs97349yAw
         s75klwsB/TD/Y5b02dWAaRsyNr73ppNoD9lcIS3NX6PIqCMrNwSNgr6YQ1FTgIGcVSeS
         z6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=aTLxjWCIKLM+Nfj8y1TAkPQw3r03471mz4NiLq9eqLc=;
        b=rJGHlgCyRW9cb2DTAbrtsfpWM9IT3OOZITr2DVU5UfqGOpGtLxt2C8ItY4eeIlQANo
         XG+nnMWn3lhCHYym3t5xEltzc2SWv+ykx7mBMEJ0JmnTY8S47lCIBTJppB8fNp862aif
         IVy4LxhDnLb+2xiRLu6Ok7juzNL7OSJSQh81VBZZWm9zOUarHsMHwD4evUMOMnmOHi55
         eMMa6ds9uiZ3NLZdfBiiiQpo+qn1M2oaUZK/ZCyWTblGwo/tTAeh06M1DxjBWoRiulKV
         brugi6FDi6wUZdBYHxA9Qnj1q51n/IIC27sNfo4mD/73wrDJo5fN3USNMUDmZ6pxutkP
         wcnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=XChiQCuH;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=XChiQCuH;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2ADImIX013778
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] arm64: dts: uniphier: use proper SPDX-License-Identifier style
Date: Sat, 10 Mar 2018 22:18:41 +0900
Message-Id: <1520687921-31521-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594556897915384389?=
X-GMAIL-MSGID: =?utf-8?q?1594556897915384389?=
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

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 16 +++++++---------
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 16 +++++++---------
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 14 ++++++--------
 8 files changed, 50 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 0feec41..9b4dc41 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -1,12 +1,10 @@
-/*
- * Device Tree Source for UniPhier LD11 Global Board
- *
- * Copyright (C) 2016-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD11 Global Board
+//
+// Copyright (C) 2016-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+//           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 /dts-v1/;
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index dacdea5..b8f6273 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD11 Reference Board
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD11 Reference Board
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld11.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index f9014c8..5f2da73 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD11 SoC
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD11 SoC
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 6bee22e..fe6608e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -1,12 +1,10 @@
-/*
- * Device Tree Source for UniPhier LD20 Global Board
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD20 Global Board
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+//           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 /dts-v1/;
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 092574d..2c1a92f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD20 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD20 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld20.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 3d5ca4b..458b5b8 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD20 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD20 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 3c71087..e62d068 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs3 Reference Board
- *
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs3 Reference Board
+//
+// Copyright (C) 2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pxs3.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 234fc58..b537a3c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs3 SoC
- *
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs3 SoC
+//
+// Copyright (C) 2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
-- 
2.7.4
