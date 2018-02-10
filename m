Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBJIlQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:41:16 -0500
Received: from mout.perfora.net ([74.208.4.194]:58641 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJIlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:41:14 -0500
Date: Sat, 10 Feb 2018 09:40:30 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAOFm3uH+aasUA9MrV+uXvHUT=fzS63PvC2fDfNo3q687dUQ_dw@mail.gmail.com>
References: <20180210013806.28496-1-marcel@ziswiler.com> <20180210013806.28496-6-marcel@ziswiler.com> <CAOFm3uH+aasUA9MrV+uXvHUT=fzS63PvC2fDfNo3q687dUQ_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 5/6] ARM: dts: tegra: apalis-tk1: copyright period, spurious newlines
To: Philippe Ombredanne <pombredanne@nexb.com>
CC: linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
From: Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <C651C677-D157-41A3-B206-CB02B986AD19@ziswiler.com>
X-Provags-ID: V03:K0:BXDDARWpRreieOTVBnUN7yfxrzvlHOiTgWJarTh//vDWp+KmG3Y
 vQMvCBwIy6sdeKH1y8Z6SOt7v/AvYSbEdnx7sjvFTUlV9vte2BzbKJBuNB7fwcQCT7gdjBl
 I8YAV1gh6C6l8sLzPoekPMj4h3bIP0uqRsdaeX8U2vA2eXxGYbx1Prp+PzSu7RgQsRKT2++
 +7beb5kh4vUBycS2xk6Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ea5PjzZ0NK4=:pKCgk5BPbKFbtifFSnI3rF
 vfGRVNLaTyf9xQCuc2ubq1Mh9pSIAdTW/uCVdud3K7HHNEPGlnSTwFqYlwmsB38yoV5ziCyzj
 R7WLlTJx83oMba2l/LyAmETZ5O16eWpG5O5bKTGpBj32K3tuui9E+SncJPfgtv5B/9Ch87GlB
 kO3rSsVBzHkW2psZEu1oonrOv1GJDKlwtgWg5Zz1WECzmiTh8deRS46Fskebj7iAxfsLvyH/E
 Yc4C2qKel8EN7qD6DaO6TrzXTMN29qUe4fj9eimb14VVlPf4ELB4DgFDwzIQ57sEH7trsVtlz
 BU1/K7Bwlas22zlJ7vxjVGNNixp0UyI2Jm4luFEOpQP48DcYIcPKVTBtNoHyvoIuRhjMwDndE
 vUJca8vWVHgfbUwnSJxKYmN8o5Kj7Oj0xd2fDxooSEcFoUbzWCzuddd9LE6nr/L/6l78ysvEv
 BSHJiN0OG74GE3vwrRykOZuryM0ZvegU2CRf0PuMmgYwq6W+8mnX6txpVdyBiSIcwXMyYjaY6
 dS6MJULfMMUCO77nEy6UkS10PuNPtC/txa2sWS9qtbnbI+2xIT2wwD9a7ply+tE9D4AHd1m+e
 jwbjJEobBHwnH6+xfyM/15xIiRMdPa1sLeUs66FxT5vmeEovHribB8Yob21f90SeZqxnSnDsP
 83Ux2Uq+lZOvOTveRH2sQ2KXu63kR3Zx+LGEfT8I5hhJbkK5ruai78pF/GPM3Mci6siph9OIx
 rjWTSQZbxN+rvXb1+n3ZmtVnCXnuq/uoDorECA73H+qKbTYGBgL/HbfG0Z0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 10, 2018 8:07:58 AM GMT+01:00, Philippe Ombredanne <pombredanne@nexb.com> wrote:
>Marcel,
>
>On Sat, Feb 10, 2018 at 2:38 AM, Marcel Ziswiler <marcel@ziswiler.com>
>wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Update the copyright period and get rid of some spurious newlines.
>>
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> ---
>>
>>  arch/arm/boot/dts/tegra124-apalis-eval.dts |  6 ++----
>>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 11 +----------
>>  2 files changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts
>b/arch/arm/boot/dts/tegra124-apalis-eval.dts
>> index f1010cefb993..a6ad759dddb4 100644
>> --- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
>> +++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Copyright 2016 Toradex AG
>> + * Copyright 2016-2018 Toradex AG
>>   *
>>   * This file is dual-licensed: you can use it either under the terms
>>   * of the GPL or the X11 license, at your option. Note that this
>dual
>
>Since you are fixing copyrights, would you consider also fixing the
>license to use a proper SPDX Id instead?
>
>It would be super gentle of you!
>
>And you will get extra good karma point if you feel like doing the
>same for every Toradex-copyrighted files ;)
>
>The (still new and fresh) license documentation contributed by tglx
>--the only real-time docu-mentalist-- is in:
>Documentation/process/license-rules.rst
>
>Thanks!

Yes, I'm already in the process of preparing a separate patch set fixing this across all Toradex files. However I'm running this through our legal as well first to make absolutely sure it's all proper.

Thanks!
