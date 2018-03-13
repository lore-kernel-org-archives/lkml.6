Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeCMBti (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:49:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:20200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbeCMBth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:49:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="34456901"
From: "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/x86/uncore: Add missing filter constraint for SKX
 CHA event
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
References: <1520869294-14176-1-git-send-email-kan.liang@linux.intel.com>
 <20180312163914.GG4043@hirez.programming.kicks-ass.net>
Message-ID: <d4d03256-4286-2b09-de52-20738155e139@linux.intel.com>
Date: Mon, 12 Mar 2018 21:49:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312163914.GG4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/2018 12:39 PM, Peter Zijlstra wrote:
> On Mon, Mar 12, 2018 at 08:41:34AM -0700, Kan Liang wrote:
>> From: Stephane Eranian <eranian@google.com>
>>
>> Adding a filter constraint for Intel Skylake CHA event
>> UNC_CHA_UPI_CREDITS_ACQUIRED (0x38).
>> The event supports core-id/thread-id and link filtering.
> 
> Could you also comment on the other CHA patch?
> 
>   https://lkml.kernel.org/r/CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM
>


Now, there is a recommended way in uncore document to query the number 
of CHAs by reading bits 27:0 in the CAPID6 register located at Device 
30, Function 3, Offset 0x9C.
I have implemented a patch and sent it to Gary. It should fix his issue.

Thanks,
Kan
