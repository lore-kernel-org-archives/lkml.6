Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeDXTjQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:39:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:10902 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeDXTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:39:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="36726919"
Date: Tue, 24 Apr 2018 12:39:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Hunt <johunt@akamai.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] perf tools: allow map files to specify DSO
Message-ID: <20180424193912.GE14273@tassilo.jf.intel.com>
References: <1524595749-26688-1-git-send-email-johunt@akamai.com>
 <20180424192731.GC4427@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424192731.GC4427@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Pekka, Andi, Stephane, do you guys see any problems with this?

Looks ok to me.

-Andi

> 
> If this flies, tools/perf/Documentation/jit-interface.txt needs
> updating.
