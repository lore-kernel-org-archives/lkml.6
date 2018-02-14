Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967300AbeBNKjc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:39:32 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:38633 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967283AbeBNKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:39:27 -0500
X-Google-Smtp-Source: AH8x227HiLvXFih0oJ37FK0MscUx1MwTBCE71UdbXfd7aKcytWtsDcO9E9jK3sbLPIEq0U6MRgEiqiHGU7yfdBcv40E=
MIME-Version: 1.0
In-Reply-To: <20180214102311.w7hfbnpfkecnjlkb@katana>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
 <20180207191152.kvqrugblst2cko3c@ninjato> <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
 <20180214102311.w7hfbnpfkecnjlkb@katana>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2018 11:39:26 +0100
Message-ID: <CAPDyKFox8m4maTHQZi4gzyi=UVh0KO_xnfhjbjeMxsd=a9PB5A@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
To: Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
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

On 14 February 2018 at 11:23, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> You need to check again. :-)
>
> Seems like it. Sorry for the noise.
>
>> I am eager to apply those patches you already have reviewed (to
>> patch14), as those mostly seemed rather trivial and should be nice
>> cleanups.
>>
>> Do you mind me going ahead, then you can continue and review/test the rest?
>
> Yes, we can work incremently from there. I'll send patches if I discover
> something unexpected.
>

Great! So, applied patches 7->14.

Thanks and kind regards
Uffe
