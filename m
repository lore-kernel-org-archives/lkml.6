Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeCMRQa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:16:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34206 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752149AbeCMRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:16:27 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 0/2] Append some fixes and improvements
Date: Tue, 13 Mar 2018 18:16:04 +0100
Message-ID: <1520961366-27473-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_08:,,
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
---

Pierre-Yves MORDRET (2):
  dmaengine: stm32-mdma: align TLEN and buffer length on burst
  dmaengine: stm32-mdma: Fix incomplete Hw descriptors allocator

 drivers/dma/stm32-mdma.c | 92 ++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

-- 
2.7.4
