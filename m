Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755049AbeBOIVQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:21:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42039 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754864AbeBOIVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:21:12 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Vincent Abriou" <vincent.abriou@st.com>
Subject: [PATCH 0/3] ARM: dts: stm32: Add display support on stm32f469-disco
Date: Thu, 15 Feb 2018 09:20:11 +0100
Message-ID: <20180215082014.30383-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.172]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds the mipi dsi support to stm32f469 and enables it 
on the stm32f469-disco board.

Philippe CORNU (1):
  ARM: dts: stm32: Add display support on stm32f469-disco

Philippe Cornu (2):
  ARM: dts: stm32: Add dt-bindings gpio.h include on stm32f469-disco
  ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi

 arch/arm/boot/dts/stm32f469-disco.dts | 54 +++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/stm32f469.dtsi      | 19 ++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32f469.dtsi

-- 
2.15.1
