Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBJBnq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:43:46 -0500
Received: from mout.perfora.net ([74.208.4.196]:50729 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeBJBno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:43:44 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] ARM: dts: tegra: apalis-tk1: add missing as3722 gpio0 configuration
Date: Sat, 10 Feb 2018 02:38:03 +0100
Message-Id: <20180210013806.28496-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:FQCRpJ63UOZD+pIhM5iivJMBISPsYCSlvsCAUg6w3LJ0QIJ5MI4
 DvPkps0wdZSfYb++bFFW1+VraQ7A/yXO4flr0x2UP9DNVZz7GgDfHAROFHGx7pEJIF5UkFi
 tPGyIVruzF3fcDX4bwtFfw7Z3+0cjH0DhAPE89QFoSA/1/LH9tr9AXZdpffyXDHKLyZlRHZ
 hiHnpBGBHvd7hgc+Fh3Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HV/fQQ2UpjE=:p9qluWJruJhCSlBy5XRLED
 FayxGtJIvgpes4SgiDdyQyzEL3KMbdBfT7dI7U1GRAg2AQrCiIj2+0B6fVOojJXVyW4GQRyBb
 AF1bPPiwQ1EU2cqXt+BzGhhzpJ6D7IA/TmgEQimRVlOdzj2CZdHgHXBQmppdrYnpS829a+OjG
 qNahu6fj9Fq8Uacl3ggIIKRLsk6sjb8vKLqjOSXxoNX1pRtTLlxfv377/2e2qgrvEZco/8gSb
 yn1Xy/UZMVE8cPN0UhIUgW/fUozgKPjYHkxyDpv0FpiJ6Ik1fe+DASwgH762S61O8iQ12tk1v
 QK44KVh740WsEeETs1wcNOlYMAoHzKX6RhrsSyKeiByYJkua5HNeeP3C8u/oD+oNVrDmqBysb
 FA3MkIF0+jcd/i8MY/P2+UaLpk/UUnZUOeVnQouMScFDig/4bchkW4DKHDtWi0TxNugjTPUQA
 clfibgEdgwtuXW4RDDZ5XXd15L/1G34yhccaAbU+gnKYHz1NITuG0tIfzTceLfiFZETFxEQq3
 5vdx0l2IaZbW5J1TQKmBh6f70AProjaOm9ewwEi6IzO0WuGlTj3Bl0O+yn0OAjX5+7kI7Roaa
 c6W47n6KVE6GyJ2mmItJF1BYvvV0pon66OaZPPIXJE/2xhcJvNmkumsz4PIn6gICNvDxBqV0n
 22KRrFVIA3iSlCpG/lb4gCt5Xwi/14xYq8kUn/+CduhiPOzFTdCvD8yM2zLhNJNqbR3gGsLV+
 o1ir4/eVMjqBro6AniywrsQfEZRDNClxvgtCzQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As the AS3722 GPIO0 is also a not connected on our Apalis TK1 module
explicitly configure it to high-impedance as well.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 7fbaaf221029..44c31176ce90 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1620,9 +1620,9 @@
 					bias-pull-up;
 				};
 
-				gpio1_3_4_5_6 {
-					pins = "gpio1", "gpio3", "gpio4",
-					       "gpio5", "gpio6";
+				gpio0_1_3_4_5_6 {
+					pins = "gpio0", "gpio1", "gpio3",
+					       "gpio4", "gpio5", "gpio6";
 					bias-high-impedance;
 				};
 			};
-- 
2.14.3
