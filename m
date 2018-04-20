Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbeDTJFh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:05:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753971AbeDTJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:05:35 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 0/3] Append additional I2C instances and activate I2C1.
Date: Fri, 20 Apr 2018 11:05:07 +0200
Message-ID: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG3NODE4.st.com (10.75.127.71) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch intends to appends 3 additional I2C instances (2, 3 and 4).
In the same time I2C1 is setup for both STM32F746 and STM32F769 Discovery
boards.
---
  Version history:
     v1:
        * Initial
---

Pierre-Yves MORDRET (3):
  ARM: dts: stm32: Append additional I2Cs for STM32F746 SoC
  ARM: dts: stm32: Add I2C1 support for STM32F769-DISCO Board
  ARM: dts: stm32: Add I2C1 support for STM32F746-DISCO Board

 arch/arm/boot/dts/stm32f746-disco.dts |  8 ++++++++
 arch/arm/boot/dts/stm32f746.dtsi      | 36 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f769-disco.dts |  8 ++++++++
 3 files changed, 52 insertions(+)

-- 
2.7.4
