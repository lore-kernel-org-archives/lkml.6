Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBWJJA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:09:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:45825 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbeBWJI7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:08:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="206365266"
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
 <20180223082500.GT25181@hirez.programming.kicks-ass.net>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <164d5cb8-58fc-d77d-ff30-e25049f9299b@linux.intel.com>
Date: Fri, 23 Feb 2018 17:08:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223082500.GT25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2018 4:25 PM, Peter Zijlstra wrote:
> On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
>> Unlike the perf report interactive annotate mode, the perf annotate
>> doesn't display the LBR data.
>>
>> perf record -b ...
>> perf annotate function
>>
>> It should show IPC/cycle, but it doesn't.
> 
> There is far more than IPC/cycle for the LBR data, so this Changelog is
> misleading.
> 

I will change the changelog to make it more clear.

> Also, I think that this patch goes the wrong way, we should reduce the
> divergence of the various modes, not make it worse.
> 
I do plan to support stdio mode. While stdio mode needs more changes 
than tui mode, so I plan to do it in a follow-up patch.

Posting this patch now is because I want to listen from community first 
for this feature. If the tui patch could be accepted, then it's worth 
putting more efforts on stdio version. That's my thoughts.

Thanks
Jin Yao
