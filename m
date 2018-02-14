Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966889AbeBNJ0I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:26:08 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46070 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966567AbeBNJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:26:06 -0500
X-Google-Smtp-Source: AH8x226lSlXe35xSPX27qNBZ7+lEzGwrOpVph7JLB5dFSSy/O561YgugqeyKxGUU/Ze8E0uTLOMycQ==
From: Progyan Bhattacharya <bprogyan@gmail.com>
X-Google-Original-From: Progyan Bhattacharya <progyanb@acm.org>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Cc: narmstrong@baylibre.com, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>,
        Joe Perches <joe@perches.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Build: Scripts/Makefile: Remove Repeated Lines
Date: Wed, 14 Feb 2018 14:55:58 +0530
Message-Id: <20180214092558.5846-1-progyanb@acm.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last two lines of code was repreated and was causing build error.

Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Joe Perches <joe@perches.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/Makefile.kasan | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index b7b9ecef44cc..69552a39951d 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -45,7 +45,3 @@ endif
 CFLAGS_KASAN_NOSANITIZE := -fno-builtin
 
 endif
-
-CFLAGS_KASAN_NOSANITIZE := -fno-builtin
-
-endif
-- 
2.16.1
