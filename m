Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeDWJuX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:50:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1235 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754308AbeDWJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:49:15 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 0/5] Add STM32F7 I2C Support on STM32MP157C
Date: Mon, 23 Apr 2018 11:48:26 +0200
Message-ID: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds STM32MP157C I2C support on STM32MP157C with configs and device
tree.
In the same way I2C4 is enabled for STM32MP157C ED1 Daughter bord.
I2C2/5 is enabled on STM32MP157C EV1 Daughter board on Evaluation board.
---
  Version history:
     v1:
        * Initial
     v2:
        * Disambiguate subjects
---

Pierre-Yves MORDRET (5):
  ARM: multi_v7_defconfig: Add STM32F7 I2C support
  ARM: dts: stm32: Add STM32F7 I2C support for STM32MP157C SoC
  ARM: dts: stm32: Add I2Cs pin control on STM32MP157C
  ARM: dts: stm32: Add I2C4 support for STM32MP157C-ED1
  ARM: dts: stm32: Add I2C2/5 support for STM32MP157C-EV1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 40 ++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     |  8 ++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 17 +++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 77 +++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig       |  1 +
 5 files changed, 143 insertions(+)

-- 
2.7.4
