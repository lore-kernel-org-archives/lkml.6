Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9A7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062020825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3062020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeKJAp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:45:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36326 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeKJApk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:45:40 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nSfbkTqVKji9; Fri,  9 Nov 2018 16:04:42 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89BAC1EC03C8;
        Fri,  9 Nov 2018 16:04:42 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H Peter Anvin" <hpa@zytor.com>, Shaohua Li <shli@kernel.org>,
        Tigran Aivazian <aivazian.tigran@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 3/4] x86/microcode: Add SPDX license identifiers
Date:   Fri,  9 Nov 2018 16:04:30 +0100
Message-Id: <20181109150431.14147-4-bp@alien8.de>
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

... and drop the GPL v2 license free text.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/microcode/amd.c   | 4 +---
 arch/x86/kernel/cpu/microcode/core.c  | 6 +-----
 arch/x86/kernel/cpu/microcode/intel.c | 6 +-----
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 07b5fc00b188..a1b02f2f0697 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  AMD CPU Microcode Update Driver for Linux
  *
@@ -17,9 +18,6 @@
  *
  *  Author: Jacob Shin <jacob.shin@amd.com>
  *  Fixes: Borislav Petkov <bp@suse.de>
- *
- *  Licensed under the terms of the GNU General Public
- *  License version 2. See file COPYING for details.
  */
 #define pr_fmt(fmt) "microcode: " fmt
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 2637ff09d6a0..b126180c15db 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * CPU Microcode Update Driver for Linux
  *
@@ -12,11 +13,6 @@
  *		  (C) 2015 Borislav Petkov <bp@alien8.de>
  *
  * This driver allows to upgrade microcode on x86 processors.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) "microcode: " fmt
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..e199d3140be0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Intel CPU Microcode Update Driver for Linux
  *
@@ -8,11 +9,6 @@
  *
  * Copyright (C) 2012 Fenghua Yu <fenghua.yu@intel.com>
  *		      H Peter Anvin" <hpa@zytor.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 /*
-- 
2.19.1

