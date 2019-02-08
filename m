Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D3521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBHWZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:25:09 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:56822 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHWZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:25:09 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 193E219F4EA;
        Fri,  8 Feb 2019 23:24:31 +0100 (CET)
Subject: [PATCH v4 3/7] dt-bindings: phy-qcom-qmp: Add
 qcom,msm8998-qmp-ufs-phy
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Message-ID: <dade6a09-ab00-82f6-eb5b-bc2b09ed5162@free.fr>
Date:   Fri, 8 Feb 2019 23:13:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for QMP UFS phy on msm8998.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 4ff26dbf4310..5d181fc3cc18 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -10,6 +10,7 @@ Required properties:
 	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
 	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
+	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
 	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
@@ -45,6 +46,8 @@ Required properties:
 			"aux", "cfg_ahb", "ref".
 		For "qcom,msm8998-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref".
+		For "qcom,msm8998-qmp-ufs-phy" must contain:
+			"ref", "ref_aux".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
@@ -66,6 +69,7 @@ Required properties:
 			"phy", "common".
 		For "qcom,msm8998-qmp-usb3-phy" must contain
 			"phy", "common".
+		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
-- 
2.17.1
