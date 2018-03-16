Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeCPJpf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:45:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58108 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeCPJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:45:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F58460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] dt-bindings: phy-qcom-qmp: Update bindings for sdm845
Date: Fri, 16 Mar 2018 15:14:56 +0530
Message-Id: <1521193500-4696-4-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update compatible strings for USB3 PHYs on SDM845.
One is QMPv3 DisplayPort-USB combo PHY and other one
is USB UNI PHY which is single lane USB3 PHY without
DP capability.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index dcf1b8f..cef8765 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -9,7 +9,9 @@ Required properties:
 	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
 	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
-	       "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy.
+	       "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
+	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
+	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
 
  - reg: offset and length of register set for PHY's common serdes block.
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
