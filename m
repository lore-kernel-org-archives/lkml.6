Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC90FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86CC206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBTL1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:27:35 -0500
Received: from mx.socionext.com ([202.248.49.38]:6923 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfBTL1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:27:35 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Feb 2019 20:27:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3722D180097;
        Wed, 20 Feb 2019 20:27:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 20 Feb 2019 20:27:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 093ED1A04E0;
        Wed, 20 Feb 2019 20:27:34 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E7492120459;
        Wed, 20 Feb 2019 20:27:33 +0900 (JST)
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
Date:   Wed, 20 Feb 2019 20:27:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2019/02/20 18:28, Arnd Bergmann wrote:
> On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
>> new file mode 100644
>> index 0000000..a263211
>> --- /dev/null
>> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
>> @@ -0,0 +1,175 @@
> 
> I no longer see anything here that should be turned off, but you
> might want to run 'make savedefconfig' and use the output of that,
> to make it easier to keep it up to date.
> 

I got it, I use the output of 'make savedefconfig'.
One question, is that OK to add some options on it?
  -Because "CONFIG_ARCH_MILBEAUT" was not listed.


>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 5bee34a..6753805 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
>>   CONFIG_ARCH_KEYSTONE=y
>>   CONFIG_ARCH_MEDIATEK=y
>>   CONFIG_ARCH_MESON=y
>> +CONFIG_ARCH_MILBEAUT=y
>> +CONFIG_ARCH_MILBEAUT_M10V=y
>>   CONFIG_ARCH_MVEBU=y
>>   CONFIG_MACH_ARMADA_370=y
>>   CONFIG_MACH_ARMADA_375=y
> 
> I'm surprised that you don't need to enable any drivers. Does this actually
> boot on your hardware?
> 

Yes, but not exactly.
The series has not serial driver, so I add the driver temporarily and 
confirm the boot log through earlycon.
The timer driver is selected by "CONFIG_ARCH_MILBEAUT_M10V", no need to 
add the the"CONFIG_MILBEAUT_TIMER".

Here one more question.
Is this OK to submit a core support patch without any serial drivers?

Thanks,
Sugaya Taichi

>        Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

