Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965080AbeEIPSr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:18:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12498 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935296AbeEIPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:18:44 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] ARM: dts: stm32: update rtc st,syscfg
Date: Wed, 9 May 2018 17:18:12 +0200
Message-ID: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the lastest STM32 RTC driver updates, it is mandatory to define
pwrcfg control register and DBP (Disable Backup Protection) bit through
st,syscfg property. This patchset updates RTC nodes on stm32f429 and
stm32f746 accordingly.

Amelie Delaunay (2):
  ARM: dts: stm32: update rtc st,syscfg property on stm32f429
  ARM: dts: stm32: update rtc st,syscfg property on stm32f746

 arch/arm/boot/dts/stm32f429.dtsi | 2 +-
 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
