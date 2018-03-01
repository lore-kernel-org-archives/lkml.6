Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967663AbeCAK4A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:56:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41602 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967326AbeCAKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:54:23 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@st.com>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH v2 0/6] Add mmc support for STM32F7 boards
Date: Thu, 1 Mar 2018 11:53:37 +0100
Message-ID: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series adds :
 _ SDIO pins definition for STM32F7 SoCs family
 _ add sdio1 DT entry for STM32F746 Discovery board
 _ add sdio1 DT entry for STM32F746 Evaluation board
 _ add sdio1 DT entry for STM32F769 Discovery board
 _ add SDMMC2 entry in stm32f7-rcc.h
 _ replace sdio2 hard coded value in stm32f746.dtsi

v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a 
      and update board dts files accordingly.


Patrice Chotard (6):
  ARM: dts: stm32: Add sdio pins definition for stm32f7
  ARM: dts: stm32: Enable sdio1 for stm32f746-disco
  ARM: dts: stm32: Enable sdio1 for stm32f746-eval
  ARM: dts: stm32: Enable sdio1 for stm32f769-disco
  dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
  ARM: dts: stm32: Fix sdio2 rcc hard coded value

 arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
 arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
 arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
 include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
 6 files changed, 119 insertions(+), 1 deletion(-)

-- 
1.9.1
