Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeBSIrS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:47:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752120AbeBSIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:47:02 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 0/3] USB OTG on STM32H743
Date: Mon, 19 Feb 2018 09:46:25 +0100
Message-ID: <1519029988-9261-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB OTG HS and FS on stm32h743 SoC.
It also enables USB OTG HS on stm32h743i-eval board in OTG (DRD) mode. It is
possible to use OTG HS in Peripheral or Host mode depending on the USB
connector.

---

Changes in v2:
- Fix compatible string (https://patchwork.kernel.org/patch/10222153/)

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
