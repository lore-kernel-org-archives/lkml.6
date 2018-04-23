Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755946AbeDWPWB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:22:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22705 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755581AbeDWPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:20:56 -0400
From: Lionel Debieve <lionel.debieve@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ARM: dts: Add cryptographic support for stm32mp157c
Date: Mon, 23 Apr 2018 17:19:43 +0200
Message-ID: <20180423151947.2526-1-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches serie add support or RNG, CRYP and CRC IPs for stm32mp157c SoC
and add RNG default support for ev1 board.

Lionel Debieve (4):
  ARM: dts: stm32: Add RNG support on stm32mp157c
  ARM: dts: stm32: Enable RNG for stm32mp157c-ed1
  ARM: dts: stm32: Add CRYP support on stm32mp157c
  ARM: dts: stm32: Add CRC support on stm32mp157c

 arch/arm/boot/dts/stm32mp157c-ed1.dts |  4 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.15.1
