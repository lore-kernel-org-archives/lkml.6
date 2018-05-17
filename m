Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEQMHt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:07:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751097AbeEQMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:07:47 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 0/3] Add STM32 RTC to stm32mp157c
Date: Thu, 17 May 2018 14:07:05 +0200
Message-ID: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STM32 RTC to stm32mp157c SoC and enables it
on stm32mp157c-ed1 board.

---
Changes in v2:
* Enable STM32 RTC in multi_v7_defconfig

Amelie Delaunay (3):
  ARM: dts: stm32: add RTC support to stm32mp157c
  ARM: dts: stm32: enable RTC on stm32mp157c-ed1
  ARM: multi_v7_defconfig: enable STM32 RTC

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 9 +++++++++
 arch/arm/configs/multi_v7_defconfig   | 1 +
 3 files changed, 14 insertions(+)

-- 
2.7.4
