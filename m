Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB68ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F93720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F93720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbeGWNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:29 -0400
Received: from mout.perfora.net ([74.208.4.194]:43007 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389026AbeGWNi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:28 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MBToO-1fproJ3xx8-00AVCt; Mon, 23 Jul 2018 14:37:18 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/26] ARM: tegra: colibri_t30: white-space clean-up
Date:   Mon, 23 Jul 2018 14:36:38 +0200
Message-Id: <20180723123658.980-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:OVym7uFc5GmZLHNhULhk8risb7OuIKkP1+AVh4APNV0MhOc5ltj
 77+cA1dvYCiUEUfRkZbfToSqv3/8OzfztPESfWJckpIQdrgbggwvAqRiemCJNgrgupFxnA2
 aNupWmPP8Lm6n9hMtIowJLza1Flu5iNXpCgFOEccsHYomRAyCw4bdMTWnT7UaF64o+ffaj3
 nbL3tW2du/sJaj2Wetl+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PM9z++XhS0Q=:jsIe8C/zBzjXGAkW1Y+HmD
 QBwxH7X6G7JbZIq6f2Ub45fzwlYqWsq1/UL3g+sZnCKXKmqrpdpgqo/Rgdf+MquPmn4Drqg3R
 EVOURrabFHNeIfFPJI3I2R3oF5RLgDW+58LGHm6t5lo59AWVurJJf7qEk0YM4s/njrmi+okP1
 TRBwU2HJs6DmTgFUFrmgA3JXHc7GBLddJzhS8oOYlahnwKWatTx9ibTaHyUe4AlB/rZAexshG
 r0JHRSTPg7B01M+6DNaY4tKkCtAAiGdp+p0ZQOoojGaB4Z3OKa2yxXlJuZtf1/nC9A+2V8Ek3
 2OneGisC42iZp5AegBlZAPwBVcjs7RHkVNn7wUgyiVkAgDGJIYA3YNsbzrj/tZyaObd/IDlan
 /mPFmwGOgnZD5x7n2oxhwRtPk9IgeMercOEx33oi0blW5CVJz3G61Alp/zUnss5fxYE7HVi8D
 qZFR9+2vkVCiZ/kwotwnhpajwnA5vWeEeBH+H3RV7MvU/XbJWKqa6qcdn256UHl7srqx9FYGo
 lpy7bZZKXQy3bOSef7afwyq5iKuprWPkShebptoStELT2RHcsQG/r0es8nJU3YHNG7CiG0tkT
 lcYYaRj10ej3ZAPtS/6UCXzKKTFFqC3y/cO0DfVQ11txXT07J2ZCa1fvgfjhjZ8mFxnYwSlPN
 XP10wzuMU3gpBpIfXUR5rMuvVd+pUn0oY5rRwsTYE0Zr+DFP9ObKsfSThG6sscO47wdI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

White-space clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 5b32a70ceff2..19af6ccd57b2 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -27,6 +27,7 @@
 				nvidia,panel = <&panel>;
 			};
 		};
+
 		hdmi@54280000 {
 			status = "okay";
 			hdmi-supply = <&reg_5v0>;
@@ -78,6 +79,7 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
+
 		can0: can@0 {
 			compatible = "microchip,mcp2515";
 			reg = <0>;
@@ -86,6 +88,7 @@
 			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_RISING>;
 			spi-max-frequency = <10000000>;
 		};
+
 		spidev0: spi@1 {
 			compatible = "spidev";
 			reg = <1>;
@@ -124,7 +127,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-
 		/* PWM<A> */
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 128 64 32 16 8 4 0>;
@@ -162,7 +164,6 @@
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
 		compatible = "edt,et057090dhu", "simple-panel";
-
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
-- 
2.14.4

