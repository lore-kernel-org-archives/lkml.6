Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeBET5h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbeBET5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:57:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D230217B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/10] perf tools: Add trace/beauty/generated/ into .gitignore
Date: Mon,  5 Feb 2018 16:56:20 -0300
Message-Id: <20180205195620.9010-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

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
index 643cc4ba6872..3e5135dded16 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -31,5 +31,6 @@ config.mak.autogen
 .config-detected
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
+trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
-- 
2.14.3
