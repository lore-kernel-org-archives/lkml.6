Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeCGSyc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:54:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:14581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753901AbeCGSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:54:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="23745669"
Date: Wed, 7 Mar 2018 10:54:15 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        timur@codeaurora.org
Subject: Re: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180307185415.GK25017@tassilo.jf.intel.com>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
 <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry about that. That's probably because FNM_EXTMATCH is a GNU extension,
> not POSIX, and the Alpine and Android runtimes likely don't implement
> that...
> I'll send a fix reverting back to the strncmp to ignore the uncore_ prefix,
> and dropping that extension.

Just don't set it? Even the basic glob patterns are useful.

-Andi
