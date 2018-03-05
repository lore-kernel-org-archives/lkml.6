Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeCEQwx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:52:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:33122 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeCEQwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:52:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="22130331"
Date: Mon, 5 Mar 2018 08:52:34 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
Subject: Re: [PATCH v1 0/3] perf: expose thread context switch out event type
 to user space
Message-ID: <20180305165234.GC25017@tassilo.jf.intel.com>
References: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Patches look good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
