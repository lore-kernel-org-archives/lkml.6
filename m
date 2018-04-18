Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeDRPjG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:39:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1683 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751383AbeDRPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:39:04 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: [PATCH 0/3] Add support for STM32MP1 ADC
Date: Wed, 18 Apr 2018 17:37:51 +0200
Message-ID: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG3NODE6.st.com (10.75.127.73) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for STM32MP1 Analog to Digital Converter variant.
It's quite similar to STM32H7 ADC and re-use most of existing driver.

Fabrice Gasnier (3):
  dt-bindings: iio: stm32-adc: add support for STM32MP1.
  iio: adc: stm32-adc: add support for STM32MP1
  ARM: dts: stm32: Add ADC support to stm32mp157c

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  6 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 | 32 +++++++++++
 drivers/iio/adc/stm32-adc-core.c                   | 66 ++++++++++++++++------
 drivers/iio/adc/stm32-adc.c                        | 47 +++++++++++++--
 4 files changed, 128 insertions(+), 23 deletions(-)

-- 
1.9.1
