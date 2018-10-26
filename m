Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9210BECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B4E20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B4E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJZQMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:12:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:12:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7aBOT137632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:36:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7aBa4137629;
        Fri, 26 Oct 2018 00:36:11 -0700
Date:   Fri, 26 Oct 2018 00:36:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-3e71c70c946b5d5e7b21397c621b14951e5c0fcf@git.kernel.org>
Cc:     tglx@linutronix.de, ak@linux.intel.com, jolsa@redhat.com,
        adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, adrian.hunter@intel.com, jolsa@redhat.com,
          ak@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20181001062853.28285-2-adrian.hunter@intel.com>
References: <20181001062853.28285-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py: Use
 SPDX license identifier
Git-Commit-ID: 3e71c70c946b5d5e7b21397c621b14951e5c0fcf
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

Commit-ID:  3e71c70c946b5d5e7b21397c621b14951e5c0fcf
Gitweb:     https://git.kernel.org/tip/3e71c70c946b5d5e7b21397c621b14951e5c0fcf
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:35 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 14:28:04 -0300

perf scripts python: call-graph-from-sql.py: Use SPDX license identifier

Use SPDX license identifier in call-graph-from-sql.py.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index b494a67a1c67..ce1b91fcd6b8 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -1,15 +1,7 @@
 #!/usr/bin/python2
-# call-graph-from-sql.py: create call-graph from sql database
-# Copyright (c) 2014-2017, Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms and conditions of the GNU General Public License,
-# version 2, as published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-# more details.
+# SPDX-License-Identifier: GPL-2.0
+# exported-sql-viewer.py: view data from sql database
+# Copyright (c) 2014-2018, Intel Corporation.
 
 # To use this script you will need to have exported data using either the
 # export-to-sqlite.py or the export-to-postgresql.py script.  Refer to those
