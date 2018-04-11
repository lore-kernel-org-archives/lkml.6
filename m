Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeDKQlq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:41:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45488 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbeDKQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:41:42 -0400
X-Google-Smtp-Source: AIpwx4+QxeswF99YXeDW/JWzMJCaSRy8Df4bBK7XvPFZPSZmrjmaqezOUUzGFHEVwjzKokhqLCnMdw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] arm64: dts: actions: Add S900 SPS node
Date: Wed, 11 Apr 2018 22:10:34 +0530
Message-Id: <20180411164036.8046-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Actions Semi S900 Smart Power System (SPS) node

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 11406f6d3a6d..0b29dbe0030e 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -154,6 +154,12 @@
 			status = "disabled";
 		};
 
+		sps: power-controller@e012e000 {
+			compatible = "actions,s900-sps";
+			reg = <0x0 0xe012e000 0x0 0x2000>;
+			#power-domain-cells = <1>;
+		};
+
 		timer: timer@e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
