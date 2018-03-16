Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeCPJlB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:41:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40402 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeCPJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:39:46 -0400
X-Google-Smtp-Source: AG47ELud/6/gBGm5qebL65EevtuBmXUBlEZ/aRKVOZ+5Umz7DSpTwTQSP1b5MCHY9mAS/EPzd7y3ZQ==
MIME-Version: 1.0
In-Reply-To: <658946b9-4f49-ff24-3b84-da1eb9b7d9ad@micronovasrl.com>
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180316064731.muiw5yumhmfnwxg2@flea> <658946b9-4f49-ff24-3b84-da1eb9b7d9ad@micronovasrl.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 16 Mar 2018 17:39:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v66bdH4kr=T=A0MNKShOCKkvp=+dWDZLskBoUJn_pUJDgw@mail.gmail.com>
Message-ID: <CAGb2v66bdH4kr=T=A0MNKShOCKkvp=+dWDZLskBoUJn_pUJDgw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888 output.
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 5:19 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> Hi Maxime,
>
> Il 16/03/2018 07:47, Maxime Ripard ha scritto:
>>
>> Hi Giulio,
>>
>> On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
>>>
>>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>>> for the needed pins.
>>>
>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>>
>> Like we discussed last time, we only merge this kind of patches if
>> there's an immediate user.
>
>
> You're right.
> In few time(I hope), I'm going to send dts for Linova1-4_3 and Linova1-7,
> where I use those pins.
> I have also to send 2 patches for 2 new panels for panel-simple.
>
> So I think I have to send 2 displays' patches before.
> And a patchset for the 2 boards and rgb888 pins.
>
> One question: do I have to wait for panels' patches to applied and then send
> patchset for boards dts?
> Or can I send a unique patchset?
> Because as I understand those patches should be applied to 2 different
> repositories, right?

If none of them have been merged yet, it's best to send all of them
as part of the same series, and to all parties involved. That way,
people have the full picture of what you're trying to achieve when
they review your patches. Unless your series is really big.

Maintainers will pick up patches that need to go through their trees.
In general you don't need to do much coordination beyond pointing out
whether the patches are safe to go in independently or there are
dependencies that the maintainers need to be aware of.

ChenYu
