Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeEQPsE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:48:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26967 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752506AbeEQPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:48:02 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] Add USB OTG HS support on stm32mp157c
Date: Thu, 17 May 2018 17:47:30 +0200
Message-ID: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB OTG HS on stm32mp157c SoC.
It also enables USB OTG HS on stm32mp157c-ev1 board in Peripheral mode.

Amelie Delaunay (2):
  ARM: dts: stm32: add USB OTG HS support for stm32mp157c SoC
  ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ev1.dts |  7 +++++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.7.4
