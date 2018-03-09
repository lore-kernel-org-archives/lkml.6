Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCISyD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:54:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:41700 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeCISyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:54:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="24336891"
Subject: Re: [tip:perf/core] perf/x86/intel: Disable userspace RDPMC usage for
 large PEBS
To: Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, eranian@google.com, acme@redhat.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, linux-tip-commits@vger.kernel.org
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
 <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org>
 <alpine.DEB.2.21.1803090929380.4834@macbook-air>
 <20180309174218.GB4064@hirez.programming.kicks-ass.net>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c3880b40-3f45-9820-a7af-6b87b23899ae@linux.intel.com>
Date: Fri, 9 Mar 2018 13:53:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309174218.GB4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2018 12:42 PM, Peter Zijlstra wrote:
> On Fri, Mar 09, 2018 at 09:31:11AM -0500, Vince Weaver wrote:
>> On Fri, 9 Mar 2018, tip-bot for Kan Liang wrote:
>>
>>> Commit-ID:  1af22eba248efe2de25658041a80a3d40fb3e92e
>>> Gitweb:     https://git.kernel.org/tip/1af22eba248efe2de25658041a80a3d40fb3e92e
>>> Author:     Kan Liang <kan.liang@linux.intel.com>
>>> AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
>>> Committer:  Ingo Molnar <mingo@kernel.org>
>>> CommitDate: Fri, 9 Mar 2018 08:22:23 +0100
>>>
>>> perf/x86/intel: Disable userspace RDPMC usage for large PEBS
>>>
>>
>>
>> So this whole commit log is about disabling RDPMC usage for "large PEBS"
>> but the actual change disables RDPMC if "PERF_X86_EVENT_FREERUNNING"
>>
>> Either the commit log is really misleading, or else a poor name was chosen
>> for this feature.
> 
> Its the same thing, and yes that might want renaming I suppose.
>

Yes, I will send a patch to rename the "FREERUNNING" to "LARGE_PEBS", 
and fix the confusion.

Thanks,
Kan
