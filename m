Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755822AbeCHMEk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:04:40 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33415 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeCHMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:04:38 -0500
X-Google-Smtp-Source: AG47ELvNHvlqP+haON6w8MLw+aUUn4TTeXEqwkvtcoKPV6Fae1pi+nwvksmPqjesUjgo4zn4jdFC7QQX3L6bkPzxIag=
MIME-Version: 1.0
In-Reply-To: <20180308113647.75279391@canb.auug.org.au>
References: <20180308073921.5c104e74@canb.auug.org.au> <CACRpkdaWd_7QWd7t5i6DvU3_Gu1giR9v2uoqQiLNXVWTPEty8w@mail.gmail.com>
 <20180308113647.75279391@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Mar 2018 13:04:37 +0100
Message-ID: <CACRpkdYcBrL_o4ygShJ=Tzt+UxOVQnekgd576Ko1zGkgNQrkPg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 1:36 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Linus,
>
> On Wed, 7 Mar 2018 23:25:48 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Wed, Mar 7, 2018 at 9:39 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> > Commit
>> >
>> >   fc08fa6009a0 ("pinctrl: sh-pfc: r8a7795: remove duplicate of CLKOUT pin in pinmux_pins[]")
>> >
>> > is missing a Signed-off-by from its committer.
>>
>> Looping in Geert,
>>
>> I guess this came in through the Renesas PFC pull request.
>>
>> Geert do you prefer that I back it all out so you can send me
>> a new pull request? Or some other solution?
>
> But you are listed as the committer ...

Bah yeah this commit is on the fixes branch like Geert says, sorry it
is 100% my sloppy mistake.

I fixed it up and pushed the result for-next.

Sorry for the fuzz!

Yours,
Linus Walleij
