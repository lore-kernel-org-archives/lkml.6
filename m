Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60C1C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AA420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AA420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeIBOZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:43 -0400
Received: from mout.perfora.net ([74.208.4.196]:34387 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:42 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0McFxR-1gELKG46Df-00JjIK; Sun, 02 Sep 2018 12:10:20 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 34/37] ARM: tegra: colibri_t20: rename tps6586x@34 and drop unused pmic label
Date:   Sun,  2 Sep 2018 12:09:03 +0200
Message-Id: <20180902100906.25792-35-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:641wrIwoHIYZc0DU4xKzs2/DPVnAhul7nXQJ8WoYesijpTeiANj
 VsGN3Yhzp08sMiERzLCng+L4JIZSF6HF8IdH8gEQWGX6nMkZg89EBXE9o1wnWOV42tNa/jY
 ru4WDdNFSmXoCzZx1Akr5sZEoB+JJKPmFiJNIYF66r5TAWEgOzjYxlnH1Jqltf5YFhNnOpi
 cii1u4/jdfCtANZ8dRzjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SFYan76Ja3Y=:n98rLqmj1Y8LYau7R0kYr+
 D5z8yhuQ+9Rihde8/H1PJOXzlm1RYfBaJS0YSN14/gCv2p1EKQXPAo+r28yivNNeyiyahP/dp
 XpBSG1XsjHmsa5W0M67iq6SyYegecSVu8k0hcNiOb2uBfmiG+FtO2Q3Ujpgm2WlKMALyUzgBc
 PmghiiTVHzRjofz/RwAfjY7xhktU4fvfBwAZJtxOjrLmb0kBCWPHZQzJj0w7Fq6JL0p/ZUXAa
 QsNCFQReur4Rh+F99MLi3tnrYVs9PK2m9nc0JIomYH5VyeUMNqDch/72g6hfTD7jBaPsXj2y9
 ZUoOPFVMiBjofaL/0UiiKq3ZGTNX9sXpGf9teAjUeGOyR1SMhNq0L3p5oLUvSNHFzIDzSTHJ2
 ZPejIfRhr4kJK5l7xajS1/AD2ymfR1kvh1ZqVDlAP+k5eJiLUI+n31RWPH4rGsXjgoDqbUh9o
 WLeQM8dkt5e54hmXydR2zvyBAUW/JFzp+qJ9R++/JjdAYjzHctj/OQn+brriaj57yb+FLafqm
 HfJEBYlrRsqL761w05uvs9jR3UTLvFRBRX1bUcAsdplXmc27J+Eoq2x/7fIyTrCExpqnf27nF
 /vIxBK8hWe7ZGuIrMLsrEFP9qcGmFnZtUnu9pApw/uVPmI/B4FCbvuYgjSZVHJd74rybnQd+/
 7GWtT+yPpQl7rbmdYPs+98gBB0aIMlcAmnX2dKdAPJv1wilV+r354ZSewbETlEJH8jDE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename tps6586x@34 to pmic@34 and drop the unused pmic label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch as suggested by Rob.

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 +-
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 00fd2603d780..d8004d68efa0 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -11,7 +11,7 @@
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-		rtc1 = "/i2c@7000d000/tps6586x@34";
+		rtc1 = "/i2c@7000d000/pmic@34";
 		rtc2 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartd;
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 36463fb3c0b3..473f32f20d8d 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -472,7 +472,7 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
-		pmic: tps6586x@34 {
+		pmic@34 {
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.14.4

