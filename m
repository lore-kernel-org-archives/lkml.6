Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeFABzF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:55:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:13358 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeFABzC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:55:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="46400786"
Date: Thu, 31 May 2018 18:55:01 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/3] perf script python: Add more PMU fields
Message-ID: <20180601015501.GI30764@tassilo.jf.intel.com>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:01:00PM +0800, Jin Yao wrote:
> When doing pmu sampling and then running a script with
> perf script -s script.py, the process_event function gets
> dictionary with some fields from the perf ring buffer
> (like ip, sym, callchain etc).
> 
> But we miss quite a few fields we report now, for example,
> LBRs,data source,weight,transaction,iregs,uregs,and etc.
> 
> This patch adds these fields for perf script python.

Patches look good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
