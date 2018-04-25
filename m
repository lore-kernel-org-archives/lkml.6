Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeDYM1j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:27:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:17360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbeDYM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:27:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="45937637"
Subject: Re: [PATCH 4/5] perf parse-events: Specially handle uncore event
 alias in small groups
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
 <1524594014-79243-4-git-send-email-kan.liang@linux.intel.com>
 <20180424191721.GB4427@kernel.org>
 <9a2070b4-9a27-4e38-f235-2d44ae39dd1f@linux.intel.com>
 <20180424192928.GE4427@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7c69ed57-94dd-45e1-bdd8-ac0c37bc575a@linux.intel.com>
Date: Wed, 25 Apr 2018 08:27:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424192928.GE4427@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2018 3:29 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 24, 2018 at 03:23:06PM -0400, Liang, Kan escreveu:
>> On 4/24/2018 3:17 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Apr 24, 2018 at 11:20:13AM -0700, kan.liang@linux.intel.com escreveu:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Perf stat doesn't count the uncore event aliases from the same uncore
>>>> block in a group, for example:
>>>
>>> This one is not applying to acme/perf/urgent, all the rest I got merged
>>> there, the last one with that change from using strstr() to a new bool
>>> in perf_evsel for the uniquifying operation having being performed.
>>
>> Sure. Thank you for letting me know.
> 
> Just pushed what I have there,
> 

Thanks Arnaldo.

How about this one?
Will it be applied to acme/perf/core? Or should I resend it for wider 
review?

Thanks,
Kan
