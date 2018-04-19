Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeDSOgJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:36:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26034 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751136AbeDSOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:36:07 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] Add STM32 RTC to stm32mp157c
Date: Thu, 19 Apr 2018 16:35:23 +0200
Message-ID: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STM32 RTC to stm32mp157c SoC and enable it
on stm32mp157c-ed1 board.

Amelie Delaunay (2):
  ARM: dts: stm32: add RTC support to stm32mp157c
  ARM: dts: stm32: enable RTC on stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 9 +++++++++
 2 files changed, 13 insertions(+)

-- 
2.7.4
