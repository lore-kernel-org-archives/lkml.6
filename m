Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeCIG6P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:58:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18765 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750897AbeCIG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:58:11 -0500
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
Subject: [PATCH RESEND 0/2] Add dsi clock for stm32f469 board
Date: Fri, 9 Mar 2018 07:57:29 +0100
Message-ID: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set adds the dsi clock for stm32f469 board.

Gabriel Fernandez (2):
  clk: stm32: END_PRIMARY_CLK should be declare after CLK_SYSCLK
  clk: stm32: Add DSI clock for STM32F469 Board

 drivers/clk/clk-stm32f4.c                 | 11 ++++++++++-
 include/dt-bindings/clock/stm32fx-clock.h |  7 ++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
1.9.1
