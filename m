Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D479C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F6924010
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F6924010
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbeGENhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:37:50 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41333 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753769AbeGENdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:22 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 50D33CD56;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 14/34] media: dt-bindings: media: qcom,camss: Fix whitespaces
Date:   Thu,  5 Jul 2018 16:32:45 +0300
Message-Id: <1530797585-8555-15-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/qcom,camss.txt       | 92 +++++++++++-----------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,camss.txt b/Documentation/devicetree/bindings/media/qcom,camss.txt
index 032e8ed..e938eb0 100644
--- a/Documentation/devicetree/bindings/media/qcom,camss.txt
+++ b/Documentation/devicetree/bindings/media/qcom,camss.txt
@@ -53,25 +53,25 @@ Qualcomm Camera Subsystem
 	Usage: required
 	Value type: <stringlist>
 	Definition: Should contain the following entries:
-                - "top_ahb"
-                - "ispif_ahb"
-                - "csiphy0_timer"
-                - "csiphy1_timer"
-                - "csi0_ahb"
-                - "csi0"
-                - "csi0_phy"
-                - "csi0_pix"
-                - "csi0_rdi"
-                - "csi1_ahb"
-                - "csi1"
-                - "csi1_phy"
-                - "csi1_pix"
-                - "csi1_rdi"
-                - "ahb"
-                - "vfe0"
-                - "csi_vfe0"
-                - "vfe_ahb"
-                - "vfe_axi"
+		- "top_ahb"
+		- "ispif_ahb"
+		- "csiphy0_timer"
+		- "csiphy1_timer"
+		- "csi0_ahb"
+		- "csi0"
+		- "csi0_phy"
+		- "csi0_pix"
+		- "csi0_rdi"
+		- "csi1_ahb"
+		- "csi1"
+		- "csi1_phy"
+		- "csi1_pix"
+		- "csi1_rdi"
+		- "ahb"
+		- "vfe0"
+		- "csi_vfe0"
+		- "vfe_ahb"
+		- "vfe_axi"
 - vdda-supply:
 	Usage: required
 	Value type: <phandle>
@@ -95,17 +95,17 @@ Qualcomm Camera Subsystem
 		- clock-lanes:
 			Usage: required
 			Value type: <u32>
-                        Definition: The physical clock lane index. The value
-                                    must always be <1> as the physical clock
-                                    lane is lane 1.
+			Definition: The physical clock lane index. The value
+				    must always be <1> as the physical clock
+				    lane is lane 1.
 		- data-lanes:
 			Usage: required
 			Value type: <prop-encoded-array>
-                        Definition: An array of physical data lanes indexes.
-                                    Position of an entry determines the logical
-                                    lane number, while the value of an entry
-                                    indicates physical lane index. Lane swapping
-                                    is supported.
+			Definition: An array of physical data lanes indexes.
+				    Position of an entry determines the logical
+				    lane number, while the value of an entry
+				    indicates physical lane index. Lane swapping
+				    is supported.
 
 * An Example
 
@@ -161,25 +161,25 @@ Qualcomm Camera Subsystem
 			<&gcc GCC_CAMSS_CSI_VFE0_CLK>,
 			<&gcc GCC_CAMSS_VFE_AHB_CLK>,
 			<&gcc GCC_CAMSS_VFE_AXI_CLK>;
-                clock-names = "top_ahb",
-                        "ispif_ahb",
-                        "csiphy0_timer",
-                        "csiphy1_timer",
-                        "csi0_ahb",
-                        "csi0",
-                        "csi0_phy",
-                        "csi0_pix",
-                        "csi0_rdi",
-                        "csi1_ahb",
-                        "csi1",
-                        "csi1_phy",
-                        "csi1_pix",
-                        "csi1_rdi",
-                        "ahb",
-                        "vfe0",
-                        "csi_vfe0",
-                        "vfe_ahb",
-                        "vfe_axi";
+		clock-names = "top_ahb",
+			"ispif_ahb",
+			"csiphy0_timer",
+			"csiphy1_timer",
+			"csi0_ahb",
+			"csi0",
+			"csi0_phy",
+			"csi0_pix",
+			"csi0_rdi",
+			"csi1_ahb",
+			"csi1",
+			"csi1_phy",
+			"csi1_pix",
+			"csi1_rdi",
+			"ahb",
+			"vfe0",
+			"csi_vfe0",
+			"vfe_ahb",
+			"vfe_axi";
 		vdda-supply = <&pm8916_l2>;
 		iommus = <&apps_iommu 3>;
 		ports {
-- 
2.7.4

