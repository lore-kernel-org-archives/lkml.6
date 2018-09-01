Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45050C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036E82083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036E82083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIAMY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:29 -0400
Received: from mout.perfora.net ([74.208.4.194]:35685 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbeIAMY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8Pa8-1fiLp7273C-00vzpy; Sat, 01 Sep 2018 10:13:12 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 06/34] ARM: tegra: colibri_t30: white-space clean-up
Date:   Sat,  1 Sep 2018 10:12:20 +0200
Message-Id: <20180901081248.22639-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:2hQxr3dg/PADMiz6NRT/o6uVTVg9O2cnNN44zzQrJyUn0r6dxCe
 ET7zZMkMcsexqi8m6N8oyPkWP2DEW+JtTonNYMIJzUOf56Ixu+yRw/II3qRYtBBU2xwDiRT
 xPPUf/ghiznaHvhagjpL3bUZOwSy+AsbIvbAZHWCzFui/Mqd3T2WJgbHYFQsgG72jJ5nWT/
 9hidlilyXAYMgI5dm0EwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ME2HE+NRIE=:Yn8t6hyH3oJDXJVzbYaCv3
 x+O7r7U7XJZ3chIiDGUlD4UynQ9hBXSzpmNx1bv4wTlrm1VummAGwMPsdpYdmYS2C/O82+Gea
 9vZg0mwsWklvFPZ0UR3tQLVChYdnNkUNK1lhPGP3Xt8wb/8Iw0urIj+zq0HovR5qVzrT69Jfq
 CEJGknabqJReK5OrdGEraDFNihFTjMCoAB+TwhOv61eq4+eKMYjDfZfgXfN7+I9IA1trpdSrX
 zAu3d/iZn8IPYAdPUFqaGCgMSX49xSEmk7LmS1//2RrBQL9CCWl6LpeZi/xNIxa2lKCZgeXvz
 Q0P0d0J39Gqn0w8dnwMO5ZF+9r8UYEdCUyYCx2TiJJY8K5Y8V+gbJ3K6S+bKUN++aEi/n6NuV
 rYAg3fkJTZ6kFcrvO79BNUYQglZrGXe+iAEICZH6K3dr/kDuntSbt8OKUUs6SJ3/7EvPMQbBe
 lfM0ZjQAhEMiNlPWLwdFHXiaqr1/7PWYt8QCVmt+4ygw0HvRr7H10Edj7L9qOLijgl5uW8JsB
 lPBU71fnAfNQ3EuZOWSeG4PU+Qfvk3PETOUE8ZwxKZUuAG3gohQLEFBnL38KY0OkEhBEUGqDq
 xuUZFqJl9CuN9uD9yutEV7XGNWI92eJjp0LiPEuU2bZsxEYkUBOdInrm5Eb01abQI710VQRpE
 wzycWCENCOn4e7SH/reJtos4h1UQPFsnKJAlLV2Wr4HzSR98h3DimOOMmQlega7yq/Uc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

White-space clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 682ea4ffce83..ff321964d225 100644
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
@@ -76,6 +77,7 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
+
 		can0: can@0 {
 			compatible = "microchip,mcp2515";
 			reg = <0>;
@@ -84,6 +86,7 @@
 			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_RISING>;
 			spi-max-frequency = <10000000>;
 		};
+
 		spidev0: spi@1 {
 			compatible = "spidev";
 			reg = <1>;
@@ -122,7 +125,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-
 		/* PWM<A> */
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 128 64 32 16 8 4 0>;
@@ -160,7 +162,6 @@
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
 		compatible = "edt,et057090dhu", "simple-panel";
-
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
-- 
2.14.4

