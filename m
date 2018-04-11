Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeDKOpE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:45:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5935 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752807AbeDKOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:45:02 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 0/2] Append some fixes and improvements
Date: Wed, 11 Apr 2018 16:44:37 +0200
Message-ID: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue with FIFO Size and burst size.
Fix an incomplete allocator for Hardware descriptors: memory badly
allocated.
---
  Version history:
    v1:
       * Initial
    v2:
       * Fix kbuild warning format: /0x%08x/%pad/
---

Pierre-Yves MORDRET (2):
  dmaengine: stm32-mdma: align TLEN and buffer length on burst
  dmaengine: stm32-mdma: Fix incomplete Hw descriptors allocator

 drivers/dma/stm32-mdma.c | 92 ++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

-- 
2.7.4
