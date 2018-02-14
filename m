Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966915AbeBNJgr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:36:47 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:42184 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966693AbeBNJgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:36:44 -0500
X-Google-Smtp-Source: AH8x226N6VSrwsnKO/w6dMFOMFsIADi+AoRyJ9aAzIel8EjvZDqGRpbpPqp5qGtDO5D9AUg+pR29Vwb9AbBmMzZT1Zo=
MIME-Version: 1.0
In-Reply-To: <20180207191152.kvqrugblst2cko3c@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com> <20180207191152.kvqrugblst2cko3c@ninjato>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2018 10:36:42 +0100
Message-ID: <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2018 at 20:11, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I picked patch5 and patch6, as those seemed trivial. Unless there is a
>> rc9, let's aim for 4.17 for the rest.
>
> I can't find the branch where you picked these patches? I wanted to use
> it to apply the rest of the patches. They don't seem to fit on v4.15
> or current linus/master. Can you share this branch?

You need to check again. :-)

Patches up and to patch6 is already in Linus' tree v.16rc1, those I
carried for quite a while on my next branch before sending them in the
PR to Linus.

>
> I will do reviewing now "visually". But please wait until I tested them
> before applying.

I am eager to apply those patches you already have reviewed (to
patch14), as those mostly seemed rather trivial and should be nice
cleanups.

Do you mind me going ahead, then you can continue and review/test the rest?

Kind regards
Uffe
