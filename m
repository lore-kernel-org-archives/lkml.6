Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBANpy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:45:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47241 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751559AbeBANpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:45:45 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 0/3] Add pwm-cells on STM32 LPTimer
Date: Thu, 1 Feb 2018 14:44:35 +0100
Message-ID: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
of channel, period and polarity.

Fabrice Gasnier (1):
  ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743

Gerald Baeza (2):
  dt-bindings: pwm-stm32-lp: add #pwm-cells
  pwm: stm32: LPTimer: use 3 cells xlate

 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
 arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
 drivers/pwm/pwm-stm32-lp.c                             | 2 ++
 3 files changed, 10 insertions(+)

-- 
1.9.1
