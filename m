Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E900C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF77218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548439895;
	bh=hifuY5fjVUv2Yp38aCRBohGq10Lwo22y3/vmgk/w4UU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lOUfKLSqZr95p1i3x2tDiRNdRXlrKV02dbTPDsH3uwKPl0eZsEmfMpPd8rm33adK9
	 uN54zbCCQarzFBviCvaszgJhbyhbWrCaNJgxUbeEcIEIevQPZ7vu0Wt4Wks8lOIN86
	 rr0Ppc0kAAn1JTLuV4jrBrfSBXU03DuU4T6rWKlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfAYSLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:11:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfAYSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MT5QL6pE+X8FHr3GbnQpTb79yYAGleC7UZnRLzOYhSg=; b=qAWHpEB8lYnD
        XztF8VyfYvIWIAbOBF+KT2hMC82mesLmhYbB+8IN58A8MmhvhrwUTztHrd0G5/rkcOBmHZknaaAxT
        AqFyZpouL7GO9bvixmuJ5vhc+q7Rnsgi1PVIWSSgjHMSpTcaOW4OaPY7Be38mEeICPqIhjN87uABV
        GEnA4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gn5wt-0004XN-M2; Fri, 25 Jan 2019 18:11:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 456091126FC1; Fri, 25 Jan 2019 18:11:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mc13xxx: Use lowercase regulator names to match the DT" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190125181127.456091126FC1@debutante.sirena.org.uk>
Date:   Fri, 25 Jan 2019 18:11:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mc13xxx: Use lowercase regulator names to match the DT

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

From ec520911ecc7eaf01a69d278185ddc99bba901e1 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Fri, 25 Jan 2019 09:37:04 -0600
Subject: [PATCH] regulator: mc13xxx: Use lowercase regulator names to match
 the DT

