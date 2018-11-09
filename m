Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E7C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F43021104
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F43021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKJApm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:45:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbeKJApl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:45:41 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ecbT6y9onMEn; Fri,  9 Nov 2018 16:04:43 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EF601EC03C8;
        Fri,  9 Nov 2018 16:04:43 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, dmitriyz@google.com,
        Huang Ying <ying.huang@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/4] x86/mce: Add an SPDX license identifiers
Date:   Fri,  9 Nov 2018 16:04:31 +0100
Message-Id: <20181109150431.14147-5-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109150431.14147-1-bp@alien8.de>
References: <20181109150431.14147-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add the SPDX tag and remove the GPL-v2 free text.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: <dmitriyz@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mcheck/dev-mcelog.c   |  1 +
 arch/x86/kernel/cpu/mcheck/mce-apei.c     | 14 +-------------
 arch/x86/kernel/cpu/mcheck/mce-genpool.c  |  3 +--
 arch/x86/kernel/cpu/mcheck/mce-inject.c   |  9 +--------
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  6 +-----
 arch/x86/kernel/cpu/mcheck/mce.c          |  1 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c  |  1 +
 7 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
index 27f394ac983f..11e521799b1d 100644
--- a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * /dev/mcelog driver
  *
diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index 2eee85379689..992c7e599d0b 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Bridge between MCE and APEI
  *
@@ -13,19 +14,6 @@
  *
  * Copyright 2010 Intel Corp.
  *   Author: Huang Ying <ying.huang@intel.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/export.h>
diff --git a/arch/x86/kernel/cpu/mcheck/mce-genpool.c b/arch/x86/kernel/cpu/mcheck/mce-genpool.c
index 217cd4449bc9..f59996563e96 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-genpool.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-genpool.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MCE event pool management in MCE context
  *
  * Copyright (C) 2015 Intel Corp.
  * Author: Chen, Gong <gong.chen@linux.intel.com>
- *
- * This file is licensed under GPLv2.
  */
 #include <linux/smp.h>
 #include <linux/mm.h>
diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index 1fc424c40a31..e33ca8ac74a0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Machine check injection support.
  * Copyright 2008 Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
  * Authors:
  * Andi Kleen
  * Ying Huang
@@ -16,9 +12,6 @@
  * built as module so that it can be loaded on production kernels for
  * testing purposes.
  *
- * This file may be distributed under the terms of the GNU General Public
- * License version 2.
- *
  * Copyright (c) 2010-17:  Borislav Petkov <bp@alien8.de>
  *			   Advanced Micro Devices Inc.
  */
diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index 44396d521987..be9bf3d0c6db 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MCE grading rules.
  * Copyright 2008, 2009 Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
  * Author: Andi Kleen
  */
 #include <linux/kernel.h>
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8c66d2fc8f81..20d14aa36a73 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Machine check handler.
  *
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 2da67b70ba98..0d3f6b6a5739 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Thermal throttle event support code (such as syslog messaging and rate
  * limiting) that was factored out from x86_64 (mce_intel.c) and i386 (p4.c).
-- 
2.19.1

