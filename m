Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeFEQfp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:35:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37712 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeFEQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:35:42 -0400
X-Google-Smtp-Source: ADUXVKJVNQFURnivj3hruBgMDFvmEuT2ul4BIZluxG1+SwpJx7WwrAXpDMfBX1FwWeamqTUaPBiaoQ==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: matthias.bgg@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
Date: Tue,  5 Jun 2018 22:04:41 +0530
Message-Id: <20180605163442.4812-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Mediatek X20 Development Board which is a 96Boards Consumer
Edition platform based on MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab37c19c..356df1ee11b9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -47,6 +47,9 @@ Supported boards:
 - Evaluation board for MT6797(Helio X20):
     Required root node properties:
       - compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
+- Mediatek X20 Development Board:
+    Required root node properties:
+      - compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
 - Reference board variant 1 for MT7622:
     Required root node properties:
       - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
-- 
2.17.0
