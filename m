Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeDKJr5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:47:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29818 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752954AbeDKJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:47:56 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 4/5] ARM: dts: stm32: add orange and blue leds on stm32746g-eval
Date: Wed, 11 Apr 2018 11:47:04 +0200
Message-ID: <1523440025-18077-5-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orange (LD2) and blue (LD4) leds on stm32746g-eval are connected on
STMFX gpio expander, offset 17 and 19.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index bd9a33d..fd03f54 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -67,9 +67,15 @@
 			gpios = <&gpiof 10 1>;
 			linux,default-trigger = "heartbeat";
 		};
+		orange {
+			gpios = <&stmfxgpio 17 1>;
+		};
 		red {
 			gpios = <&gpiob 7 1>;
 		};
+		blue {
+			gpios = <&stmfxgpio 19 1>;
+		};
 	};
 
 	gpio_keys {
-- 
2.7.4
