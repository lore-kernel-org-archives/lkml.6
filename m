Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EFEC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CB520870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfAULRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:17:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAULRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:17:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBG2jR2492470
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:16:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBG0iK2492466;
        Mon, 21 Jan 2019 03:16:00 -0800
Date:   Mon, 21 Jan 2019 03:16:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-23e232bd986a3024d589cbdbd64e078574d70794@git.kernel.org>
Cc:     acme@kernel.org, linux@armlinux.org.uk, ink@jurassic.park.msu.ru,
        tglx@linutronix.de, benh@kernel.crashing.org,
        s.hauer@pengutronix.de, rth@twiddle.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, paulus@samba.org,
        shawnguo@kernel.org, mattst88@gmail.com, andrew.murray@arm.com,
        hpa@zytor.com, bp@alien8.de, mpe@ellerman.id.au,
        peterz@infradead.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, mark.rutland@arm.com
Reply-To: linux@armlinux.org.uk, acme@kernel.org, ink@jurassic.park.msu.ru,
          tglx@linutronix.de, benh@kernel.crashing.org,
          s.hauer@pengutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rth@twiddle.net, paulus@samba.org,
          shawnguo@kernel.org, mattst88@gmail.com, andrew.murray@arm.com,
          hpa@zytor.com, mpe@ellerman.id.au, bp@alien8.de,
          peterz@infradead.org, will.deacon@arm.com,
          torvalds@linux-foundation.org, mark.rutland@arm.com
In-Reply-To: <1547128414-50693-2-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-2-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/doc: Update design.txt for
 exclude_{host|guest} flags
Git-Commit-ID: 23e232bd986a3024d589cbdbd64e078574d70794
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

Commit-ID:  23e232bd986a3024d589cbdbd64e078574d70794
Gitweb:     https://git.kernel.org/tip/23e232bd986a3024d589cbdbd64e078574d70794
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:23 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:18 +0100

perf/doc: Update design.txt for exclude_{host|guest} flags

Update design.txt to reflect the presence of the exclude_host
and exclude_guest perf flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-2-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/perf/design.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index a28dca2582aa..0453ba26cdbd 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
 way to request that counting of events be restricted to times when the
 CPU is in user, kernel and/or hypervisor mode.
 
+Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
+to request counting of events restricted to guest and host contexts when
+using Linux as the hypervisor.
+
 The 'mmap' and 'munmap' bits allow recording of PROT_EXEC mmap/munmap
 operations, these can be used to relate userspace IP addresses to actual
 code, even after the mapping (or even the whole process) is gone,
