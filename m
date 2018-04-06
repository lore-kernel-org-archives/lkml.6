Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeDFGky (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:40:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6717 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751849AbeDFGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:40:24 -0400
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: [PATCH 0/6] stm32mp1 clock update
Date: Fri, 6 Apr 2018 08:39:27 +0200
Message-ID: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set adds minor corrections
- sparse corections
- add tzc2 missing clock
- remove unused constant
- fix SAI3 & SAI4 clocks
- set stgen_k clock as critical
- remove not useful ck_apb_dbg clock

Gabriel Fernandez (6):
  clk: stm32mp1: add missing static
  clk: stm32mp1: remove unused dfsdm_src[] const
  clk: stm32mp1: fix SAI3 & SAI4 clocks
  clk: stm32mp1: add missing tzc2 clock
  clk: stm32mp1: set stgen_k clock as critical
  clk: stm32mp1: remove unuseless ck_apb_dbg clock

 drivers/clk/clk-stm32mp1.c                | 54 +++++++++++++------------------
 include/dt-bindings/clock/stm32mp1-clks.h |  4 +--
 2 files changed, 25 insertions(+), 33 deletions(-)

-- 
1.9.1
