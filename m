Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A81208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A81208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKSUou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:44:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51621 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:44:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJALW7P2525171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:21:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJALWa22525168;
        Mon, 19 Nov 2018 02:21:32 -0800
Date:   Mon, 19 Nov 2018 02:21:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-2ffcbce39ea1e355eed8c6527308624f366f1c58@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, bp@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, bp@suse.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181107170218.7596-17-bp@alien8.de>
References: <20181107170218.7596-17-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Update copyright
Git-Commit-ID: 2ffcbce39ea1e355eed8c6527308624f366f1c58
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

Commit-ID:  2ffcbce39ea1e355eed8c6527308624f366f1c58
Gitweb:     https://git.kernel.org/tip/2ffcbce39ea1e355eed8c6527308624f366f1c58
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Oct 2018 15:04:52 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:55:12 +0100

x86/microcode/AMD: Update copyright

Adjust copyright.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-17-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 81df4b9eadb7..51adde0a0f1a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -5,7 +5,7 @@
  *  CPUs and later.
  *
  *  Copyright (C) 2008-2011 Advanced Micro Devices Inc.
- *	          2013-2016 Borislav Petkov <bp@alien8.de>
+ *	          2013-2018 Borislav Petkov <bp@alien8.de>
  *
  *  Author: Peter Oruba <peter.oruba@amd.com>
  *
