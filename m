Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967357AbeEYQpi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:45:38 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34187 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967331AbeEYQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:45:33 -0400
X-Google-Smtp-Source: ADUXVKINL3+Yv08wvIrpBMSPJlw24vUCfCrKV2sw5Fj/vOiYNPv3p2bqgsMHHc2ud3TTACCGIw6Zuw==
From: Ray Jui <ray.jui@broadcom.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: clk: Update Stingray binding doc
Date: Fri, 25 May 2018 09:45:15 -0700
Message-Id: <1527266717-8406-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
References: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Stingray clock binding document to add additional clock entries
with names matching the latest ASIC datasheet. Also modify a few existing
entries to make their naming more consistent with the rest of the entries

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../bindings/clock/brcm,iproc-clocks.txt           | 26 ++++++++++++----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
index f8e4a93..ab730ea 100644
--- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
@@ -276,36 +276,38 @@ These clock IDs are defined in:
     clk_ts_500_ref	genpll2		2	BCM_SR_GENPLL2_TS_500_REF_CLK
     clk_125_nitro	genpll2		3	BCM_SR_GENPLL2_125_NITRO_CLK
     clk_chimp		genpll2		4	BCM_SR_GENPLL2_CHIMP_CLK
-    clk_nic_flash	genpll2		5	BCM_SR_GENPLL2_NIC_FLASH
+    clk_nic_flash	genpll2		5	BCM_SR_GENPLL2_NIC_FLASH_CLK
+    clk_fs		genpll2		6	BCM_SR_GENPLL2_FS_CLK
 
     genpll3		crystal		0	BCM_SR_GENPLL3
     clk_hsls		genpll3		1	BCM_SR_GENPLL3_HSLS_CLK
     clk_sdio		genpll3		2	BCM_SR_GENPLL3_SDIO_CLK
 
     genpll4		crystal		0	BCM_SR_GENPLL4
-    ccn			genpll4		1	BCM_SR_GENPLL4_CCN_CLK
+    clk_ccn		genpll4		1	BCM_SR_GENPLL4_CCN_CLK
     clk_tpiu_pll	genpll4		2	BCM_SR_GENPLL4_TPIU_PLL_CLK
-    noc_clk		genpll4		3	BCM_SR_GENPLL4_NOC_CLK
+    clk_noc		genpll4		3	BCM_SR_GENPLL4_NOC_CLK
     clk_chclk_fs4	genpll4		4	BCM_SR_GENPLL4_CHCLK_FS4_CLK
     clk_bridge_fscpu	genpll4		5	BCM_SR_GENPLL4_BRIDGE_FSCPU_CLK
 
-
     genpll5		crystal		0	BCM_SR_GENPLL5
-    fs4_hf_clk		genpll5		1	BCM_SR_GENPLL5_FS4_HF_CLK
-    crypto_ae_clk	genpll5		2	BCM_SR_GENPLL5_CRYPTO_AE_CLK
-    raid_ae_clk		genpll5		3	BCM_SR_GENPLL5_RAID_AE_CLK
+    clk_fs4_hf		genpll5		1	BCM_SR_GENPLL5_FS4_HF_CLK
+    clk_crypto_ae	genpll5		2	BCM_SR_GENPLL5_CRYPTO_AE_CLK
+    clk_raid_ae		genpll5		3	BCM_SR_GENPLL5_RAID_AE_CLK
 
     genpll6		crystal		0	BCM_SR_GENPLL6
-    48_usb		genpll6		1	BCM_SR_GENPLL6_48_USB_CLK
+    clk_48_usb		genpll6		1	BCM_SR_GENPLL6_48_USB_CLK
 
     lcpll0		crystal		0	BCM_SR_LCPLL0
     clk_sata_refp 	lcpll0		1	BCM_SR_LCPLL0_SATA_REFP_CLK
     clk_sata_refn	lcpll0		2	BCM_SR_LCPLL0_SATA_REFN_CLK
-    clk_usb_ref		lcpll0		3	BCM_SR_LCPLL0_USB_REF_CLK
-    sata_refpn		lcpll0		3	BCM_SR_LCPLL0_SATA_REFPN_CLK
+    clk_sata_350	lcpll0		3	BCM_SR_LCPLL0_SATA_350_CLK
+    clk_sata_500	lcpll0		4	BCM_SR_LCPLL0_SATA_500_CLK
 
     lcpll1		crystal		0	BCM_SR_LCPLL1
-    wan 		lcpll1		1	BCM_SR_LCPLL0_WAN_CLK
+    clk_wan		lcpll1		1	BCM_SR_LCPLL1_WAN_CLK
+    clk_usb_ref		lcpll1		2	BCM_SR_LCPLL1_USB_REF_CLK
+    clk_crmu_ts		lcpll1		3	BCM_SR_LCPLL1_CRMU_TS_CLK
 
     lcpll_pcie		crystal		0	BCM_SR_LCPLL_PCIE
-    pcie_phy_ref 	lcpll1		1	BCM_SR_LCPLL_PCIE_PHY_REF_CLK
+    clk_pcie_phy_ref	lcpll1		1	BCM_SR_LCPLL_PCIE_PHY_REF_CLK
-- 
2.1.4
