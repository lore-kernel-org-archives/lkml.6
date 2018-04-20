Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754470AbeDTJGR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:06:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16250 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754360AbeDTJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:05:48 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 0/2] Add I2C support for STM32H743
Date: Fri, 20 Apr 2018 11:05:20 +0200
Message-ID: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C support on STM32H743 SoC.
Activate I2C1 on STM32H743I Evaluation Board.
---
  Version history:
     v1:
        * Initial
---

Pierre-Yves MORDRET (2):
  ARM: dts: stm32: Add I2C support for STM32H743 SoC
  ARM: dts: stm32: Add I2C1 support for STM32H743I-EVAL Board

 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 +++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 48 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    |  8 ++++++
 3 files changed, 66 insertions(+)

-- 
2.7.4
