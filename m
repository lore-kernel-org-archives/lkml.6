Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeA3TZL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:25:11 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44936 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeA3TZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:25:09 -0500
X-Google-Smtp-Source: AH8x224vzhiw4xJOtBN5/u3knvHSXwREAIvxkfxlKo6B8ruEONNj1JwL7YReGnwIjhizh/Hntmijag==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v2 10/10] nios2: kconfig: Remove empty help text
Date: Tue, 30 Jan 2018 20:23:05 +0100
Message-Id: <20180130192349.8420-11-ulfalizer@gmail.com>
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
