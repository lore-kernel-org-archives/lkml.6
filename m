Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeCPNLX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:11:23 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:52642 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:11:22 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.91
Subject: Re: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180316064731.muiw5yumhmfnwxg2@flea>
 <658946b9-4f49-ff24-3b84-da1eb9b7d9ad@micronovasrl.com>
 <CAGb2v66bdH4kr=T=A0MNKShOCKkvp=+dWDZLskBoUJn_pUJDgw@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <e9498de3-8f5e-1273-954d-86384fbc02ab@micronovasrl.com>
Date: Fri, 16 Mar 2018 14:11:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v66bdH4kr=T=A0MNKShOCKkvp=+dWDZLskBoUJn_pUJDgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 16/03/2018 10:39, Chen-Yu Tsai ha scritto:
> On Fri, Mar 16, 2018 at 5:19 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> Hi Maxime,
>>
>> Il 16/03/2018 07:47, Maxime Ripard ha scritto:
>>>
>>> Hi Giulio,
>>>
>>> On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
>>>>
>>>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>>>> for the needed pins.
>>>>
>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>
>>>
>>> Like we discussed last time, we only merge this kind of patches if
>>> there's an immediate user.
>>
>>
>> You're right.
>> In few time(I hope), I'm going to send dts for Linova1-4_3 and Linova1-7,
>> where I use those pins.
>> I have also to send 2 patches for 2 new panels for panel-simple.
>>
>> So I think I have to send 2 displays' patches before.
>> And a patchset for the 2 boards and rgb888 pins.
>>
>> One question: do I have to wait for panels' patches to applied and then send
>> patchset for boards dts?
>> Or can I send a unique patchset?
>> Because as I understand those patches should be applied to 2 different
>> repositories, right?
> 
> If none of them have been merged yet, it's best to send all of them
> as part of the same series, and to all parties involved. That way,
> people have the full picture of what you're trying to achieve when
> they review your patches. Unless your series is really big.
> 
> Maintainers will pick up patches that need to go through their trees.
> In general you don't need to do much coordination beyond pointing out
> whether the patches are safe to go in independently or there are
> dependencies that the maintainers need to be aware of.

Ok, now it's clear to me.
I've submitted only few patches till now,
so I didn't know about that.

Thank you very much

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
> ChenYu
> 
