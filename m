Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756576AbeDXHyj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:54:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45644 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756072AbeDXHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:54:33 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Philippe Cornu <philippe.cornu@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        "Gerald Baeza" <gerald.baeza@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "Kamel Kholti" <kamel.kholti@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 2/3] ARM: dts: stm32: add cec pins to stm32mp157c
Date: Tue, 24 Apr 2018 09:54:08 +0200
Message-ID: <1524556449-5262-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
References: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds cec support on stm32mp157c eval board.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..67b0349 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -14,6 +14,15 @@
 			ranges = <0 0x50002000 0xa400>;
 			pins-are-numbered;
 
+			cec_pins_a: cec@0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 15, AF4)>;
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
 			gpioa: gpio@50002000 {
 				gpio-controller;
 				#gpio-cells = <2>;
-- 
1.9.1
