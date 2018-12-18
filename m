Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26768C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017C3217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeLROKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:10:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40285 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeLROKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:10:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE9uAZ2853931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:09:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE9u9l2853928;
        Tue, 18 Dec 2018 06:09:56 -0800
Date:   Tue, 18 Dec 2018 06:09:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-65c9fee2da2fbbedbba402996ddb412072e762fc@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, acme@redhat.com,
        namhyung@kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          namhyung@kernel.org, jpoimboe@redhat.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181203102200.GA104797@gmail.com>
References: <20181203102200.GA104797@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib subcmd: Fix a few source code comment
 typos
Git-Commit-ID: 65c9fee2da2fbbedbba402996ddb412072e762fc
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

Commit-ID:  65c9fee2da2fbbedbba402996ddb412072e762fc
Gitweb:     https://git.kernel.org/tip/65c9fee2da2fbbedbba402996ddb412072e762fc
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 3 Dec 2018 11:22:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:56:51 -0300

tools lib subcmd: Fix a few source code comment typos

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease
cherry-picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 6ca2a8bfe716..af9def589863 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -71,7 +71,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `argh`::
  *   token to explain the kind of argument this option wants. Keep it
- *   homogenous across the repository.
+ *   homogeneous across the repository.
  *
  * `help`::
  *   the short help associated to what the option does.
@@ -80,7 +80,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `flags`::
  *   mask of parse_opt_option_flags.
- *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
+ *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
