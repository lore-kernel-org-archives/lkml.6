Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeD3HLz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:11:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45356 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751729AbeD3HLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:11:50 -0400
From: Ludovic Barre <ludovic.Barre@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 0/2] ARM: dts: stm32: add qspi support for stm32mp157c
Date: Mon, 30 Apr 2018 09:11:19 +0200
Message-ID: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds qspi support for stm32mp157c SoC
and its eval board.

Ludovic Barre (2):
  ARM: dts: stm32: add qspi support for stm32mp157c
  ARM: dts: stm32: add flash nor support on stm32mp157c eval board

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 45 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 25 +++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 11 ++++++++
 3 files changed, 81 insertions(+)

-- 
2.7.4
