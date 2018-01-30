Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbeA3TZM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:25:12 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40550 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbeA3TZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:25:05 -0500
X-Google-Smtp-Source: AH8x226cmkV6rIwkgSewMwZPbePLX1zf7wYEBbCY3YZOYOgfzpktg3KdXHgOcYx4nne89Q9tJeCnDg==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/10] arm: vt8500: kconfig: Remove empty help text
Date: Tue, 30 Jan 2018 20:23:04 +0100
Message-Id: <20180130192349.8420-10-ulfalizer@gmail.com>
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
 arch/arm/mach-vt8500/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 1156a585dafc..8841199058ea 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -13,7 +13,6 @@ config ARCH_WM8505
  	depends on ARCH_MULTI_V5
  	select ARCH_VT8500
  	select CPU_ARM926T
- 	help
 
 config ARCH_WM8750
 	bool "WonderMedia WM8750"
-- 
2.14.1
