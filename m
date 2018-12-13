Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA98C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F12F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544703012;
	bh=aXa6SIQC9lLrF1u8DLfyrbwfvFV6P3OWZ7jA21/7Hwc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YEDERlz7Vx1CkSpzHVpvAzicYC6aITrPwI3Z3CAoIEt0M+8Inpv3d+dzEH661ih8d
	 JNWYlXlpTDdEVIwbQPCmg3fyoITVjFPC0SHo12fAmAzBGuF59UuC/hTdIp7anVm0B2
	 o9p/Ozn0geSnO7duNxb+vmyZ887LP4HxskaKHNjc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F12F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeLMMJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeLMMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=en0Q5W149R0hkKEZoecaHdHCLbDeTlKguyxtfIIMGFM=; b=xHUy3YjgtX8a
        RjP2OmtHXxvId6Aft6Oh/YjtV9KALLDhMDwfy6Wl1FlKbh5RBWfMtisPQB3pl9kRVYmu4DaJC4VVO
        /RmvoR0Ek+fQuRDFnWITZBq+hHNAnrXbennpWHqYhInH6Cje+Q2S7yTpNdfRtTha+KlC8UzLLBrdg
        7+HVs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPnY-0000yr-0e; Thu, 13 Dec 2018 12:09:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AC5FD11254D1; Thu, 13 Dec 2018 12:08:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: add documentation for regulator modes and suspend states" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213120859.AC5FD11254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:08:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: add documentation for regulator modes and suspend states

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8a582fa9429108c247ff56dfbc4e3ead08a76956 Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Tue, 11 Dec 2018 15:56:59 +0000
Subject: [PATCH] regulator: add documentation for regulator modes and suspend
 states

Add documentation for regulator modes and suspend states.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/act8945a-regulator.txt | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
index ac955dea00d1..4017527619ab 100644
--- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -15,11 +15,17 @@ Optional input supply properties:
   - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
 
 Any standard regulator properties can be used to configure the single regulator.
+regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
+specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
+file.
 
 The valid names for regulators are:
 	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
 
 Example:
+
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
+
 	pmic@5b {
 		compatible = "active-semi,act8945a";
 		reg = <0x5b>;
@@ -32,6 +38,18 @@ Example:
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-min-microvolt=<1400000>;
+					regulator-suspend-max-microvolt=<1400000>;
+					regulator-changeable-in-suspend;
+					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				};
 			};
 
 			vdd_1v2_reg: REG_DCDC2 {
@@ -39,6 +57,14 @@ Example:
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_3v3_reg: REG_DCDC3 {
@@ -53,6 +79,14 @@ Example:
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_3v3_lp_reg: REG_LDO2 {
-- 
2.19.0.rc2

