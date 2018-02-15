Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425308AbeBOPzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:55:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1425243AbeBOPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:55:22 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/3] USB OTG on STM32F7 boards
Date: Thu, 15 Feb 2018 16:54:37 +0100
Message-ID: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Peripheral mode on stm32f746 by adding
dwc2 gadget fifo sizes and enables USB OTG HS in OTG (DRD) mode on
stm32746g-eval and stm32f769-disco. It possible to use OTG HS in
Peripheral or Host mode, depending on the USB connector.

Amelie Delaunay (3):
  ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on stm32f746
  ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
  ARM: dts: stm32: enable USB HS on stm32f769-disco

 arch/arm/boot/dts/stm32746g-eval.dts  |  2 +-
 arch/arm/boot/dts/stm32f746.dtsi      |  3 +++
 arch/arm/boot/dts/stm32f769-disco.dts | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4
