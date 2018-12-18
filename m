Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D88C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31E8217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLROIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:08:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeLROIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:08:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE7cOK2853570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:07:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE7b4O2853567;
        Tue, 18 Dec 2018 06:07:37 -0800
Date:   Tue, 18 Dec 2018 06:07:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-3e449f7c36c3ac49f140b5dc3c40693e551f47d2@git.kernel.org>
Cc:     peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        tstoyanov@vmware.com, mingo@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        namhyung@kernel.org
Reply-To: acme@redhat.com, namhyung@kernel.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          tstoyanov@vmware.com, mingo@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, rostedt@goodmis.org
In-Reply-To: <20181203102200.GA104797@gmail.com>
References: <20181203102200.GA104797@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Fix diverse typos in comments
Git-Commit-ID: 3e449f7c36c3ac49f140b5dc3c40693e551f47d2
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

Commit-ID:  3e449f7c36c3ac49f140b5dc3c40693e551f47d2
Gitweb:     https://git.kernel.org/tip/3e449f7c36c3ac49f140b5dc3c40693e551f47d2
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 3 Dec 2018 11:22:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:56:34 -0300

tools lib traceevent: Fix diverse typos in comments

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 12 ++++++------
 tools/lib/traceevent/plugin_kvm.c  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index ffa656b868a9..a5ed291b8a9f 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1145,7 +1145,7 @@ static enum tep_event_type read_token(char **tok)
 }
 
 /**
- * tep_read_token - access to utilites to use the pevent parser
+ * tep_read_token - access to utilities to use the pevent parser
  * @tok: The token to return
  *
  * This will parse tokens from the string given by
@@ -3258,7 +3258,7 @@ static int event_read_print(struct tep_event *event)
  * @name: the name of the common field to return
  *
  * Returns a common field from the event by the given @name.
- * This only searchs the common fields and not all field.
+ * This only searches the common fields and not all field.
  */
 struct tep_format_field *
 tep_find_common_field(struct tep_event *event, const char *name)
@@ -3302,7 +3302,7 @@ tep_find_field(struct tep_event *event, const char *name)
  * @name: the name of the field
  *
  * Returns a field by the given @name.
- * This searchs the common field names first, then
+ * This searches the common field names first, then
  * the non-common ones if a common one was not found.
  */
 struct tep_format_field *
@@ -3841,7 +3841,7 @@ static void print_bitmask_to_seq(struct tep_handle *pevent,
 		/*
 		 * data points to a bit mask of size bytes.
 		 * In the kernel, this is an array of long words, thus
-		 * endianess is very important.
+		 * endianness is very important.
 		 */
 		if (pevent->file_bigendian)
 			index = size - (len + 1);
@@ -5316,9 +5316,9 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
  * This returns the cmdline structure that holds a pid for a given
  * comm, or NULL if none found. As there may be more than one pid for
  * a given comm, the result of this call can be passed back into
- * a recurring call in the @next paramater, and then it will find the
+ * a recurring call in the @next parameter, and then it will find the
  * next pid.
- * Also, it does a linear seach, so it may be slow.
+ * Also, it does a linear search, so it may be slow.
  */
 struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
 				       struct cmdline *next)
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 637be7c18476..754050eea467 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -387,7 +387,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 
 	/*
 	 * We can only use the structure if file is of the same
-	 * endianess.
+	 * endianness.
 	 */
 	if (tep_is_file_bigendian(event->pevent) ==
 	    tep_is_host_bigendian(event->pevent)) {
