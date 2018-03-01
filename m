Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935798AbeCAIJ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:09:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42470 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935665AbeCAIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:09:55 -0500
X-Google-Smtp-Source: AG47ELv/7VjWa4p/doCyC40OcL3R7rpyZvHfrnOBBKNmKXQDP9haY9hJ5TXUJOA6n+YGHoI+M2fR8Q==
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: arm@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geng Ren <geng.ren@spreadtrum.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] MAINTAINERS: Add Spreadtrum SoC entry
Date: Thu,  1 Mar 2018 16:09:15 +0800
Message-Id: <1519891755-17135-1-git-send-email-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Spreadtrum's maintainer entry and Orson, Baolin and me
as maintainers.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>

Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c104db..d232df9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1972,6 +1972,14 @@ M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
 F:	drivers/edac/altera_edac.
 
+ARM/SPREADTRUM SoC SUPPORT
+M:	Orson Zhai <orsonzhai@gmail.com>
+M:	Baolin Wang <baolin.wang@linaro.org>
+M:	Chunyan Zhang <zhang.lyra@gmail.com>
+S:	Maintained
+F:	arch/arm64/boot/dts/sprd
+N:	sprd
+
 ARM/STI ARCHITECTURE
 M:	Patrice Chotard <patrice.chotard@st.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4
