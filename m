Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F0C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F9F2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfBMKH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:07:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727580AbfBMKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:07:58 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DA74FY032062;
        Wed, 13 Feb 2019 11:07:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qhv0m6ef4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:07:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FDE838;
        Wed, 13 Feb 2019 10:07:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E26A2CFC;
        Wed, 13 Feb 2019 10:07:46 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 11:07:45
 +0100
From:   <gabriel.fernandez@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: clock: remove unused definition for stm32mp1
Date:   Wed, 13 Feb 2019 11:07:14 +0100
Message-ID: <20190213100714.15622-1-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

LTDC_K and ETHMAC_K are not used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 include/dt-bindings/clock/stm32mp1-clks.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
index 90ec780bfc68..4cdaf135829c 100644
--- a/include/dt-bindings/clock/stm32mp1-clks.h
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -248,7 +248,4 @@
 
 #define STM32MP1_LAST_CLK 232
 
-#define LTDC_K		LTDC_PX
-#define ETHMAC_K	ETHCK_K
-
 #endif /* _DT_BINDINGS_STM32MP1_CLKS_H_ */
-- 
2.17.0

