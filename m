Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeELVmY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:42:24 -0400
Received: from vern.gendns.com ([206.190.152.46]:55390 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeELVmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:42:22 -0400
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: da850-lego-ev3: remove unnecessary gpio-keys properties
Date: Sat, 12 May 2018 16:41:59 -0500
Message-Id: <20180512214159.22041-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the #address-cells and #size-cells properties from the
gpio-keys node in the da850-lego-ev3 device tree. These properties are
not needed since the child nodes don't have a reg property.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index d4a131b6a46e..3fe8db69f50c 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -33,8 +33,6 @@
 	 */
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		label = "EV3 Brick Buttons";
 		pinctrl-names = "default";
 		pinctrl-0 = <&button_bias>;
-- 
2.17.0
