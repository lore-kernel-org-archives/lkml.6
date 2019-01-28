Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A596AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC582147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfA1RkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:40:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfA1RkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:40:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0SHduSQ1573047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 28 Jan 2019 09:39:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0SHdtPV1573040;
        Mon, 28 Jan 2019 09:39:55 -0800
Date:   Mon, 28 Jan 2019 09:39:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Brajeswar Ghosh <tipbot@zytor.com>
Message-ID: <tip-fc5014cc552811ade1edce59d0c3f1baa069ffa0@git.kernel.org>
Cc:     dwmw@amazon.co.uk, brajeswar.linux@gmail.com, bp@suse.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com
Reply-To: tglx@linutronix.de, mingo@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          dwmw@amazon.co.uk, brajeswar.linux@gmail.com, bp@suse.de
In-Reply-To: <20190128161847.GA2318@hp-pavilion-15-notebook-pc-brajeswar>
References: <20190128161847.GA2318@hp-pavilion-15-notebook-pc-brajeswar>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/asm-prototypes: Remove duplicate include
 <asm/page.h>
Git-Commit-ID: fc5014cc552811ade1edce59d0c3f1baa069ffa0
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

Commit-ID:  fc5014cc552811ade1edce59d0c3f1baa069ffa0
Gitweb:     https://git.kernel.org/tip/fc5014cc552811ade1edce59d0c3f1baa069ffa0
Author:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
AuthorDate: Mon, 28 Jan 2019 21:48:47 +0530
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 28 Jan 2019 18:32:34 +0100

x86/asm-prototypes: Remove duplicate include <asm/page.h>

Remove asm/page.h which is included more than once.

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: jrdr.linux@gmail.com
Cc: sabyasachi.linux@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190128161847.GA2318@hp-pavilion-15-notebook-pc-brajeswar
---
 arch/x86/include/asm/asm-prototypes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 1908214b9125..ce92c4acc913 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -7,7 +7,6 @@
 
 #include <asm-generic/asm-prototypes.h>
 
-#include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
