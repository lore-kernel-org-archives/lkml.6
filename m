Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCMOei (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:34:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752214AbeCMOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:34:37 -0400
Subject: Re: [PATCH 18/31] perf vendor events arm64: Add
 armv8-recommended.json
To: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6c485ee7-87d1-dc51-db34-94169b9ede08@huawei.com>
Date: Tue, 13 Mar 2018 14:34:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180313142618.36je6syqg6ppwhbp@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 14:26, Ingo Molnar wrote:
>
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
>> From: John Garry <john.garry@huawei.com>
>>
>> Add JSON for ARMv8 IMPLEMENTATION DEFINED recommended events.
>>
>> The JSON is copied from ARMv8 architecture reference manual, available
>> here:
>>
>> 	https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf
>>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: William Cohen <wcohen@redhat.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxarm@huawei.com
>> Link: http://lkml.kernel.org/r/1520506716-197429-9-git-send-email-john.garry@huawei.com
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> That's not a valid SOB chain, author != first-Signed-off-by.
>

Right, so my SOB can go first.

Let me know how to help remedy.

Thanks,
John

> Thanks,
>
> 	Ingo
>
> .
>
