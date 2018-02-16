Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030545AbeBPNRm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:17:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:63743 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030435AbeBPNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:17:20 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] RTC support on STM32H743
Date: Fri, 16 Feb 2018 14:16:38 +0100
Message-ID: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for RTC on STM32H743 and enables it on stm32h743i-eval.
Tested on stm32-next.

Amelie Delaunay (2):
  ARM: dts: stm32: add RTC support on STM32H743
  ARM: dts: stm32: enable RTC on stm32h743i-eval

 arch/arm/boot/dts/stm32h743.dtsi      | 15 +++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts |  4 ++++
 2 files changed, 19 insertions(+)

-- 
2.7.4
