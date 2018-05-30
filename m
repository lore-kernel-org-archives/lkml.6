Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeE3QmA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:42:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28111 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932119AbeE3Qly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:41:54 -0400
Message-Id: <25e6eaa136ed6a0e0be2c13701e57d2e3cc85cbb.1527697995.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527697995.git.christophe.leroy@c-s.fr>
References: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 4/8] powerpc: remove superflous inclusions of
 asm/feature-fixups.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

files not using feature fixup don't need asm/feature-fixups.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h | 1 -
 arch/powerpc/include/asm/firmware.h | 1 -
 arch/powerpc/include/asm/mmu.h      | 1 -
 arch/powerpc/include/asm/reg.h      | 1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 7518dafa7cd4..e99905274a77 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/types.h>
-#include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 535add3f7791..59ae44cf0bb8 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -15,7 +15,6 @@
 #ifdef __KERNEL__
 
 #include <asm/asm-compat.h>
-#include <asm/feature-fixups.h>
 
 /* firmware feature bitmask values */
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 61d15ce92278..61d0d2d69583 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 #include <asm/asm-compat.h>
-#include <asm/feature-fixups.h>
 
 /*
  * MMU features bit definitions
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cb0f272ce123..a7b8860ed896 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -13,6 +13,7 @@
 
 #include <linux/stringify.h>
 #include <asm/cputable.h>
+#include <asm/feature-fixups.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-- 
2.13.3
