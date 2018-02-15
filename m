Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425520AbeBOQEC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:04:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26890 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1424460AbeBOQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:03:58 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/3] USB OTG on STM32H743
Date: Thu, 15 Feb 2018 17:03:21 +0100
Message-ID: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB OTG HS and FS on stm32h743 SoC.
It also enables USB OTG HS on stm32h743i-eval board in OTG (DRD) mode. It is
possible to use OTG HS in Peripheral or Host mode depending on the USB
connector.

Amelie Delaunay (3):
  ARM: dts: stm32: add USB OTG HS support for STM32H743 SoC
  ARM: dts: stm32: add USB OTG FS support for STM32H743 SoC
  ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval

 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 16 ++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.7.4
