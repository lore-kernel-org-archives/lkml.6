Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeCIIkg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:40:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCIIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:40:35 -0500
Date: Fri, 9 Mar 2018 00:40:28 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b818ec613b42d679604215c188a12cf43164cab0@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        tglx@linutronix.de
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com
In-Reply-To: <1520327598-1317-4-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-4-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Add missing parameters from
 kernel-doc comments
Git-Commit-ID: b818ec613b42d679604215c188a12cf43164cab0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b818ec613b42d679604215c188a12cf43164cab0
Gitweb:     https://git.kernel.org/tip/b818ec613b42d679604215c188a12cf43164cab0
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:14 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf auxtrace: Add missing parameters from kernel-doc comments

Add missing parameters from kernel-doc comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 453c148d2158..e731f55da072 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -130,6 +130,7 @@ struct auxtrace_index {
 /**
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
+ * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
@@ -301,6 +302,7 @@ struct auxtrace_mmap_params {
  * @parse_snapshot_options: parse snapshot options
  * @reference: provide a 64-bit reference number for auxtrace_event
  * @read_finish: called after reading from an auxtrace mmap
+ * @alignment: alignment (if any) for AUX area data
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
