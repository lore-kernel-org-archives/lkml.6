Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754442AbeDTJPb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:15:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46473 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754417AbeDTJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:15:29 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 0/2] Add MDMA Support on STM32MP157C
Date: Fri, 20 Apr 2018 11:15:05 +0200
Message-ID: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MDMA support on STM32MP157C with configs and device tree.
---
  Version history:
     v1:
        * Initial
---

Pierre-Yves MORDRET (2):
  ARM: configs: stm32: Add MDMA support on STM32MP157C
  ARM: dts: stm32: Add MDMA support on STM32MP157C

 arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
 arch/arm/mach-stm32/Kconfig        |  1 +
 2 files changed, 11 insertions(+)

-- 
2.7.4
