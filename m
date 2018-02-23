Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWMv6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:51:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38800 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751089AbeBWMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:51:56 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 0/7] iio: adc: stm32-dfsdm: misc fixes and improvements
Date: Fri, 23 Feb 2018 13:50:54 +0100
Message-ID: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings some fixes and improvements to STM32 DFSDM driver.

Fabrice Gasnier (7):
  iio: adc: stm32-dfsdm: fix compatible data use
  iio: adc: stm32-dfsdm: fix call to stop channel
  iio: adc: stm32-dfsdm: fix clock source selection
  iio: adc: stm32-dfsdm: fix multiple channel initialization
  iio: adc: stm32-dfsdm: misc style improvements and fixes
  iio: adc: stm32-dfsdm: add check on max filter id
  iio: adc: stm32-dfsdm: add check on spi-max-frequency

 drivers/iio/adc/stm32-dfsdm-adc.c  | 52 ++++++++++++++++++++------------------
 drivers/iio/adc/stm32-dfsdm-core.c | 17 +++++++++++--
 2 files changed, 42 insertions(+), 27 deletions(-)

-- 
1.9.1
