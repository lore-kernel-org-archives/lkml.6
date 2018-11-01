Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B957A2084A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B957A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeKBAD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:03:58 -0400
Received: from mail114-240.sinamail.sina.com.cn ([218.30.114.240]:41539 "HELO
        mail114-240.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728440AbeKBAD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:03:58 -0400
Received: from unknown (HELO localhost.localdomain.localdomain)([110.184.32.116])
        by sina.com with ESMTP
        id 5BDB15070000372A; Thu, 1 Nov 2018 23:00:29 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 52937925953455
From:   Peng Hao <penghao122@sina.com.cn>
To:     rkrcmar@redhat.com, tglx@linutronix.de, pbonzini@redhat.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH v2]  x86/kvmclock : convert to SPDX identifiers
Date:   Thu,  1 Nov 2018 11:00:21 -0400
Message-Id: <1541084421-4797-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kernel/kvmclock.c | 15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e67646..0ebd715 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*  KVM paravirtual clock driver. A clocksource implementation
     Copyright (C) 2008 Glauber de Oliveira Costa, Red Hat Inc.
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
 
 #include <linux/clocksource.h>
-- 
1.8.3.1


