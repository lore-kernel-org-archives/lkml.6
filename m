Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBEVjA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:39:00 -0500
Received: from terminus.zytor.com ([65.50.211.136]:41959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeBEViv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:38:51 -0500
Date: Mon, 5 Feb 2018 13:37:43 -0800
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-2fe2230d4183d2c311bbb7b426491ac486216a16@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ravi.bangoria@linux.vnet.ibm.com,
        jolsa@redhat.com
Reply-To: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        ravi.bangoria@linux.vnet.ibm.com
In-Reply-To: <20180130053053.13214-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180130053053.13214-2-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add trace/beauty/generated/ into
 .gitignore
Git-Commit-ID: 2fe2230d4183d2c311bbb7b426491ac486216a16
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

Commit-ID:  2fe2230d4183d2c311bbb7b426491ac486216a16
Gitweb:     https://git.kernel.org/tip/2fe2230d4183d2c311bbb7b426491ac486216a16
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Tue, 30 Jan 2018 11:00:52 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Feb 2018 13:58:02 -0300

perf tools: Add trace/beauty/generated/ into .gitignore

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180130053053.13214-2-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 643cc4ba..3e5135d 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -31,5 +31,6 @@ config.mak.autogen
 .config-detected
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
+trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
