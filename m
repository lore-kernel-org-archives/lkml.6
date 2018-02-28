Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeB1JOv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:14:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:17496 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbeB1JOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:14:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="21384407"
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and
 cpu_frequency
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <1518576038-16198-1-git-send-email-changbin.du@intel.com>
 <20180214095440.2debdbba@gandalf.local.home>
 <20180227093526.z7gxg2nk7xmfk2oi@intel.com>
 <20180227173938.0826ed9b@vmware.local.home>
 <20180228024502.6kgudpsvx7hvlvcn@intel.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <fe962a88-af96-ed34-48c2-49f5e45375a7@intel.com>
Date: Wed, 28 Feb 2018 10:14:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228024502.6kgudpsvx7hvlvcn@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 3:45 AM, Du, Changbin wrote:
> On Tue, Feb 27, 2018 at 05:39:38PM -0500, Steven Rostedt wrote:
>> On Tue, 27 Feb 2018 17:35:27 +0800
>> "Du, Changbin" <changbin.du@intel.com> wrote:
>>
>>>>  From the tracing perspective:
>>>>
>>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>>
>>>> -- Steve
>>>>   
>>> Hi Steve, will you pick this or someoneelse?
>> I maintain the tracing infrastructure, but the tracing use cases are
>> maintained by the maintainers of the users of the trace events. That
>> is, who added these trace events? They are the ones most affected by
>> these changes.
>>
>> For example, it looks like Rafael J. Wysocki, is the one that added
>> trace_cpu_frequency(). He's the one that is affected by this change,
>> and is the one that you need to have take it.
>>
> Got it, thanks!
>
> Hi Wysocki, could you take a look?

Please send the patch(es) to linux-pm@vger.kernel.org with a CC to me 
and I will take care of them.

Thanks,
Rafael
