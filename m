Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeDSEVv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:21:51 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45869 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeDSEVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:21:49 -0400
X-Google-Smtp-Source: AB8JxZpjsjoakmsktZdiDFnZhCk8qao8e+JnZJmIH7sAgdulIkaKbP3DaOTX+05cGX7I84aM9HtZseYTmEeoYvvG/sA=
MIME-Version: 1.0
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Thu, 19 Apr 2018 09:51:48 +0530
Message-ID: <CAMet4B53EvFqf+hzGS6TKGpDO8BSttVZWw8VhDktoo_rc-fn-w@mail.gmail.com>
Subject: Re: tg3 crashes under high load, when using 100Mbits
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Satish Baddipadige <satish.baddipadige@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanley Hsiao <stanley.hsiao@canonical.com>,
        Tim Chen <tim.chen119@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3J4LuEi029261

On Sat, Apr 14, 2018 at 9:17 PM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Satish,
>
>> On 2018Mar21, at 00:57, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> Satish Baddipadige <satish.baddipadige@broadcom.com> wrote:
>>
>>> On Thu, Feb 15, 2018 at 7:37 PM, Siva Reddy Kallam
>>> <siva.kallam@broadcom.com> wrote:
>>>> On Mon, Feb 12, 2018 at 10:59 AM, Siva Reddy Kallam
>>>> <siva.kallam@broadcom.com> wrote:
>>>>> On Fri, Feb 9, 2018 at 10:41 AM, Kai Heng Feng
>>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>> Hi Broadcom folks,
>>>>>>
>>>>>> We are now enabling a new platform with tg3 nic, unfortunately we observed
>>>>>> the bug [1] that dated back to 2015.
>>>>>> I tried commit 4419bb1cedcd ("tg3: Add workaround to restrict 5762 MRRS to
>>>>>> 2048”) but it does’t work.
>>>>>>
>>>>>> Do you have any idea how to solve the issue?
>>>>>>
>>>>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1447664
>>>>>>
>>>>>> Kai-Heng
>>>>> Thank you for reporting. We will check and update you.
>>>> With link aware mode, the clock speed could be slow and boot code does not
>>>> complete within the expected time with lower link speeds. Need to override
>>>> and the clock in driver. We are checking the feasibility of adding
>>>> this in driver or firmware.
>>>
>>> Hi Kai-Heng,
>>>
>>> Can you please test the attached patch?
>>
>> I built a kernel and asked affected users to try.
>
> Users reported that the crash still happens with the patch.
>
> Kai-Heng
>
Thanks for the feedback. We will re-work on the patch and soon provide
you the update.
>>
>> Thanks for your work.
>>
>> Kai-Heng
>>
>>>
>>> Thanks,
>>> Satish
>>> <tg3_5762_clock_override.patch>
>
