Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeBBNex (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:34:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40188 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeBBNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:34:47 -0500
X-Google-Smtp-Source: AH8x226/CvRfXLf0N4ftCCUJQ9Bgc4OkmZmJ5lWJGYFfw7VwTkK8kZEAntbHcaFBFPCHZX+pESZzWw==
Subject: Re: Is the hisilicon tree maintained ?
To: Wei Xu <xuwei5@hisilicon.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <68abfa22-86fa-67db-b583-661c9f5672ce@linaro.org>
 <5A744EBA.7030104@hisilicon.com>
 <e7a0977d-5fee-b874-d6b7-21638bb9b885@linaro.org>
 <5A745526.6040006@hisilicon.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9f22e61e-a5d4-47b9-b8dd-71443b9aa408@linaro.org>
Date: Fri, 2 Feb 2018 14:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <5A745526.6040006@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 13:10, Wei Xu wrote:
> Hi Daniel,
> 
> On 2018/2/2 12:05, Daniel Lezcano wrote:
>> On 02/02/2018 12:42, Wei Xu wrote:
>>> Hi Daniel,
>>>
>>> On 2018/2/2 6:59, Daniel Lezcano wrote:
>>>>
>>>> Hi Wei Xu,
>>>>
>>>> I found in the MAINTAINERS file the hisilicon tree is at:
>>>>
>>>> https://github.com/hisilicon/linux-hisi
>>>>
>>>> But, (except I missed it) I didn't find any update since Nov, 2017.
>>>>
>>>> Is that tree maintained ?
>>>
>>> Yes. It is still maintained.
>>> You can find update from other branches or the tags like next/dt64.
>>> I will update the master when every rc1 is released.
>>
>> Is there a development branch for something else than the DT ?
> 
> Sorry, no developing branch is there.
> But we will create one if needed like the topic-acpi-mbigen branch.
> And most of development branches are kept in another git repo.

What is the purpose of this tree? Why not rely on arm-soc?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
