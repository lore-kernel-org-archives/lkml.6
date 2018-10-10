Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8553F2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8553F2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJJT0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:26:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:26:33 -0400
Received: from [192.168.178.69] ([109.104.41.19]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtwlO-1fp6Qt3MdQ-00uHAU; Wed, 10 Oct 2018 14:04:15 +0200
Received: from [192.168.178.69] ([109.104.41.19]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtwlO-1fp6Qt3MdQ-00uHAU; Wed, 10 Oct 2018 14:04:15 +0200
Subject: Re: [Question] directory for SoC-related DT binding
To:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
Date:   Wed, 10 Oct 2018 14:04:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:sIbZCjg0REpqJ+FWXKUsH0dSXWPD3mlSFFQ2yrTKyb5z/rLOooF
 ka9tPHc9pOTcY3Tan0/7eZvfKAkDUEYebx8ixUk8Ajt+PL1e3iILFOgneOfWKWuzXRT5Jz+
 yKsHsDtEswaUNA+AoQfc9M/sEcHq0NI1mFlr93WpSe+7S+b+nh80bLv5aApnvkK8mWaAvKz
 X8FAnq7KwI9BMdOZw9LTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:555bY9u0L1c=:WtbyChtCKi+xP+9QSe/KLZ
 faCWgAgj8q1xMdAxjxBF696qjBDwd2jXJDX0ixGsLj3r1+d2lBekU7F5wQmXlq3U1fdABHybL
 8ZFNeWnOpB0zcowCNLiIUoFMZnFoLP33eDPJdDCgk3X7YfxJDWfgI6M3KWYFb9YSbcUz8PzWm
 sS+j21KNAyc6MLc71VMAlufrSOP+b0CXl1N+HLBY3DpL3jnGLZQgYy9NRYbfFeyL09g8b5f3k
 kwY9cRjCYmO41yfNdsrjBgf1yXOC7w79A+1RhLKezbge0z1Gzpz2GVJbfNijL0XPly5YPnXbJ
 /q580SnLxG2yDtvBstsouFxUBZDdxHeRSncR8ndZX8LtzvIdV4wpXy4VJMsTM6ujJo784n3ZG
 ZjzJ+ndNevQ0Th6r98ds+9N6QaVQOTq31CuvmTnLMZOkTrwJS9/9UOzTwiA8vyDoainLTRixW
 K2BE9eUQ9y1RyP99MaTrpW0nruNkcAduzLIG8LgxxubDQtWtWi6Bl1i+HnWmi4pPuERVNvVnv
 sXTOGUyzSCRItfO4tyjTuRa8xUjh1YQCtQUhYm2h3pef+SgFSFK6oUFCUtgyKi1h2B2gW6YQR
 QBC33il/er+ByJNPG1b6esyglMnbg9a9VT3AlQEy9U2LqUiCmWCYm6A2C+HIjfrKr1ap0GKC1
 VHjnOnm0zJQjIfMmcY2p3vsYLAV5OFBFAYtDoll522ZdyTQ1ksWiqM8R7iCf9QfJXnV46GsEg
 KOclqSIgySy0YQ0C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 10.10.2018 um 13:19 schrieb Rob Herring:
> On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi,
>>
>>
>> I see a bunch of vendor (or SoC) names in
>> Documentation/device/bindings/arm/
>>
>> ./Documentation/devicetree/bindings/arm/altera
>> ./Documentation/devicetree/bindings/arm/amlogic
> Yeah, it's kind of a mixture of board/soc bindings mostly with some
> ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.
>
> Eventually, I'd like to not split board bindings by arch and maybe we
> should move all the system/misc reg bindings out.
>
> [,,,]
>
>> I also see some vendor names in
>> Documentation/device/bindings/soc/
>>
>> ./Documentation/devicetree/bindings/soc/bcm
>> ./Documentation/devicetree/bindings/soc/dove
>> ./Documentation/devicetree/bindings/soc/fsl
>> ./Documentation/devicetree/bindings/soc/mediatek
>> ./Documentation/devicetree/bindings/soc/qcom
>> ./Documentation/devicetree/bindings/soc/rockchip
>> ./Documentation/devicetree/bindings/soc/ti
>> ./Documentation/devicetree/bindings/soc/xilinx
>> ./Documentation/devicetree/bindings/soc/zte
> This I believe is mostly SoC system reg bindings though there's
> probably a few other things.
>
>> Confusingly, I see bcm, mediatek, rockchip
>> in both locations.
>>
>> Is there any rule to choose one than the other?
> Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.

in case of Documentation/devicetree/bindings/soc/bcm the directory
contains SoC / board bindings, cpu-enable and a firmware binding.

Is there any action required?

Btw the Broadcom SoC / boards from this directory has been left out for
the yaml conversion [1] was this intended?

[1] - https://lwn.net/Articles/767723/

>
> Rob
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

