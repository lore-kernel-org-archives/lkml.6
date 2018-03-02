Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034429AbeCBQkw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:40:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51778 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S934765AbeCBQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:40:40 -0500
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
To: Ganapatrao Kulkarni <gklkml16@gmail.com>,
        William Cohen <wcohen@redhat.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
 <cafdb160-3072-389b-8c31-93f09eff84a8@redhat.com>
 <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
CC: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
        <Jayachandran.Nair@cavium.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4d22ba78-dba7-a550-f31b-64f29e3f0cbc@huawei.com>
Date: Fri, 2 Mar 2018 16:40:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Can you check the modifications to the ARM64 JSONs you originally submitted in the patchset please?>
>>> If they are not checked, I'll have to see if the maintainers will accept without your review. If not, I'll have to drop them.
>
> I am seeing issue(log below) with this patchset on our platfrom.
> i have tried using your v2 branch [1]
>
> root@borg-1>perf_acme>> ./perf --version
> perf version 4.16.rc1.g087f7ca
> root@borg-1>perf_acme>> ./perf stat -e bus_access_rd sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>             23,099      bus_access_rd
>
>        1.000708516 seconds time elapsed
>
> root@borg-1>perf_acme>> cd -
> /ganapat/perf/linux-hisi/tools/perf
> root@borg-1>perf>> ./perf --version
> perf version 4.16.rc1.gcb5a74
> root@borg-1>perf>> ./perf stat -e bus_access_rd sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>                  0      bus_access_rd
>
>        1.000709162 seconds time elapsed
>
> root@borg-1>perf>>
>
>
> [1] https://github.com/hisilicon/linux-hisi.git

Hi Ganapatrao,

Thanks for the notification. Let me check this.

Regards,
John

>
>>
>> Hi John,
>>
>> I will take a look at the patches this weekend and give feedback beginning of next week. -Will
>>
>>>
>>> Thanks,
>>> John
>>>
>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>> .
>
> thanks
> Ganapat
>>>>
>>>
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
