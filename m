Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbeDXJmc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:42:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26599 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753282AbeDXJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:42:25 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 0/4] Add STM32 USBPHYC to stm32mp157c
Date: Tue, 24 Apr 2018 11:41:41 +0200
Message-ID: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STM32 USB PHY Controller (USBPHYC) to
stm32mp157c SoC and enables it on stm32mp157c-ev1 board.

---
Changes in v2:
* Add reset dt-bindings include
* Add fixed regulators
* Enable CONFIG_PHY_STM32_USBPHYC in multi_v7_defconfig

Amelie Delaunay (4):
  ARM: dts: stm32: add USBPHYC support to stm32mp157c
  ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
  ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
  ARM: multi_v7_defconfig: enable STM32 USB PHY Controller (USBPHYC)

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 36 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts |  5 +++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 21 ++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig   |  1 +
 4 files changed, 63 insertions(+)

-- 
2.7.4
