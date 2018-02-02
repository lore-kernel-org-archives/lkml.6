Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeBBNtg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:49:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38408 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751956AbeBBNtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:49:08 -0500
Subject: Re: Is the hisilicon tree maintained ?
To: Daniel Lezcano <daniel.lezcano@linaro.org>
References: <68abfa22-86fa-67db-b583-661c9f5672ce@linaro.org>
 <5A744EBA.7030104@hisilicon.com>
 <e7a0977d-5fee-b874-d6b7-21638bb9b885@linaro.org>
 <5A745526.6040006@hisilicon.com>
 <9f22e61e-a5d4-47b9-b8dd-71443b9aa408@linaro.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A746C4A.9050604@hisilicon.com>
Date: Fri, 2 Feb 2018 13:48:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <9f22e61e-a5d4-47b9-b8dd-71443b9aa408@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.123]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2018/2/2 13:34, Daniel Lezcano wrote:
> On 02/02/2018 13:10, Wei Xu wrote:
>> Hi Daniel,
>>
>> On 2018/2/2 12:05, Daniel Lezcano wrote:
>>> On 02/02/2018 12:42, Wei Xu wrote:
>>>> Hi Daniel,
>>>>
>>>> On 2018/2/2 6:59, Daniel Lezcano wrote:
>>>>>
>>>>> Hi Wei Xu,
>>>>>
>>>>> I found in the MAINTAINERS file the hisilicon tree is at:
>>>>>
>>>>> https://github.com/hisilicon/linux-hisi
>>>>>
>>>>> But, (except I missed it) I didn't find any update since Nov, 2017.
>>>>>
>>>>> Is that tree maintained ?
>>>>
>>>> Yes. It is still maintained.
>>>> You can find update from other branches or the tags like next/dt64.
>>>> I will update the master when every rc1 is released.
>>>
>>> Is there a development branch for something else than the DT ?
>>
>> Sorry, no developing branch is there.
>> But we will create one if needed like the topic-acpi-mbigen branch.
>> And most of development branches are kept in another git repo.
> 
> What is the purpose of this tree? Why not rely on arm-soc?

Currently it is mainly a place to pick up the patches
and save the pull request.

Best Regards,
Wei

> 
> 
> 
