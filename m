Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeE2Exe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:53:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40545 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeE2ExZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:53:25 -0400
X-Google-Smtp-Source: AB8JxZoDIrdhpJ7SgOGPSRTQFstOxASRwjSS7Pi0xNZ0AETrpa5EtoECDqf180ToMsvYu39QCPdQrg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: matthias.bgg@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: Add vendor prefix for ArcherMind
Date: Tue, 29 May 2018 10:22:57 +0530
Message-Id: <20180529045258.1415-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
References: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for ArcherMind Technology (Nanjing) Co., Ltd.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a38d8bfae19c..f601acb5a0b4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -32,6 +32,7 @@ andestech	Andes Technology Corporation
 apm	Applied Micro Circuits Corporation (APM)
 aptina	Aptina Imaging
 arasan	Arasan Chip Systems
+archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
-- 
2.17.0
