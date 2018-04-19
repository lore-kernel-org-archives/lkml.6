Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeDSNXU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:23:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43422 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753059AbeDSNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:22:49 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/4] Various fixes on STM32 RTC
Date: Thu, 19 Apr 2018 15:21:39 +0200
Message-ID: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes some corrections on STM32 RTC:
- update copyright and adopt SPDX identifier
- fix alarm interrupt flags
- rework DBP (Disable Backup domain Protection) management.

This series is a preamble to the serie which will introduce next STM32 RTC
version.

Amelie Delaunay (4):
  rtc: stm32: fix copyright and adopt SPDX identifier
  rtc: stm32: fix alarm interrupt flags by removing IRQF_TRIGGER_RISING
  dt-bindings: rtc: update stm32-rtc documentation for st,syscfg
    property
  rtc: stm32: get DBP register and mask from DT st,syscfg property

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 10 ++--
 drivers/rtc/rtc-stm32.c                            | 68 +++++++++++++---------
 2 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.7.4
