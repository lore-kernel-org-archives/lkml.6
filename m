Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCUMIm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:08:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36305 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeCUMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:08:30 -0400
X-Google-Smtp-Source: AG47ELtMsRIENyyT3KjRR4yCGaSQVq7QLEwMA8VL0NN0TJ1jb/gAh6yBo1cORG4MxZrf1ZEaQ4grig==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/8] ARM: davinci: dts: add a reset control to the dsp node
Date: Wed, 21 Mar 2018 13:08:02 +0100
Message-Id: <20180321120807.18032-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180321120807.18032-1-brgl@bgdev.pl>
References: <20180321120807.18032-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The davinci-rproc driver will soon use the reset framework. Add the
resets property to the dsp node in da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 89af749c5b6f..5b485e44b83e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -124,6 +124,7 @@
 			compatible = "ti,da850-psc0";
 			reg = <0x10000 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
 				 <&pll0_sysclk 4>, <&pll0_sysclk 6>,
-- 
2.16.1
