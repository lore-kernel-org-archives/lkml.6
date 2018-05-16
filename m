Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEPRks (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:40:48 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45868 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeEPRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:40:46 -0400
X-Google-Smtp-Source: AB8JxZq4ECb/r7HKtspQL8hKkzAyC9vwpeWP8cBP8cgwhXEMGr/rJj1QAQN0JK3QzGDNvvVVxMCYyWumOw3eEni1x8k=
MIME-Version: 1.0
In-Reply-To: <CACRpkdZTMqf0sFCMPaX2aAcxrJ3LXAi7-Cfx5qevvp7To0V6NA@mail.gmail.com>
References: <20180516072753.49dd4d88@canb.auug.org.au> <CAMuHMdVEOmrd9da8XR0_wKJw9+KygkCUTSWvQjtP2Xh9aOkSFQ@mail.gmail.com>
 <CACRpkdYgE+UWqTZPSbxBP0ucQK5xS7qCsT=5hne-LevXdU3O5A@mail.gmail.com>
 <CAMuHMdVPonsrrmEeTmBR+3YW65hSaHbVOz-8_A10cLoAd2SXyw@mail.gmail.com> <CACRpkdZTMqf0sFCMPaX2aAcxrJ3LXAi7-Cfx5qevvp7To0V6NA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 May 2018 19:40:43 +0200
X-Google-Sender-Auth: ND_fXvnQa0TvtUkAal5qt2DgQ8k
Message-ID: <CAMuHMdXhE8WZnL5fR9pvDkMDVrRXQdajL0r=113eHuK9RKoigw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, May 16, 2018 at 1:33 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 16, 2018 at 1:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, May 16, 2018 at 1:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Wed, May 16, 2018 at 9:16 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Tue, May 15, 2018 at 11:27 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>> Commit
>>>>>
>>>>>   f18fab4bcb4f ("pinctrl: sh-pfc: Add r8a77470 PFC support")
>>>>>
>>>>> is missing a Signed-off-by from its comitter.
>>>>
>>>> Sorry, I forgot to add it.
>>>>
>>>> Linus, as the merge of sh-pfc is your top commit, shall I fix it up
>>>> and send a new
>>>> pull request?
>>>> Please let me know how to proceed. Thanks!
>>>
>>> If it's just missing your SoB I can add it with your permission
>>> I guess? That is less trouble.
>>
>> You have my permission.
>> But I'm afraid that won't help, as then you'll become the committer with your
>> SoB missing...
>
> Bah I just sign them all off then. It's still quicker.
>
> Done!

Thanks! I'll be more careful next time.

I guess I should base my next pull request on the new commit
73dacc3403436fc2 ("pinctrl: sh-pfc: Add r8a77470 PFC support") in your
tree, instead of on my previous pull request? Else there will be some
conflicts (I checked: so far in one file only).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
