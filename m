Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC3FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367982086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367982086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeKSQEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:04:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:5455 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeKSQEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:04:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 21:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,251,1539673200"; 
   d="scan'208";a="86982871"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2018 21:41:36 -0800
Received: from [10.252.19.222] (abudanko-mobl.ccr.corp.intel.com [10.252.19.222])
        by linux.intel.com (Postfix) with ESMTP id 7615A580378;
        Sun, 18 Nov 2018 21:41:32 -0800 (PST)
Subject: [PATCH v1 1/2]: Documentation/admin-guide: update admin-guide
 index.rst
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-doc@vger.kernel.org
References: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <810bb4aa-777f-77ed-19f0-882354bdf9c7@linux.intel.com>
Date:   Mon, 19 Nov 2018 08:41:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend index.rst index file at admin-guide root directory with 
the reference to perf-security.rst file being introduced.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 Documentation/admin-guide/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0873685bab0f..885cc0de9114 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -75,6 +75,7 @@ configure specific aspects of kernel behavior to your liking.
    thunderbolt
    LSM/index
    mm/index
+   perf-security
 
 .. only::  subproject and html
