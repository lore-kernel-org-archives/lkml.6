Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeCRCrt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 22:47:49 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:50502 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeCRCrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 22:47:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2I2lTsD003167
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AG47ELu7qIr0SRY/q9paJkhLXznDznQVz/HhowgL98s/zS5uL8xkWA4xyIx+IsDd4isKAubzAefEdRsRVMk9B5bmmws=
MIME-Version: 1.0
In-Reply-To: <20180207193227.hu6cyh2e27dmrqwt@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-12-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg@mail.gmail.com> <20180207193227.hu6cyh2e27dmrqwt@ninjato>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 18 Mar 2018 11:46:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATy=VzKXS-uZBgYm5A1k6E-87qDGNBTi=zFi9JGa2xrng@mail.gmail.com>
Message-ID: <CAK7LNATy=VzKXS-uZBgYm5A1k6E-87qDGNBTi=zFi9JGa2xrng@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] mmc: tmio: deprecate "toshiba,mmc-wrprotect-disable"
 DT property
To: Wolfram Sang <wsa@the-dreams.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-08 4:32 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jan 18, 2018 at 10:58:36AM +0900, Masahiro Yamada wrote:
>> 2018-01-18 1:28 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> > This property is equivalent to "disable-wp" defined in
>> > Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>>
>> This is mistake.
>>
>> "disable-wp" is defined in
>>
>> Documentation/devicetree/bindings/mmc/mmc.txt
>
> With that fixed:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>

BTW, the subject of the applied version is wrong.

In my original post:
https://patchwork.kernel.org/patch/10170007/
"toshiba,mmc-wrprotect-disable"
No space after the vendor prefix.


But, applied commit (788778b0d21a6d5cd5)
I see a space, like
"toshiba, mmc-wrprotect-disable"


I think this is a bug of patchwork.


I have seen various bugs that break
the patch format.

I filed some bug reports for patchwork,
but not sure what happened.

-- 
Best Regards
Masahiro Yamada
