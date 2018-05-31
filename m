Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeEaKZG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:25:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:26155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754346AbeEaKZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:25:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="52232981"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf intel-pt: Fixes
Date: Thu, 31 May 2018 13:23:41 +0300
Message-Id: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some small non-urgent fixes for Intel PT.


Adrian Hunter (4):
      perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
      perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
      perf intel-pt: Fix MTC timing after overflow
      perf intel-pt: Fix "Unexpected indirect branch" error

 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 23 ++++++++++++++++++----
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  9 +++++++++
 tools/perf/util/intel-pt.c                         |  5 +++++
 3 files changed, 33 insertions(+), 4 deletions(-)


Regards
Adrian
