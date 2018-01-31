Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeAaJgS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:36:18 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36370 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbeAaJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:36:12 -0500
X-Google-Smtp-Source: AH8x226K0MzT5NTDWxMbBv+z/WEGQwtmzWhlRHl03CqewwHoywlAhSneZP9QRcRF2A8bb7HBRUm5uA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>,
        Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH 10/11] nios2: kconfig: Remove blank help text
Date: Wed, 31 Jan 2018 10:34:29 +0100
Message-Id: <20180131093434.20050-11-ulfalizer@gmail.com>
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
 arch/nios2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 60fae03dac79..3d4ec88f1db1 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -152,7 +152,6 @@ menu "Advanced setup"
 
 config ADVANCED_OPTIONS
 	bool "Prompt for advanced kernel configuration options"
-	help
 
 comment "Default settings for advanced configuration options are used"
 	depends on !ADVANCED_OPTIONS
-- 
2.14.1
