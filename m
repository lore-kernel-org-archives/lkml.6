Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51962C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B5A20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B5A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeICTRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:17:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:17:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83Eufi93339867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:56:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83EufGc3339864;
        Mon, 3 Sep 2018 07:56:41 -0700
Date:   Mon, 3 Sep 2018 07:56:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-901d209a8b0e448dadbc830bc7d7951d1c9621f9@git.kernel.org>
Cc:     jgross@suse.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, boris.ostrovsky@oracle.com, hpa@zytor.com
Reply-To: mingo@kernel.org, jgross@suse.com, tglx@linutronix.de,
          hpa@zytor.com, boris.ostrovsky@oracle.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180828074026.820-5-jgross@suse.com>
References: <20180828074026.820-5-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/xen: Add SPDX identifier in arch/x86/xen
 files
Git-Commit-ID: 901d209a8b0e448dadbc830bc7d7951d1c9621f9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  901d209a8b0e448dadbc830bc7d7951d1c9621f9
Gitweb:     https://git.kernel.org/tip/901d209a8b0e448dadbc830bc7d7951d1c9621f9
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:33 +0200

x86/xen: Add SPDX identifier in arch/x86/xen files

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-5-jgross@suse.com

---
 arch/x86/xen/efi.c                 | 14 +-------------
 arch/x86/xen/enlighten.c           |  2 ++
 arch/x86/xen/enlighten_hvm.c       |  2 ++
 arch/x86/xen/grant-table.c         | 25 +------------------------
 arch/x86/xen/mmu.c                 |  2 ++
 arch/x86/xen/mmu_pv.c              |  2 ++
 arch/x86/xen/p2m.c                 |  2 ++
 arch/x86/xen/pci-swiotlb-xen.c     |  2 ++
 arch/x86/xen/platform-pci-unplug.c | 16 ++--------------
 arch/x86/xen/vdso.h                |  2 ++
 arch/x86/xen/xen-pvh.S             | 15 ++-------------
 11 files changed, 20 insertions(+), 64 deletions(-)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 1804b27f9632..1fbb629a9d78 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Oracle Co., Daniel Kiper
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/bitops.h>
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 2eeddd814653..749fb4b73eda 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 #include <linux/bootmem.h>
 #endif
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 19c1ff542387..0e75642d42a3 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/kexec.h>
diff --git a/arch/x86/xen/grant-table.c b/arch/x86/xen/grant-table.c
index 92ccc718152d..ecb0d5450334 100644
--- a/arch/x86/xen/grant-table.c
+++ b/arch/x86/xen/grant-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /******************************************************************************
  * grant_table.c
  * x86 specific part
@@ -8,30 +9,6 @@
  * Copyright (c) 2004-2005, K A Fraser
  * Copyright (c) 2008 Isaku Yamahata <yamahata at valinux co jp>
  *                    VA Linux Systems Japan. Split out x86 specific part.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation; or, when distributed
- * separately from the Linux kernel or incorporated into other
- * software packages, subject to the following license:
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this source file (the "Software"), to deal in the Software without
- * restriction, including without limitation the rights to use, copy, modify,
- * merge, publish, distribute, sublicense, and/or sell copies of the Software,
- * and to permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
  */
 
 #include <linux/sched.h>
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index e0e13fe16d37..60e9c37fd79f 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #include <linux/pfn.h>
 #include <asm/xen/page.h>
 #include <asm/xen/hypercall.h>
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b0691c7a3951..b565c5038be1 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Xen mmu operations
  *
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 159a897151d6..d6d74efd8912 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Xen leaves the responsibility for maintaining p2m mappings to the
  * guests themselves, but it must also access and update the p2m array
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 37c6056a7bba..33293ce01d8d 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /* Glue code to lib/swiotlb-xen.c */
 
 #include <linux/dma-mapping.h>
diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 3957946a6cfe..2e794ac9d8e8 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /******************************************************************************
  * platform-pci-unplug.c
  *
  * Xen platform PCI device driver
  * Copyright (c) 2010, Citrix
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
  */
 
 #include <linux/init.h>
diff --git a/arch/x86/xen/vdso.h b/arch/x86/xen/vdso.h
index 861fedfe5230..873c54c488fe 100644
--- a/arch/x86/xen/vdso.h
+++ b/arch/x86/xen/vdso.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /* Bit used for the pseudo-hwcap for non-negative segments.  We use
    bit 1 to avoid bugs in some versions of glibc when bit 0 is
    used; the choice is otherwise arbitrary. */
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index ca2d3b2bf2af..b0e471506cd8 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright C 2016, Oracle and/or its affiliates. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 	.code32
