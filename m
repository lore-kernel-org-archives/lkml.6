Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeCLDif (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:38:35 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32908 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933219AbeCLDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:38:29 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <42417d5ef8cb0ecf0c333e5ebafd60de1e08cb08.1520825708.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1520825708.git.fthain@telegraphics.com.au>
References: <cover.1520825708.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/3] m68k/mac: Remove bogus "FIXME" comment
Date: Sun, 11 Mar 2018 23:38:28 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code works fine. The comment is misleading so remove it.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index e0a5e2dfeb46..6aa77d1af47a 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -329,10 +329,6 @@ static void via_shutdown(void)
 	}
 }
 
-/*
- * FIXME: not sure how this is supposed to work exactly...
- */
-
 static void oss_shutdown(void)
 {
 	oss->rom_ctrl = OSS_POWEROFF;
-- 
2.16.1
