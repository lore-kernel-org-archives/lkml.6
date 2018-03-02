Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946766AbeCBQFV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:05:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426862AbeCBQFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:05:19 -0500
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
To: John Garry <john.garry@huawei.com>, ganapatrao.kulkarni@cavium.com
Cc: Jiri Olsa <jolsa@redhat.com>, ak@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will.deacon@arm.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
From: William Cohen <wcohen@redhat.com>
Message-ID: <cafdb160-3072-389b-8c31-93f09eff84a8@redhat.com>
Date: Fri, 2 Mar 2018 11:05:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 03:24 AM, John Garry wrote:
> On 27/02/2018 09:50, Jiri Olsa wrote:
>> On Sat, Feb 24, 2018 at 12:05:21AM +0800, John Garry wrote:
>>> This patchset adds support for some perf events features,
>>> targeted at ARM64, implemented in a generic fashion.
>>>
>>> The two main features are as follows:
>>> - support for arch/vendor/platform pmu events directory structure
>>>    - to support this, topic subdirectory support needs to be dropped
>>> - support for parsing standard architecture pmu events
>>>
>>> On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
>>> and HiSilicon hip08 JSONs are relocated/added/updated.
>>>
>>> In addition, there is a patch to drop mutli-mapfile.csv support and
>>> also a bugfix in jevents.c for an error code value.
>>>
>>> Differences to v1:
>>> - Address coding issues from Jiri Olsa in adding arch std event
>>>    support (https://lkml.org/lkml/2018/2/6/501)
>>> - add patch to drop topic subdirectory support
>>> - add patch for bug fix in json_events()
>>> - add review tags from Jiri Olsa
>>
>> can't tell if those json file changes are ok, but for all the code changes:
>>
> 
> Hi William, Ganapatrao,
> 
> Can you check the modifications to the ARM64 JSONs you originally submitted in the patchset please?> 
> If they are not checked, I'll have to see if the maintainers will accept without your review. If not, I'll have to drop them.

Hi John,

I will take a look at the patches this weekend and give feedback beginning of next week. -Will

> 
> Thanks,
> John
> 
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>
>> thanks,
>> jirka
>>
>> .
>>
> 
> 
