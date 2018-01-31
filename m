Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeAaJgR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:36:17 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44466 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbeAaJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:36:08 -0500
X-Google-Smtp-Source: AH8x224QJ0JPUYe9ZUxh5fEi3DKxfE//UZjWBvxj/9NCZZFwl69zTssDFLVyUh6rSTkP6ILsLdSGfg==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/11] arm: vt8500: kconfig: Remove blank help text
Date: Wed, 31 Jan 2018 10:34:28 +0100
Message-Id: <20180131093434.20050-10-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to remove them, IMO.

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
