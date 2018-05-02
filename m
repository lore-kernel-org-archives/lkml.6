Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeEBNVy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:21:54 -0400
Received: from ozlabs.org ([203.11.71.1]:40415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbeEBNVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:21:12 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] powerpc/syscalls: timer_create can be handle by perfectly normal COMPAT_SYS_SPU
Date: Wed,  2 May 2018 23:20:51 +1000
Message-Id: <20180502132051.28861-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/include/asm/systbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index cdf528089a63..79a3b47e4839 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -245,7 +245,7 @@ SYSCALL_SPU(epoll_create)
 SYSCALL_SPU(epoll_ctl)
 SYSCALL_SPU(epoll_wait)
 SYSCALL_SPU(remap_file_pages)
-SYSX_SPU(sys_timer_create,compat_sys_timer_create,sys_timer_create)
+COMPAT_SYS_SPU(timer_create)
 COMPAT_SYS_SPU(timer_settime)
 COMPAT_SYS_SPU(timer_gettime)
 SYSCALL_SPU(timer_getoverrun)
-- 
2.14.1
