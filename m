Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0156A20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0156A20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeGQJ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:57:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:57:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9OnSP1461831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:24:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Onhe1461828;
        Tue, 17 Jul 2018 02:24:49 -0700
Date:   Tue, 17 Jul 2018 02:24:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ananth N Mavinakayanahalli <tipbot@zytor.com>
Message-ID: <tip-1b51a2fe84d87ae3df11b169cfb38db16df0c9af@git.kernel.org>
Cc:     hpa@zytor.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, mhiramat@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        namhyung@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          davem@davemloft.net, anil.s.keshavamurthy@intel.com,
          hpa@zytor.com, naveen.n.rao@linux.vnet.ibm.com,
          ananth@linux.vnet.ibm.com, namhyung@kernel.org, jolsa@redhat.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, mhiramat@kernel.org
In-Reply-To: <153180735790.1914.15547706781664285286.stgit@thinktux>
References: <153180735790.1914.15547706781664285286.stgit@thinktux>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] MAINTAINERS: Add Naveen N. Rao as kprobes
 co-maintainer
Git-Commit-ID: 1b51a2fe84d87ae3df11b169cfb38db16df0c9af
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

Commit-ID:  1b51a2fe84d87ae3df11b169cfb38db16df0c9af
Gitweb:     https://git.kernel.org/tip/1b51a2fe84d87ae3df11b169cfb38db16df0c9af
Author:     Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
AuthorDate: Tue, 17 Jul 2018 11:32:37 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:23:23 +0200

MAINTAINERS: Add Naveen N. Rao as kprobes co-maintainer

Naveen has been contributing consistently reviewing and hardening
kprobes for some time now. I have not been able to do the same due
to other commitments.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: akpm@linux-foundation.org
Cc: mhiramat@kernel.org
Link: http://lkml.kernel.org/r/153180735790.1914.15547706781664285286.stgit@thinktux
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..7aec3c9709ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7985,7 +7985,7 @@ F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
 KPROBES
-M:	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
+M:	Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
