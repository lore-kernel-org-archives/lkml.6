Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424352AbeE1LdB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424353AbeE1LOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:14:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 221/272] ARM: dts: dra71-evm: Correct evm_sd regulator max voltage
Date: Mon, 28 May 2018 12:04:14 +0200
Message-Id: <20180528100259.016251066@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravikumar Kattekola <rk@ti.com>

[ Upstream commit f4aa1bd5b4fc80f5f4ecd184caad832fd62c25f7 ]

Correct vpo_sd_1v8_3v3 regulator max voltage to 3.3V

Fixes: 9868bc585ae2 ("ARM: dts: Add support for dra718-evm")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/dra71-evm.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -24,13 +24,13 @@
 
 		regulator-name = "vddshv8";
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		vin-supply = <&evm_5v0>;
 
 		gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0
-			  3000000 0x1>;
+			  3300000 0x1>;
 	};
 
 	evm_1v8_sw: fixedregulator-evm_1v8 {
