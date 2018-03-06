Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeCFJOK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:14:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:28963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeCFJOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:14:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25575366"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] perf tools: Prepare for AUX area sampling support
Date: Tue,  6 Mar 2018 11:13:11 +0200
Message-Id: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are a few patches to help clear the way for adding AUX area sampling
support.  There is one minor fix "Prevent decoding when --no-itrace" but
otherwise there are no functional changes.


Adrian Hunter (7):
      perf record: Combine some auxtrace initialization into a single function
      perf auxtrace: Prevent decoding when --no-itrace
      perf auxtrace: Add missing parameters from kernel-doc comments
      perf auxtrace: Rename some buffer-queuing functions
      perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
      perf auxtrace: Make auxtrace_queues__add_buffer() allocate struct buffer
      perf auxtrace: Make auxtrace_queues__add_buffer() do CPU filtering

 tools/perf/builtin-record.c |  36 +++++++++-----
 tools/perf/util/auxtrace.c  | 114 +++++++++++++++++++++++---------------------
 tools/perf/util/auxtrace.h  |   2 +
 3 files changed, 85 insertions(+), 67 deletions(-)


Regards
Adrian
