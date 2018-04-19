Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDSNWm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:22:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36367 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751293AbeDSNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:22:40 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/4] rtc: stm32: fix copyright and adopt SPDX identifier
Date: Thu, 19 Apr 2018 15:21:40 +0200
Message-ID: <1524144103-21432-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copyright by removing "SA" and "for STMicroelectronics", not required.
Adopt SPDX identifier.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index f25dabe..79d9e86 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) STMicroelectronics SA 2017
- * Author:  Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
- * License terms:  GNU General Public License (GPL), version 2
+ * Copyright (C) STMicroelectronics 2017
+ * Author:  Amelie Delaunay <amelie.delaunay@st.com>
  */
 
 #include <linux/bcd.h>
-- 
2.7.4
