Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0ADC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB920658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCB920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeHaUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:51 -0400
Received: from mout.perfora.net ([74.208.4.197]:57259 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeHaUrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:51 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M41rw-1fenbL3XDm-00rcRT; Fri, 31 Aug 2018 18:39:26 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 31/34] ARM: tegra: apalis_t30: rename tps65911@2d, stmpe811@41 and tps62362@60
Date:   Fri, 31 Aug 2018 18:38:13 +0200
Message-Id: <20180831163817.23970-32-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:p+NbXAZqJk0Q4+rId++w0LLZ3HRJZPi8Id/anigAE/ReVGc6Amn
 8//7l6YSZBUENDuHuLQNy10iE6XHDfWs+p8Tcb1ivi58juXWWiPHpNg7T1ImtS2eM2XRqpF
 /EKYBjHbyalwVjyNZXsL1f7T9AWacv5oJhDOixwjdSf0v8v3tkUYd8iNPfj+t+O5mM9fZ+B
 /NvLUz1CGirnwK2u6JeMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gFeM+CaaCeM=:x7Sop2AVA9rx5JUljoEA+d
 vOOVyKrMA0dO5bzYjAtof5Lb+nssJSX4NvfnJFdeRMHjTwivJtY3Xr+e65TsMsCDDtNDtvjUM
 6tNeRpdXfl8z0ENoLB6A7AvfYVQQ08zyVZu+zQzSXHEnbBrLvaG7lEVFPBmSsdMsxLfcRavFw
 /e3Xb/vE4qMBw2TJlL/5lYseX4WtzODbEeCEZlJDrGReWQvAoFuv0d5ZPsAO34aFN3LKmvrCi
 U3Nyg1k4LhzncquTFd4zArYkdijKRO3PlW6mJ6C8B9BymdWK7zxDShbC+uQqhJ4dblZWgYO05
 Jp1ilTQngloMMHCyHfnqC9jdeWR2KjtUI2N8cKbQqru3L+JLmLz8nbW+SY/ucv2EnytFmvH7f
 yxIV6h0TMCb2kcVbB2U0FI8zVW+YCpn3+w4PrrROl/aRhJ2+klkSjTMjebYY6NlPsdwz3k7QK
 dbUozF7Ttxz0OfTQf2VaZRkZ+T4ZyjUflGh4mk7JhCS9+PU0t53mj+xjNovlWPNFjJPsVHy9p
 8KdkAAasWX30ctOGfiMY34CEcemuJp++Vn+Da4J3a51K1cO4gNWEynFLw20XzSd3E6vykw3YP
 +zZbsEyW2GvYlEsqP/XoRSNad9XYe1V4684hmbCQts5/A/gfquFqZSRZ5TP7IU3fMbtvzQhKG
 CwH7Qps9MEq/+NhT1eckDlUOLVlJ5dfDmC3WIZW3ayfvHbFHHRk670ljjSXzkXV7WBiw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename a few nodes using more common names:
- rename tps65911@2d to pmic@2d
- rename stmpe811@41 to touchscreen@41
- rename tps62362@60 to regulator@60

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch as suggested by Rob.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 9381f65a9bf5..fdfadda72e0d 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -11,7 +11,7 @@
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-		rtc1 = "/i2c@7000d000/tps65911@2d";
+		rtc1 = "/i2c@7000d000/pmic@2d";
 		rtc2 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartb;
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index f15954995231..a31b112f631d 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -853,7 +853,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
 
-		pmic: tps65911@2d {
+		pmic: pmic@2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
 
@@ -969,7 +969,7 @@
 		};
 
 		/* STMPE811 touch screen controller */
-		stmpe811@41 {
+		touchscreen@41 {
 			compatible = "st,stmpe811";
 			reg = <0x41>;
 			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
@@ -1014,7 +1014,7 @@
 		};
 
 		/* SW: +V1.2_VDD_CORE */
-		tps62362@60 {
+		regulator@60 {
 			compatible = "ti,tps62362";
 			reg = <0x60>;
 
-- 
2.14.4

