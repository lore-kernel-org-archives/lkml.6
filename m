Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeDTMfY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:35:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754752AbeDTMfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:35:23 -0400
Subject: Re: s390 perf events JSONs query
To: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        <brueckner@linux.vnet.ibm.com>, <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
References: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
 <a3d9a3c0-8251-c922-64d4-6b91fe5df324@linux.ibm.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <88a0164e-0dbb-14a5-4746-351ea7eeeb68@huawei.com>
Date: Fri, 20 Apr 2018 13:34:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <a3d9a3c0-8251-c922-64d4-6b91fe5df324@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 12:44, Thomas-Mich Richter wrote:
> On 04/20/2018 12:51 PM, John Garry wrote:
>> Hi Hendrik, Thomas,
>>
>> I noticed that in 4.17-rc1 support was included for s390 perf pmu-events. I also notice that the JSONs contain many common (identical actually) events between different chips for this arch.
>>
>> Support was added for factoring out common arch events in https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/perf/pmu-events?h=next-20180420&id=e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
>>
>> ARM64 chips use this feature. I am not familiar with the s390 arch, but do you think you could also use this feature?
>>
>> Thanks,
>> John
>>
>
> Thanks John,
>
> for bringing this to my attention. Yes I will definitely look into this feature and will try to
> rework our s390 json files when this seems beneficial.
>
> I did not notice this patch on the linux-perf-users mailing list. Was it there for review?
> I do ask this because recently I have nearly no traffic on this list in my reader, so I wonder
> if there is something wrong with my mailing list subscription or setup.
>

Hi Thomas,

The only relevant list was linux-kernel@vger.kernel.org

This is the only list which the MAINTAINERS file advises to add. I did 
wonder about a dedicated perf list, as I seem to miss mails also.

Hi Peter, Ingo, Arnaldo,

Should linux-perf-users address be added for perf-related patches? If 
so, should we add it to the maintainers file? If not, why no dedicated list?

Thanks,
John

> Thanks.
>
