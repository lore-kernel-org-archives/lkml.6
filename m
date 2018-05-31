Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeEaI20 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:28:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53943 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754042AbeEaI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:28:20 -0400
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Ludovic Barre" <ludovic.barre@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RESEND PATCH v4 0/2] mailbox: introduce STMicroelectronics STM32 IPCC driver
Date: Thu, 31 May 2018 10:27:23 +0200
Message-ID: <1527755245-27817-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.5.196]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STMicroelectronics STM32 Inter-Processor Communication Controller
(IPCC) is used for communicating data between two processors.
It provides a non blocking signaling mechanism to post and retrieve
communication data in an atomic way.

Changes since v4:
- add Rob's 'Reviewed-by' in dt bindings

Changes since v3:
- update after Jassi Brar review: remove 'driver.owner'

Changes since v2:
- update bindings and driver according to Rob's comments:
    - change compatible property to "st,stm32mp1-ipcc"
    - change "st,proc_id" property to "st,proc-id"
    - define all interrupts as mandatory

Fabien Dessenne (2):
  dt-bindings: mailbox: add STMicroelectronics STM32 IPCC binding
  mailbox: add STMicroelectronics STM32 IPCC driver

 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  47 +++
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/stm32-ipcc.c                       | 402 +++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
 create mode 100644 drivers/mailbox/stm32-ipcc.c

-- 
2.7.4
