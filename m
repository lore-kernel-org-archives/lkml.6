Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeEKBDp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:03:45 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:54900 "EHLO
        2.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:03:44 -0400
From: Andi Shyti <andi.shyti@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Simon Shields <simon@lineageos.org>, Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>
Subject: [PATCH v2] ARM: dts: exynos: Update x and y properties for mms114 touchscreen
Date: Fri, 11 May 2018 06:25:33 +0900
Message-Id: <20180510212533.27163-1-andi.shyti@samsung.com>
X-Mailer: git-send-email 2.17.0
X-Ovh-Tracer-Id: 13313203450621313689
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrudejgdduiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mms114 binding [1] specifies that the 'x' and 'y' should be
called respectively 'touchscreen-size-x' and 'touchscreen-size-y'
in coherence with the touchscreen [2] binding.

Update the mms114 node for trats2 and trats dts according to the
binding.

[1] Documentation/devicetree/bindings/input/touchscreen/mms114.txt
[2] Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts      | 4 ++--
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index eaeeb4f6b84a..6f1d76cb7951 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -259,8 +259,8 @@
 		reg = <0x48>;
 		interrupt-parent = <&gpx0>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-		x-size = <720>;
-		y-size = <1280>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1280>;
 		avdd-supply = <&tsp_reg>;
 		vdd-supply = <&tsp_reg>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
index 606946a264da..30eee5942eff 100644
--- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
+++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
@@ -118,8 +118,8 @@
 		reg = <0x48>;
 		interrupt-parent = <&gpm2>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		x-size = <720>;
-		y-size = <1280>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1280>;
 		avdd-supply = <&ldo23_reg>;
 		vdd-supply = <&ldo24_reg>;
 	};
-- 
2.17.0
