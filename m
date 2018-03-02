Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423067AbeCBIpJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:45:09 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:42725 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423038AbeCBIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:45:07 -0500
X-Google-Smtp-Source: AG47ELsmQHazRO6W3dwZiovUIt6jpBAy5M2m0b5jN5T79LeUuhcLFyl3PVaT98dougRzTjPjTo9OnKdnIzFejH0lpCY=
MIME-Version: 1.0
In-Reply-To: <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava> <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Fri, 2 Mar 2018 14:15:05 +0530
Message-ID: <CAKTKpr4vDByhQ_16XT_+Uo4An3KF_UOB7CTYBrG7Miu0ujDaXA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
To: John Garry <john.garry@huawei.com>
Cc: wcohen@redhat.com,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        ak@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Jayachandran.Nair@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Mar 2, 2018 at 1:54 PM, John Garry <john.garry@huawei.com> wrote:
> On 27/02/2018 09:50, Jiri Olsa wrote:
>>
>> On Sat, Feb 24, 2018 at 12:05:21AM +0800, John Garry wrote:
>>>
>>> This patchset adds support for some perf events features,
>>> targeted at ARM64, implemented in a generic fashion.
>>>
>>> The two main features are as follows:
>>> - support for arch/vendor/platform pmu events directory structure
>>>    - to support this, topic subdirectory support needs to be dropped
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
>>>    support (https://lkml.org/lkml/2018/2/6/501)
>>> - add patch to drop topic subdirectory support
>>> - add patch for bug fix in json_events()
>>> - add review tags from Jiri Olsa
>>
>>
>> can't tell if those json file changes are ok, but for all the code
>> changes:
>>
>
> Hi William, Ganapatrao,
>
> Can you check the modifications to the ARM64 JSONs you originally submitted
> in the patchset please?

Sorry,  i have missed to notice. I will go through this series and
share my feedback in couple of days.

>
> If they are not checked, I'll have to see if the maintainers will accept
> without your review. If not, I'll have to drop them.
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

thanks
Ganapat
>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
