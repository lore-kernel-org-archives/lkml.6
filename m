Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeB0Jsm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:48:42 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5759 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752072AbeB0Jsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:48:41 -0500
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v1 0/6] Add different features for I2C
Date: Tue, 27 Feb 2018 10:48:08 +0100
Message-ID: <1519724894-21363-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append new I2C STM32F7 feature set. This includes 10 bit support, slave
support, SMBBus protocols support, DMA Support and eventually an I2C recovery
mechanism

---
  Version history:
    v1:
        * Initial
---
Pierre-Yves MORDRET (6):
  i2c: i2c-stm32f7: Add 10-bit address support
  i2c: i2c-stm32f7: Add slave support
  i2c: i2c-stm32f7: Add initial SMBus protocols support
  i2c: i2c-stm32: Add generic DMA API
  i2c: i2c-stm32f7: Add DMA support
  i2c: i2c-stm32f7: Implement I2C recovery mechanism

 drivers/i2c/busses/Kconfig       |    1 +
 drivers/i2c/busses/Makefile      |    3 +-
 drivers/i2c/busses/i2c-stm32.c   |  153 ++++++
 drivers/i2c/busses/i2c-stm32.h   |   37 ++
 drivers/i2c/busses/i2c-stm32f7.c | 1047 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 1214 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.c

-- 
2.7.4
