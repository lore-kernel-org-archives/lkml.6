Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBBO3z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:29:55 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38661 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBBO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:29:47 -0500
X-Google-Smtp-Source: AH8x225IzbvGY5m3ZZyHFI1WmIMMYCo88SNB+Hy4ZTIWib59BsOtTBP9YrJOxM7T+aK/WF7l1TW8KQ==
Subject: Re: Is the hisilicon tree maintained ?
To: Wei Xu <xuwei5@hisilicon.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <68abfa22-86fa-67db-b583-661c9f5672ce@linaro.org>
 <5A744EBA.7030104@hisilicon.com>
 <e7a0977d-5fee-b874-d6b7-21638bb9b885@linaro.org>
 <5A745526.6040006@hisilicon.com>
 <9f22e61e-a5d4-47b9-b8dd-71443b9aa408@linaro.org>
 <5A746C4A.9050604@hisilicon.com>
 <ce9f1703-d27b-5d57-bf32-497917fca361@linaro.org>
 <5A746FD6.5050603@hisilicon.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <26b7f172-c8d3-0a2e-3573-a488e3ca8ef7@linaro.org>
Date: Fri, 2 Feb 2018 15:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <5A746FD6.5050603@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 15:04, Wei Xu wrote:
> Hi Daniel,
> 
> On 2018/2/2 13:53, Daniel Lezcano wrote:
>> On 02/02/2018 14:48, Wei Xu wrote:
>>> Hi Daniel,
>>>
>>> On 2018/2/2 13:34, Daniel Lezcano wrote:
>>>> On 02/02/2018 13:10, Wei Xu wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On 2018/2/2 12:05, Daniel Lezcano wrote:
>>>>>> On 02/02/2018 12:42, Wei Xu wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> On 2018/2/2 6:59, Daniel Lezcano wrote:
>>>>>>>>
>>>>>>>> Hi Wei Xu,
>>>>>>>>
>>>>>>>> I found in the MAINTAINERS file the hisilicon tree is at:
>>>>>>>>
>>>>>>>> https://github.com/hisilicon/linux-hisi
>>>>>>>>
>>>>>>>> But, (except I missed it) I didn't find any update since Nov, 2017.
>>>>>>>>
>>>>>>>> Is that tree maintained ?
>>>>>>>
>>>>>>> Yes. It is still maintained.
>>>>>>> You can find update from other branches or the tags like next/dt64.
>>>>>>> I will update the master when every rc1 is released.
>>>>>>
>>>>>> Is there a development branch for something else than the DT ?
>>>>>
>>>>> Sorry, no developing branch is there.
>>>>> But we will create one if needed like the topic-acpi-mbigen branch.
>>>>> And most of development branches are kept in another git repo.
>>>>
>>>> What is the purpose of this tree? Why not rely on arm-soc?
>>>
>>> Currently it is mainly a place to pick up the patches
>>> and save the pull request.
>>
>> What is the other repo with development branches you mentioned above ?
> 
> Sorry, they are private repos in the github hisilicon and are for the SoC
> enablement like hip06, hip07 and so on.
> But if you can share what kind of information you want, I can create a
> public branch in the hisilicon/linux-hisi repo if I have those.

Actually I was expecting to see an up-to-date branch I can rely on to
base my patches.

Apparently there is very few dev on this tree. Why not change the tree
to arm-soc in the MAINTAINERS file ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
