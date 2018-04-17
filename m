Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeDQNqu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:46:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753608AbeDQNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:45:56 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH 0/4] Add STM32 timers to stm32mp157c
Date: Tue, 17 Apr 2018 15:45:26 +0200
Message-ID: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG7NODE6.st.com (10.75.127.85) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STM32 timers to stm32mp157c. These
timers can act PWM, trigger and/or encoder.
Populate stm32mp157c SOC and ed1/ev1 boards.

Fabrice Gasnier (4):
  ARM: dts: stm32: add timers support to stm32mp157c
  ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
  ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
  ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  27 +++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     |   7 +
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  36 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 283 ++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)

-- 
1.9.1
