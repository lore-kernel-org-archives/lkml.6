Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeFDM6P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:58:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:38826 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbeFDM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:58:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="46607121"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
Date: Mon,  4 Jun 2018 15:56:52 +0300
Message-Id: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are a couple of small fixes for tracing 32-bit binaries on a 64-bit
kernel.


Adrian Hunter (2):
      perf tests kmod-path: Add tests for vdso32 and vdsox32
      perf tools: Fix symbol and object code resolution for vdso32 and vdsox32

 tools/perf/tests/kmod-path.c | 16 ++++++++++++++++
 tools/perf/util/dso.c        |  2 ++
 2 files changed, 18 insertions(+)


Regards
Adrian
