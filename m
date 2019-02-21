Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA476C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A82146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBUAgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:36:19 -0500
Received: from mx.socionext.com ([202.248.49.38]:12396 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfBUAgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:36:19 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Feb 2019 09:36:16 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8D0D218010B;
        Thu, 21 Feb 2019 09:36:16 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 21 Feb 2019 09:36:16 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 0E0B0403AA;
        Thu, 21 Feb 2019 09:36:16 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EE447121B6C;
        Thu, 21 Feb 2019 09:36:15 +0900 (JST)
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
 <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
 <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
 <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
 <CAA93ih3EUfgw9TeduOCOJZzWjQEv_VKp9t0+rdZA6rwk_8ThLA@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <010ca462-a245-8bec-c2eb-8af21d087486@socionext.com>
Date:   Thu, 21 Feb 2019 09:36:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAA93ih3EUfgw9TeduOCOJZzWjQEv_VKp9t0+rdZA6rwk_8ThLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/20 22:23, Masami Hiramatsu wrote:
> Hi Arnd,
> 
> 2019年2月20日(水) 22:18 Arnd Bergmann <arnd@arndb.de>:
>>
>> On Wed, Feb 20, 2019 at 2:16 PM Masami Hiramatsu
>> <masami.hiramatsu@linaro.org> wrote:
>>> 2019年2月20日(水) 21:28 Arnd Bergmann <arnd@arndb.de>:
>>>> On Wed, Feb 20, 2019 at 12:27 PM Sugaya, Taichi
>>>> <sugaya.taichi@socionext.com> wrote:
>>>>> On 2019/02/20 18:28, Arnd Bergmann wrote:
>>>>>> On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
>>>>>> <sugaya.taichi@socionext.com> wrote:
>>>>>>
>>>>>>> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
>>>>>>> new file mode 100644
>>>>>>> index 0000000..a263211
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
>>>>>>> @@ -0,0 +1,175 @@
>>>>>>
>>>>>> I no longer see anything here that should be turned off, but you
>>>>>> might want to run 'make savedefconfig' and use the output of that,
>>>>>> to make it easier to keep it up to date.
>>>>>>
>>>>>
>>>>> I got it, I use the output of 'make savedefconfig'.
>>>>> One question, is that OK to add some options on it?
>>>>>    -Because "CONFIG_ARCH_MILBEAUT" was not listed.
>>>>
>>>> What I'd do here is to apply all the patches you want to get merged in
>>>> the next few releases before running 'savedefconfig' and use the output
>>>> of that.
>>>
>>> Let me check. Would you mean that the defconfig will include all those
>>> drivers configs, which will not appear at this moment?
>>
>> Correct.
>>
>>>> If you already know that you will need the options, including
>>>> them now means you don't have to update the defconfig file
>>>> as much in the future.
>>>
>>> I just concern that if other subsystem maintainer comments
>>> on the config name. Even in that case, can we just update the
>>> defconfig with new name?
>>
>> Yes, that's easy enough.
> 
> OK, I got it :)
> 
> Thank you!
> 

Thank you for the detail. I got it too.


>>
>>        Arnd
> 
> 
> 

