Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FFE2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfBTF3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:29:51 -0500
Received: from mx.socionext.com ([202.248.49.38]:46055 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfBTF3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:29:50 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Feb 2019 14:29:48 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C2B70180097;
        Wed, 20 Feb 2019 14:29:48 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 20 Feb 2019 14:29:48 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 5266C1A04E0;
        Wed, 20 Feb 2019 14:29:48 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3894F121B6C;
        Wed, 20 Feb 2019 14:29:48 +0900 (JST)
Subject: Re: [PATCH v2 13/15] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a15mLEgVAh1+jQ+GqOcQa0zhrePWofo8iGkTs5_bd=TmQ@mail.gmail.com>
 <ba5bb646-7fa6-e98f-4ac2-47c55c8f82ba@socionext.com>
 <CAK8P3a0H3wYKqiV6XZe9V_y8rjDTFHcU_jq7+HkwX+6dnXvU9Q@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <cdba2c36-59bc-fb50-a795-03f9b00b11c8@socionext.com>
Date:   Wed, 20 Feb 2019 14:29:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0H3wYKqiV6XZe9V_y8rjDTFHcU_jq7+HkwX+6dnXvU9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/19 19:11, Arnd Bergmann wrote:
> On Tue, Feb 19, 2019 at 6:11 AM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>> Thank you for you comments.
>>
>> On 2019/02/18 21:09, Arnd Bergmann wrote:
>>> On Fri, Feb 8, 2019 at 1:28 PM Sugaya Taichi
>>> <sugaya.taichi@socionext.com> wrote:
>>>> +
>>>> +       aliases {
>>>> +               serial1 = &uart1;
>>>> +       };
>>>
>>> Maybe start with serial0 here? It seems unusual to start
>>> counting at 1.
>>>
>>
>> The M10V evaluation board(EVB) uses a console with uart ch1, so this
>> alias number is derived from the used channel one.
>> Therefore it is no problem to change the alias number to 0.
> 
> The alias should normally reflect whatever is printed on the board,
> if there are no labels, the convention is to start with zero, regardless
> of what internal uart is connected to it.
> 

I got it.
I use a "serial0" beacause there are no labels about uart ch on M10V EVB.

Thanks,
Sugaya Taichi

>       Arnd
> 

