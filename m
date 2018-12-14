Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EF4208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbeLNUmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:42:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbeLNUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:42:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKgVaO1456576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:42:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKgVC11456573;
        Fri, 14 Dec 2018 12:42:31 -0800
Date:   Fri, 14 Dec 2018 12:42:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-f04ae48fe61a13e3ea63c2761837f646bd1f6980@git.kernel.org>
Cc:     jolsa@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          jolsa@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <20181203102200.GA104797@gmail.com>
References: <20181203102200.GA104797@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix diverse comment typos
Git-Commit-ID: f04ae48fe61a13e3ea63c2761837f646bd1f6980
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

Commit-ID:  f04ae48fe61a13e3ea63c2761837f646bd1f6980
Gitweb:     https://git.kernel.org/tip/f04ae48fe61a13e3ea63c2761837f646bd1f6980
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 3 Dec 2018 11:22:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:31 -0300

perf tools: Fix diverse comment typos

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease
cherry-picking and/or backporting, split this into multiple patches.

Just typos in comments, no need to backport, reducing the possibility of
possible backporting artifacts.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/insn-x86.c | 2 +-
 tools/perf/builtin-top.c             | 2 +-
 tools/perf/builtin-trace.c           | 2 +-
 tools/perf/tests/attr.c              | 2 +-
 tools/perf/util/annotate.c           | 2 +-
 tools/perf/util/header.c             | 2 +-
 tools/perf/util/hist.c               | 2 +-
 tools/perf/util/jitdump.c            | 2 +-
 tools/perf/util/machine.c            | 2 +-
 tools/perf/util/probe-event.c        | 4 ++--
 tools/perf/util/sort.c               | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index a5d24ae5810d..c3e5f4ab0d3e 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -170,7 +170,7 @@ static int test_data_set(struct test_data *dat_set, int x86_64)
  *
  * If the test passes %0 is returned, otherwise %-1 is returned.  Use the
  * verbose (-v) option to see all the instructions and whether or not they
- * decoded successfuly.
+ * decoded successfully.
  */
 int test__insn_x86(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1252d1759064..c59a3eb0d697 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -595,7 +595,7 @@ static void *display_thread_tui(void *arg)
 
 	/*
 	 * Initialize the uid_filter_str, in the future the TUI will allow
-	 * Zooming in/out UIDs. For now juse use whatever the user passed
+	 * Zooming in/out UIDs. For now just use whatever the user passed
 	 * via --uid.
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a57a9ae1fd4b..a6aa4589ad50 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2782,7 +2782,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 * Now that we already used evsel->attr to ask the kernel to setup the
 	 * events, lets reuse evsel->attr.sample_max_stack as the limit in
 	 * trace__resolve_callchain(), allowing per-event max-stack settings
-	 * to override an explicitely set --max-stack global setting.
+	 * to override an explicitly set --max-stack global setting.
 	 */
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__has_callchain(evsel) &&
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 05dfe11c2f9e..d8426547219b 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -182,7 +182,7 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 	char path_perf[PATH_MAX];
 	char path_dir[PATH_MAX];
 
-	/* First try developement tree tests. */
+	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
 		return run_dir("./tests", "./perf");
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f69d8e177fa3..51d291b0b81f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1772,7 +1772,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	while (!feof(file)) {
 		/*
 		 * The source code line number (lineno) needs to be kept in
-		 * accross calls to symbol__parse_objdump_line(), so that it
+		 * across calls to symbol__parse_objdump_line(), so that it
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9cc81d48a908..4a64739c67e7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2798,7 +2798,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	lseek(fd, sec_start, SEEK_SET);
 	/*
 	 * may write more than needed due to dropped feature, but
-	 * this is okay, reader will skip the mising entries
+	 * this is okay, reader will skip the missing entries
 	 */
 	err = do_write(&ff, feat_sec, sec_size);
 	if (err < 0)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 828cb9794c76..8aad8330e392 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1160,7 +1160,7 @@ void hist_entry__delete(struct hist_entry *he)
 
 /*
  * If this is not the last column, then we need to pad it according to the
- * pre-calculated max lenght for this column, otherwise don't bother adding
+ * pre-calculated max length for this column, otherwise don't bother adding
  * spaces because that would break viewing this with, for instance, 'less',
  * that would show tons of trailing spaces when a long C++ demangled method
  * names is sampled.
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index a1863000e972..bf249552a9b0 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -38,7 +38,7 @@ struct jit_buf_desc {
 	uint64_t	 sample_type;
 	size_t           bufsize;
 	FILE             *in;
-	bool		 needs_bswap; /* handles cross-endianess */
+	bool		 needs_bswap; /* handles cross-endianness */
 	bool		 use_arch_timestamp;
 	void		 *debug_data;
 	void		 *unwinding_data;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9397e3f2444d..d1309201c1d2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -137,7 +137,7 @@ struct machine *machine__new_kallsyms(void)
 	struct machine *machine = machine__new_host();
 	/*
 	 * FIXME:
-	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitely
+	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
 	 *    ask for not using the kcore parsing code, once this one is fixed
 	 *    to create a map per module.
 	 */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e86f8be89157..18a59fba97ff 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -692,7 +692,7 @@ static int add_exec_to_probe_trace_events(struct probe_trace_event *tevs,
 		return ret;
 
 	for (i = 0; i < ntevs && ret >= 0; i++) {
-		/* point.address is the addres of point.symbol + point.offset */
+		/* point.address is the address of point.symbol + point.offset */
 		tevs[i].point.address -= stext;
 		tevs[i].point.module = strdup(exec);
 		if (!tevs[i].point.module) {
@@ -3062,7 +3062,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
 	/*
 	 * Give it a '0x' leading symbol name.
 	 * In __add_probe_trace_events, a NULL symbol is interpreted as
-	 * invalud.
+	 * invalid.
 	 */
 	if (asprintf(&tp->symbol, "0x%lx", tp->address) < 0)
 		goto errout;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 047793528919..6c1a83768eb0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -37,7 +37,7 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
  * -t, --field-separator
  *
  * option, that uses a special separator character and don't pad with spaces,
- * replacing all occurances of this separator in symbol names (and other
+ * replacing all occurrences of this separator in symbol names (and other
  * output) with a '.' character, that thus it's the only non valid separator.
 */
 static int repsep_snprintf(char *bf, size_t size, const char *fmt, ...)
