Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBA0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7CD20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7CD20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeKJApl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:45:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeKJApk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:45:40 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a2uG3_uPrMWg; Fri,  9 Nov 2018 16:04:41 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A85F31EC03C8;
        Fri,  9 Nov 2018 16:04:41 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Doug Thompson <norsk5@yahoo.com>,
        Doug Thompson <dougthompson@xmission.com>
Subject: [PATCH 2/4] EDAC, amd64: Add SPDX identifiers
Date:   Fri,  9 Nov 2018 16:04:29 +0100
Message-Id: <20181109150431.14147-3-bp@alien8.de>
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

While the license of these files can be deduced by the MODULE_LICENSE()
information, each source file should contain a SPDX identifier. Module
license 'GPL' is equivalent to GPL v2 only, i.e. the kernel license. Add
the corresponding SPDX identifier.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Doug Thompson <norsk5@yahoo.com>
Cc: Doug Thompson <dougthompson@xmission.com>
---
 drivers/edac/amd64_edac.c | 1 +
 drivers/edac/amd64_edac.h | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6ea98575a402..cece79f4ef8d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4242f8e39c18..7f1b0cf40663 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * AMD64 class Memory Controller kernel module
  *
  * Copyright (c) 2009 SoftwareBitMaker.
  * Copyright (c) 2009-15 Advanced Micro Devices, Inc.
- *
- * This file may be distributed under the terms of the
- * GNU General Public License.
  */
 
 #include <linux/module.h>
-- 
2.19.1