Since c32569e358ad ("regulator: Use of_node_name_eq for node name
comparisons") Vivien reported the mc13892-regulator complaining about
not being able to find regulators.

This is because prior to that commit we used of_node_cmp() to compare
the regulator array passed from mc13892_regulators down to
mc13xxx_parse_regulators_dt() and they are all defined in uppercase
letters by the MC13892_*_DEFINE* macros, whereas they are defined as
lowercase in the DTS.

Fix this by using a lowercase regulator name to match the DT node name.

Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Tested-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mc13783-regulator.c | 78 +++++++++++++--------------
 drivers/regulator/mc13892-regulator.c | 64 +++++++++++-----------
 drivers/regulator/mc13xxx.h           | 20 +++----
 3 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 8fd1adc9c9a9..887a1d1726ad 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -228,67 +228,67 @@ static const unsigned int mc13783_pwgtdrv_val[] = {
 
 static struct regulator_ops mc13783_gpo_regulator_ops;
 
-#define MC13783_DEFINE(prefix, name, reg, vsel_reg, voltages)	\
-	MC13xxx_DEFINE(MC13783_REG_, name, reg, vsel_reg, voltages, \
+#define MC13783_DEFINE(prefix, name, node, reg, vsel_reg, voltages)	\
+	MC13xxx_DEFINE(MC13783_REG_, name, node, reg, vsel_reg, voltages, \
 			mc13xxx_regulator_ops)
 
-#define MC13783_FIXED_DEFINE(prefix, name, reg, voltages)		\
-	MC13xxx_FIXED_DEFINE(MC13783_REG_, name, reg, voltages, \
+#define MC13783_FIXED_DEFINE(prefix, name, node, reg, voltages)		\
+	MC13xxx_FIXED_DEFINE(MC13783_REG_, name, node, reg, voltages,	\
 			mc13xxx_fixed_regulator_ops)
 
-#define MC13783_GPO_DEFINE(prefix, name, reg, voltages)		\
-	MC13xxx_GPO_DEFINE(MC13783_REG_, name, reg, voltages, \
+#define MC13783_GPO_DEFINE(prefix, name, node, reg, voltages)		\
+	MC13xxx_GPO_DEFINE(MC13783_REG_, name, node, reg, voltages,	\
 			mc13783_gpo_regulator_ops)
 
-#define MC13783_DEFINE_SW(_name, _reg, _vsel_reg, _voltages)		\
-	MC13783_DEFINE(REG, _name, _reg, _vsel_reg, _voltages)
-#define MC13783_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages)		\
-	MC13783_DEFINE(REG, _name, _reg, _vsel_reg, _voltages)
+#define MC13783_DEFINE_SW(_name, _node, _reg, _vsel_reg, _voltages)	\
+	MC13783_DEFINE(REG, _name, _node, _reg, _vsel_reg, _voltages)
+#define MC13783_DEFINE_REGU(_name, _node, _reg, _vsel_reg, _voltages)	\
+	MC13783_DEFINE(REG, _name, _node, _reg, _vsel_reg, _voltages)
 
 static struct mc13xxx_regulator mc13783_regulators[] = {
-	MC13783_DEFINE_SW(SW1A, SWITCHERS0, SWITCHERS0, mc13783_sw1x_val),
-	MC13783_DEFINE_SW(SW1B, SWITCHERS1, SWITCHERS1, mc13783_sw1x_val),
-	MC13783_DEFINE_SW(SW2A, SWITCHERS2, SWITCHERS2, mc13783_sw2x_val),
-	MC13783_DEFINE_SW(SW2B, SWITCHERS3, SWITCHERS3, mc13783_sw2x_val),
-	MC13783_DEFINE_SW(SW3, SWITCHERS5, SWITCHERS5, mc13783_sw3_val),
-
-	MC13783_FIXED_DEFINE(REG, VAUDIO, REGULATORMODE0, mc13783_vaudio_val),
-	MC13783_FIXED_DEFINE(REG, VIOHI, REGULATORMODE0, mc13783_viohi_val),
-	MC13783_DEFINE_REGU(VIOLO, REGULATORMODE0, REGULATORSETTING0,
+	MC13783_DEFINE_SW(SW1A, sw1a, SWITCHERS0, SWITCHERS0, mc13783_sw1x_val),
+	MC13783_DEFINE_SW(SW1B, sw1b, SWITCHERS1, SWITCHERS1, mc13783_sw1x_val),
+	MC13783_DEFINE_SW(SW2A, sw2a, SWITCHERS2, SWITCHERS2, mc13783_sw2x_val),
+	MC13783_DEFINE_SW(SW2B, sw2b, SWITCHERS3, SWITCHERS3, mc13783_sw2x_val),
+	MC13783_DEFINE_SW(SW3, sw3, SWITCHERS5, SWITCHERS5, mc13783_sw3_val),
+
+	MC13783_FIXED_DEFINE(REG, VAUDIO, vaudio, REGULATORMODE0, mc13783_vaudio_val),
+	MC13783_FIXED_DEFINE(REG, VIOHI, viohi, REGULATORMODE0, mc13783_viohi_val),
+	MC13783_DEFINE_REGU(VIOLO, violo, REGULATORMODE0, REGULATORSETTING0,
 			    mc13783_violo_val),
-	MC13783_DEFINE_REGU(VDIG, REGULATORMODE0, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VDIG, vdig, REGULATORMODE0, REGULATORSETTING0,
 			    mc13783_vdig_val),
-	MC13783_DEFINE_REGU(VGEN, REGULATORMODE0, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VGEN, vgen, REGULATORMODE0, REGULATORSETTING0,
 			    mc13783_vgen_val),
-	MC13783_DEFINE_REGU(VRFDIG, REGULATORMODE0, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VRFDIG, vrfdig, REGULATORMODE0, REGULATORSETTING0,
 			    mc13783_vrfdig_val),
-	MC13783_DEFINE_REGU(VRFREF, REGULATORMODE0, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VRFREF, vrfref, REGULATORMODE0, REGULATORSETTING0,
 			    mc13783_vrfref_val),
-	MC13783_DEFINE_REGU(VRFCP, REGULATORMODE0, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VRFCP, vrfcp, REGULATORMODE0, REGULATORSETTING0,
 			    mc13783_vrfcp_val),
-	MC13783_DEFINE_REGU(VSIM, REGULATORMODE1, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VSIM, vsim, REGULATORMODE1, REGULATORSETTING0,
 			    mc13783_vsim_val),
-	MC13783_DEFINE_REGU(VESIM, REGULATORMODE1, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VESIM, vesim, REGULATORMODE1, REGULATORSETTING0,
 			    mc13783_vesim_val),
-	MC13783_DEFINE_REGU(VCAM, REGULATORMODE1, REGULATORSETTING0,
+	MC13783_DEFINE_REGU(VCAM, vcam, REGULATORMODE1, REGULATORSETTING0,
 			    mc13783_vcam_val),
-	MC13783_FIXED_DEFINE(REG, VRFBG, REGULATORMODE1, mc13783_vrfbg_val),
-	MC13783_DEFINE_REGU(VVIB, REGULATORMODE1, REGULATORSETTING1,
+	MC13783_FIXED_DEFINE(REG, VRFBG, vrfbg, REGULATORMODE1, mc13783_vrfbg_val),
+	MC13783_DEFINE_REGU(VVIB, vvib, REGULATORMODE1, REGULATORSETTING1,
 			    mc13783_vvib_val),
-	MC13783_DEFINE_REGU(VRF1, REGULATORMODE1, REGULATORSETTING1,
+	MC13783_DEFINE_REGU(VRF1, vrf1, REGULATORMODE1, REGULATORSETTING1,
 			    mc13783_vrf_val),
-	MC13783_DEFINE_REGU(VRF2, REGULATORMODE1, REGULATORSETTING1,
+	MC13783_DEFINE_REGU(VRF2, vrf2, REGULATORMODE1, REGULATORSETTING1,
 			    mc13783_vrf_val),
-	MC13783_DEFINE_REGU(VMMC1, REGULATORMODE1, REGULATORSETTING1,
+	MC13783_DEFINE_REGU(VMMC1, vmmc1, REGULATORMODE1, REGULATORSETTING1,
 			    mc13783_vmmc_val),
-	MC13783_DEFINE_REGU(VMMC2, REGULATORMODE1, REGULATORSETTING1,
+	MC13783_DEFINE_REGU(VMMC2, vmmc2, REGULATORMODE1, REGULATORSETTING1,
 			    mc13783_vmmc_val),
-	MC13783_GPO_DEFINE(REG, GPO1, POWERMISC, mc13783_gpo_val),
-	MC13783_GPO_DEFINE(REG, GPO2, POWERMISC, mc13783_gpo_val),
-	MC13783_GPO_DEFINE(REG, GPO3, POWERMISC, mc13783_gpo_val),
-	MC13783_GPO_DEFINE(REG, GPO4, POWERMISC, mc13783_gpo_val),
-	MC13783_GPO_DEFINE(REG, PWGT1SPI, POWERMISC, mc13783_pwgtdrv_val),
-	MC13783_GPO_DEFINE(REG, PWGT2SPI, POWERMISC, mc13783_pwgtdrv_val),
+	MC13783_GPO_DEFINE(REG, GPO1, gpo1, POWERMISC, mc13783_gpo_val),
+	MC13783_GPO_DEFINE(REG, GPO2, gpo1, POWERMISC, mc13783_gpo_val),
+	MC13783_GPO_DEFINE(REG, GPO3, gpo1, POWERMISC, mc13783_gpo_val),
+	MC13783_GPO_DEFINE(REG, GPO4, gpo1, POWERMISC, mc13783_gpo_val),
+	MC13783_GPO_DEFINE(REG, PWGT1SPI, pwgt1spi, POWERMISC, mc13783_pwgtdrv_val),
+	MC13783_GPO_DEFINE(REG, PWGT2SPI, pwgt2spi, POWERMISC, mc13783_pwgtdrv_val),
 };
 
 static int mc13783_powermisc_rmw(struct mc13xxx_regulator_priv *priv, u32 mask,
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index f3fba1cc1379..b55894980066 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -246,57 +246,57 @@ static struct regulator_ops mc13892_gpo_regulator_ops;
 static struct regulator_ops mc13892_sw_regulator_ops;
 
 
-#define MC13892_FIXED_DEFINE(name, reg, voltages)		\
-	MC13xxx_FIXED_DEFINE(MC13892_, name, reg, voltages,	\
+#define MC13892_FIXED_DEFINE(name, node, reg, voltages)			\
+	MC13xxx_FIXED_DEFINE(MC13892_, name, node, reg, voltages,	\
 			mc13xxx_fixed_regulator_ops)
 
-#define MC13892_GPO_DEFINE(name, reg, voltages)			\
-	MC13xxx_GPO_DEFINE(MC13892_, name, reg, voltages,	\
+#define MC13892_GPO_DEFINE(name, node, reg, voltages)			\
+	MC13xxx_GPO_DEFINE(MC13892_, name, node, reg, voltages,		\
 			mc13892_gpo_regulator_ops)
 
-#define MC13892_SW_DEFINE(name, reg, vsel_reg, voltages)	\
-	MC13xxx_DEFINE(MC13892_, name, reg, vsel_reg, voltages, \
+#define MC13892_SW_DEFINE(name, node, reg, vsel_reg, voltages)		\
+	MC13xxx_DEFINE(MC13892_, name, node, reg, vsel_reg, voltages,	\
 			mc13892_sw_regulator_ops)
 
-#define MC13892_DEFINE_REGU(name, reg, vsel_reg, voltages)	\
-	MC13xxx_DEFINE(MC13892_, name, reg, vsel_reg, voltages, \
+#define MC13892_DEFINE_REGU(name, node, reg, vsel_reg, voltages)	\
+	MC13xxx_DEFINE(MC13892_, name, node, reg, vsel_reg, voltages, \
 			mc13xxx_regulator_ops)
 
 static struct mc13xxx_regulator mc13892_regulators[] = {
-	MC13892_DEFINE_REGU(VCOINCELL, POWERCTL0, POWERCTL0, mc13892_vcoincell),
-	MC13892_SW_DEFINE(SW1, SWITCHERS0, SWITCHERS0, mc13892_sw1),
-	MC13892_SW_DEFINE(SW2, SWITCHERS1, SWITCHERS1, mc13892_sw),
-	MC13892_SW_DEFINE(SW3, SWITCHERS2, SWITCHERS2, mc13892_sw),
-	MC13892_SW_DEFINE(SW4, SWITCHERS3, SWITCHERS3, mc13892_sw),
-	MC13892_FIXED_DEFINE(SWBST, SWITCHERS5, mc13892_swbst),
-	MC13892_FIXED_DEFINE(VIOHI, REGULATORMODE0, mc13892_viohi),
-	MC13892_DEFINE_REGU(VPLL, REGULATORMODE0, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VCOINCELL, vcoincell, POWERCTL0, POWERCTL0, mc13892_vcoincell),
+	MC13892_SW_DEFINE(SW1, sw1, SWITCHERS0, SWITCHERS0, mc13892_sw1),
+	MC13892_SW_DEFINE(SW2, sw2, SWITCHERS1, SWITCHERS1, mc13892_sw),
+	MC13892_SW_DEFINE(SW3, sw3, SWITCHERS2, SWITCHERS2, mc13892_sw),
+	MC13892_SW_DEFINE(SW4, sw4, SWITCHERS3, SWITCHERS3, mc13892_sw),
+	MC13892_FIXED_DEFINE(SWBST, swbst, SWITCHERS5, mc13892_swbst),
+	MC13892_FIXED_DEFINE(VIOHI, viohi, REGULATORMODE0, mc13892_viohi),
+	MC13892_DEFINE_REGU(VPLL, vpll, REGULATORMODE0, REGULATORSETTING0,
 		mc13892_vpll),
-	MC13892_DEFINE_REGU(VDIG, REGULATORMODE0, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VDIG, vdig, REGULATORMODE0, REGULATORSETTING0,
 		mc13892_vdig),
-	MC13892_DEFINE_REGU(VSD, REGULATORMODE1, REGULATORSETTING1,
+	MC13892_DEFINE_REGU(VSD, vsd, REGULATORMODE1, REGULATORSETTING1,
 		mc13892_vsd),
-	MC13892_DEFINE_REGU(VUSB2, REGULATORMODE0, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VUSB2, vusb2, REGULATORMODE0, REGULATORSETTING0,
 		mc13892_vusb2),
-	MC13892_DEFINE_REGU(VVIDEO, REGULATORMODE1, REGULATORSETTING1,
+	MC13892_DEFINE_REGU(VVIDEO, vvideo, REGULATORMODE1, REGULATORSETTING1,
 		mc13892_vvideo),
-	MC13892_DEFINE_REGU(VAUDIO, REGULATORMODE1, REGULATORSETTING1,
+	MC13892_DEFINE_REGU(VAUDIO, vaudio, REGULATORMODE1, REGULATORSETTING1,
 		mc13892_vaudio),
-	MC13892_DEFINE_REGU(VCAM, REGULATORMODE1, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VCAM, vcam, REGULATORMODE1, REGULATORSETTING0,
 		mc13892_vcam),
-	MC13892_DEFINE_REGU(VGEN1, REGULATORMODE0, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VGEN1, vgen1, REGULATORMODE0, REGULATORSETTING0,
 		mc13892_vgen1),
-	MC13892_DEFINE_REGU(VGEN2, REGULATORMODE0, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VGEN2, vgen2, REGULATORMODE0, REGULATORSETTING0,
 		mc13892_vgen2),
-	MC13892_DEFINE_REGU(VGEN3, REGULATORMODE1, REGULATORSETTING0,
+	MC13892_DEFINE_REGU(VGEN3, vgen3, REGULATORMODE1, REGULATORSETTING0,
 		mc13892_vgen3),
-	MC13892_FIXED_DEFINE(VUSB, USB1, mc13892_vusb),
-	MC13892_GPO_DEFINE(GPO1, POWERMISC, mc13892_gpo),
-	MC13892_GPO_DEFINE(GPO2, POWERMISC, mc13892_gpo),
-	MC13892_GPO_DEFINE(GPO3, POWERMISC, mc13892_gpo),
-	MC13892_GPO_DEFINE(GPO4, POWERMISC, mc13892_gpo),
-	MC13892_GPO_DEFINE(PWGT1SPI, POWERMISC, mc13892_pwgtdrv),
-	MC13892_GPO_DEFINE(PWGT2SPI, POWERMISC, mc13892_pwgtdrv),
+	MC13892_FIXED_DEFINE(VUSB, vusb, USB1, mc13892_vusb),
+	MC13892_GPO_DEFINE(GPO1, gpo1, POWERMISC, mc13892_gpo),
+	MC13892_GPO_DEFINE(GPO2, gpo2, POWERMISC, mc13892_gpo),
+	MC13892_GPO_DEFINE(GPO3, gpo3, POWERMISC, mc13892_gpo),
+	MC13892_GPO_DEFINE(GPO4, gpo4, POWERMISC, mc13892_gpo),
+	MC13892_GPO_DEFINE(PWGT1SPI, pwgt1spi, POWERMISC, mc13892_pwgtdrv),
+	MC13892_GPO_DEFINE(PWGT2SPI, pwgt2spi, POWERMISC, mc13892_pwgtdrv),
 };
 
 static int mc13892_powermisc_rmw(struct mc13xxx_regulator_priv *priv, u32 mask,
diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index 2ab9bfd93b4e..a602b08d4c9e 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -56,10 +56,10 @@ static inline struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 extern struct regulator_ops mc13xxx_regulator_ops;
 extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 
-#define MC13xxx_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages, _ops)	\
+#define MC13xxx_DEFINE(prefix, _name, _node, _reg, _vsel_reg, _voltages, _ops)	\
 	[prefix ## _name] = {				\
 		.desc = {						\
-			.name = #_name,					\
+			.name = #_node,					\
 			.n_voltages = ARRAY_SIZE(_voltages),		\
 			.volt_table =  _voltages,			\
 			.ops = &_ops,			\
@@ -74,10 +74,10 @@ extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 		.vsel_mask = prefix ## _vsel_reg ## _ ## _name ## VSEL_M,\
 	}
 
-#define MC13xxx_FIXED_DEFINE(prefix, _name, _reg, _voltages, _ops)	\
+#define MC13xxx_FIXED_DEFINE(prefix, _name, _node, _reg, _voltages, _ops)	\
 	[prefix ## _name] = {				\
 		.desc = {						\
-			.name = #_name,					\
+			.name = #_node,					\
 			.n_voltages = ARRAY_SIZE(_voltages),		\
 			.volt_table =  _voltages,			\
 			.ops = &_ops,		\
@@ -89,10 +89,10 @@ extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 		.enable_bit = prefix ## _reg ## _ ## _name ## EN,	\
 	}
 
-#define MC13xxx_GPO_DEFINE(prefix, _name, _reg,  _voltages, _ops)	\
+#define MC13xxx_GPO_DEFINE(prefix, _name, _node, _reg,  _voltages, _ops)	\
 	[prefix ## _name] = {				\
 		.desc = {						\
-			.name = #_name,					\
+			.name = #_node,					\
 			.n_voltages = ARRAY_SIZE(_voltages),		\
 			.volt_table =  _voltages,			\
 			.ops = &_ops,		\
@@ -104,9 +104,9 @@ extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 		.enable_bit = prefix ## _reg ## _ ## _name ## EN,	\
 	}
 
-#define MC13xxx_DEFINE_SW(_name, _reg, _vsel_reg, _voltages, ops)	\
-	MC13xxx_DEFINE(SW, _name, _reg, _vsel_reg, _voltages, ops)
-#define MC13xxx_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages, ops)	\
-	MC13xxx_DEFINE(REGU, _name, _reg, _vsel_reg, _voltages, ops)
+#define MC13xxx_DEFINE_SW(_name, _node, _reg, _vsel_reg, _voltages, ops) \
+	MC13xxx_DEFINE(SW, _name, _node, _reg, _vsel_reg, _voltages, ops)
+#define MC13xxx_DEFINE_REGU(_name, _node, _reg, _vsel_reg, _voltages, ops) \
+	MC13xxx_DEFINE(REGU, _name, _node, _reg, _vsel_reg, _voltages, ops)
 
 #endif
-- 
2.20.1

