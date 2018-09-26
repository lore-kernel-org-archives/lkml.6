Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0E6204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0E6204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeIZPDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:03:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:03:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8p8Ip3772351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:51:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8p8ek3772348;
        Wed, 26 Sep 2018 01:51:08 -0700
Date:   Wed, 26 Sep 2018 01:51:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-88e6c21a11c5464ebdaefeb18822ab55f37a6473@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, tz.stoyanov@gmail.com,
        rostedt@goodmis.org, akpm@linux-foundation.org, hpa@zytor.com,
        mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
          tz.stoyanov@gmail.com, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          namhyung@kernel.org, jolsa@redhat.com, tglx@linutronix.de
In-Reply-To: <20180919185724.152948543@goodmis.org>
References: <20180919185724.152948543@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add prefix tep_ to various
 structs filter_arg_*.
Git-Commit-ID: 88e6c21a11c5464ebdaefeb18822ab55f37a6473
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

Commit-ID:  88e6c21a11c5464ebdaefeb18822ab55f37a6473
Gitweb:     https://git.kernel.org/tip/88e6c21a11c5464ebdaefeb18822ab55f37a6473
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 19 Sep 2018 14:56:54 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 17:27:52 -0300

tools lib traceevent: Add prefix tep_ to various structs filter_arg_*.

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_". This adds prefix tep_ to
to various structs filter_arg_*..

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180919185724.152948543@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h | 48 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 64ce3eb0dcbc..1330fca2da1e 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -827,15 +827,15 @@ enum tep_filter_value_type {
 
 struct tep_filter_arg;
 
-struct filter_arg_boolean {
+struct tep_filter_arg_boolean {
 	enum tep_filter_boolean_type	value;
 };
 
-struct filter_arg_field {
-	struct tep_format_field	*field;
+struct tep_filter_arg_field {
+	struct tep_format_field		*field;
 };
 
-struct filter_arg_value {
+struct tep_filter_arg_value {
 	enum tep_filter_value_type	type;
 	union {
 		char			*str;
@@ -843,42 +843,42 @@ struct filter_arg_value {
 	};
 };
 
-struct filter_arg_op {
-	enum tep_filter_op_type	type;
-	struct tep_filter_arg	*left;
-	struct tep_filter_arg	*right;
+struct tep_filter_arg_op {
+	enum tep_filter_op_type		type;
+	struct tep_filter_arg		*left;
+	struct tep_filter_arg		*right;
 };
 
-struct filter_arg_exp {
+struct tep_filter_arg_exp {
 	enum tep_filter_exp_type	type;
 	struct tep_filter_arg		*left;
 	struct tep_filter_arg		*right;
 };
 
-struct filter_arg_num {
+struct tep_filter_arg_num {
 	enum tep_filter_cmp_type	type;
-	struct tep_filter_arg	*left;
-	struct tep_filter_arg	*right;
+	struct tep_filter_arg		*left;
+	struct tep_filter_arg		*right;
 };
 
-struct filter_arg_str {
+struct tep_filter_arg_str {
 	enum tep_filter_cmp_type	type;
-	struct tep_format_field	*field;
-	char			*val;
-	char			*buffer;
-	regex_t			reg;
+	struct tep_format_field		*field;
+	char				*val;
+	char				*buffer;
+	regex_t				reg;
 };
 
 struct tep_filter_arg {
 	enum tep_filter_arg_type		type;
 	union {
-		struct filter_arg_boolean	boolean;
-		struct filter_arg_field		field;
-		struct filter_arg_value		value;
-		struct filter_arg_op		op;
-		struct filter_arg_exp		exp;
-		struct filter_arg_num		num;
-		struct filter_arg_str		str;
+		struct tep_filter_arg_boolean	boolean;
+		struct tep_filter_arg_field	field;
+		struct tep_filter_arg_value	value;
+		struct tep_filter_arg_op	op;
+		struct tep_filter_arg_exp	exp;
+		struct tep_filter_arg_num	num;
+		struct tep_filter_arg_str	str;
 	};
 };
 
