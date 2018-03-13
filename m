Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCMP13 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:27:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37452 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932408AbeCMP11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:27:27 -0400
Subject: Re: [PATCH 18/31] perf vendor events arm64: Add
 armv8-recommended.json
To: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
 <6c485ee7-87d1-dc51-db34-94169b9ede08@huawei.com>
 <20180313150838.j6mfywse64o5ixhd@gmail.com>
CC: Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Namhyung Kim <namhyung@kernel.org>, William Cohen <wcohen@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, <linux-arm-kernel@lists.infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <3ea1dc12-3cf1-39a5-ccb8-6ab85bce6f3d@huawei.com>
Date: Tue, 13 Mar 2018 15:27:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180313150838.j6mfywse64o5ixhd@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 15:08, Ingo Molnar wrote:
>
> * John Garry <john.garry@huawei.com> wrote:
>
>> On 13/03/2018 14:26, Ingo Molnar wrote:
>>>
>>> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>>> From: John Garry <john.garry@huawei.com>
>>>>
>>>> Add JSON for ARMv8 IMPLEMENTATION DEFINED recommended events.
>>>>
>>>> The JSON is copied from ARMv8 architecture reference manual, available
>>>> here:
>>>>
>>>> 	https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf
>>>>
>>>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Originally-from: Shaokun Zhang <zhangshaokun@hisilicon.com>

>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: William Cohen <wcohen@redhat.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linuxarm@huawei.com
>>>> Link: http://lkml.kernel.org/r/1520506716-197429-9-git-send-email-john.garry@huawei.com
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> That's not a valid SOB chain, author != first-Signed-off-by.
>>>
>>
>> Right, so my SOB can go first.
>>
>> Let me know how to help remedy.
>
> Well, it depends on what role Shaokun Zhang had in the creation of the patch: if
> he co-authored the patch and you finished it then you can add him as:
>
>   Originally-from: Shaokun Zhang <zhangshaokun@hisilicon.com>
>
> or if he tested/reviewed the patch then his entry should be Reviewed-by/Acked-by
> or Tested-by.
>

Hi Ingo, Arnaldo,

I think it would be fair to say the former, that is: "he co-authored the 
patch and you finished it".

Thanks,
John

> Thanks,
>
> 	Ingo
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
