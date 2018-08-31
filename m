Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB63C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BC20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6BC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeHaUrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:14 -0400
Received: from mout.perfora.net ([74.208.4.194]:51095 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbeHaUrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:13 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MgvO2-1gHjAl0txg-00M76b; Fri, 31 Aug 2018 18:38:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 11/34] ARM: tegra: apalis_t30: white-space/newline clean-up
Date:   Fri, 31 Aug 2018 18:37:53 +0200
Message-Id: <20180831163817.23970-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:iAXA6YN2V2SeaxQPvkrRPF7jneeC2/UIz6C2NNOjL8jUiyFTXVc
 Op/aEmtbDGp4DCG3mu5pBJMexkYAjPjXxERztOKU/n80EWP6NyHILRSs0ZvYptxNPzvYRzI
 x/NOqznurrXVOBYZLkEazWI7jGmbF8BuK2mckhP31kMBS3QA0xlO8SoNGqXsVgrzqP+iU97
 1saT9swiFtRY4LQozZdng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T+o0k8ooYtU=:xOKVSOS4aBcx5rsy0+Yfkq
 FvSk0KY4rk5Hy83r/H+v2w6K7CP2LzNlw+VdEzF+x/6MCbF8lww/zrCkjE/M8FqzRQqDNsueX
 NcKqDLaUiuVJTq7ln390LFuDU08ErnlV2ykRgPS9u+1jvs7Ur2Tfy+p+lgcmTVBKxGbOWByx4
 HFl4Q7NcQD/RhzjKXVMUH7CzJUkO+fDQp0zxBtepSnBhI2BP4ky7ZPmACZkcLiJ89j5g+khYF
 lrYDWnWlkFDdO0Wj94iWiaxdQEhG0jVjr5LB1JCdXYLDFMnm9nKo7f3zWlFyXtKIM1Z5gTJCt
 fejt7IxjGL6QjlOBm+adHWq7t8d51SNeSoumY+eEY0VssNU0dy2EGup9xsdAHmkUgvJFd8yE9
 C26kBR1/7E3+8IK4AGH1CBTSiQ9RrvUC5hoCRjhzINbf7nj9O3cqf9uXmE/k7ybioFixsTs6u
 ssneGPAnElyzX/GOADv28bon/7U4OoTIXaONl2qBX7v8PeQB+GlCp1cbttX1sFv1EcaWpLQOe
 vKgUkkDHgXf6Jbw73wPZAq/MnVgtcqaL3RMOTy9UAXC9umotGtEj1zHvqAYufYDA2OrqDmoSp
 wjvbyYBY/QGs8WVgbtshG/oapQbbEs13O5Px7jTkDwLqGuXZijed9VubBZh7l+5NiplM+HZJp
 pSngpVdytbqsDRuya7CH8ICoFMWUMRJzqMfUTdQj0Aeq3rTTk+dsABxshREBO0CFuoS8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

White-space and newline clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also add two missing newlines.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 5 +++--
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 3f15f327f293..0a8900be0008 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -39,6 +39,7 @@
 				nvidia,panel = <&panel>;
 			};
 		};
+
 		hdmi@54280000 {
 			status = "okay";
 			hdmi-supply = <&reg_5v0>;
@@ -109,6 +110,7 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
+
 		spidev0: spidev@1 {
 			compatible = "spidev";
 			reg = <1>;
@@ -120,6 +122,7 @@
 	spi@7000dc00 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
+
 		spidev1: spidev@2 {
 			compatible = "spidev";
 			reg = <2>;
@@ -180,7 +183,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-
 		/* PWM_BKL1 */
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 231 223 207 191 159 127 0>;
@@ -208,7 +210,6 @@
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
 		compatible = "edt,et057090dhu", "simple-panel";
-
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7e9d1b022982..e84feac9b992 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -39,6 +39,7 @@
 		pci@3,0 {
 			status = "okay";
 			nvidia,num-lanes = <1>;
+
 			pcie@0 {
 				reg = <0 0 0 0 0>;
 				local-mac-address = [00 00 00 00 00 00];
-- 
2.14.4

