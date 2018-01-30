Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeA3TZp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:25:45 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39134 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeA3TZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:25:02 -0500
X-Google-Smtp-Source: AH8x227Ic25610EmmxLCrh23sR/ZzQWbIcwBxEJssgBeavqx3cgr3xpswzidLXUIfLHMI6DZw1E4wQ==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v2 08/10] MIPS: kconfig: Remove empty help text
Date: Tue, 30 Jan 2018 20:23:03 +0100
Message-Id: <20180130192349.8420-9-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130192349.8420-1-ulfalizer@gmail.com>
References: <20180130192349.8420-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ab98569994f0..57cd591e7b28 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2326,7 +2326,6 @@ config MIPS_VPE_LOADER_TOM
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
 	depends on MIPS_VPE_LOADER
-	help
 
 config MIPS_VPE_APSP_API_CMP
 	bool
-- 
2.14.1
