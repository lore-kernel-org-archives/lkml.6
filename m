Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeBZNEO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:04:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3196 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753197AbeBZNEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:04:12 -0500
From: Alexandre Torgue <alexandre.torgue@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] MAINTAINERS: update entries for ARM/STM32
Date: Mon, 26 Feb 2018 14:03:48 +0100
Message-ID: <1519650228-6271-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes old git repository to the maintained one and adds more patterns.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..802b984 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1999,8 +1999,10 @@ M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
 M:	Alexandre Torgue <alexandre.torgue@st.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
 N:	stm32
+F:	arch/arm/boot/dts/stm32*
+F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
 
 ARM/TANGO ARCHITECTURE
-- 
2.7.4
