Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97FEC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE162082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE162082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeKEA3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:29:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:64593 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbeKEA3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:29:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 07:14:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,464,1534834800"; 
   d="scan'208";a="105303511"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2018 07:14:24 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] perf scripts python: exported-sql-viewer.py
Date:   Sun,  4 Nov 2018 17:12:34 +0200
Message-Id: <20181104151238.15947-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is the libxed fix, the last 2 patches from last submission and another
fix.

Changes in V2:

      perf scripts python: call-graph-from-sql.py: Use SPDX license identifier
      perf scripts python: call-graph-from-sql.py: Provide better default column sizes
      perf scripts python: call-graph-from-sql.py: Set a minimum window size
      perf scripts python: call-graph-from-sql.py: Change icon
      perf scripts python: call-graph-from-sql.py: Make a "Main" function
      perf scripts python: call-graph-from-sql.py: Separate the database details into a class
      perf scripts python: call-graph-from-sql.py: Add a class for global data
      perf scripts python: call-graph-from-sql.py: Remove use of setObjectName()
      perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel
      perf scripts python: call-graph-from-sql.py: Add data helper functions
      perf scripts python: call-graph-from-sql.py: Refactor TreeItem class
      perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py
      perf scripts python: exported-sql-viewer.py: Add support for multiple sub-windows
      perf scripts python: exported-sql-viewer.py: Add ability to find symbols in the call-graph
      perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font
      perf scripts python: exported-sql-viewer.py: Add ability to display all the database tables
      perf scripts python: exported-sql-viewer.py: Add All branches report
		Dropped because they have been applied

      perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
		New patch

      perf scripts python: exported-sql-viewer.py: Add Selected branches report
		Improve time range entry

      perf scripts python: exported-sql-viewer.py: Add help window
		Updated for time range change above

      perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
		New patch

Adrian Hunter (4):
      perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
      perf scripts python: exported-sql-viewer.py: Add Selected branches report
      perf scripts python: exported-sql-viewer.py: Add help window
      perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered

 tools/perf/scripts/python/exported-sql-viewer.py | 493 ++++++++++++++++++++++-
 1 file changed, 490 insertions(+), 3 deletions(-)


Regards
Adrian
