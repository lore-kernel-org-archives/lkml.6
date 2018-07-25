Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC1F20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC1F20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeGYFMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:12:00 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:34058 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeGYFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:12:00 -0400
Received: from djw?t-chip.com.cn (unknown [192.168.167.225])
        by regular1.263xmail.com (Postfix) with ESMTP id 6D1581EB;
        Wed, 25 Jul 2018 12:02:13 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 6DB673C8;
        Wed, 25 Jul 2018 12:02:06 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: eballetbo@gmail.com
X-SENDER-IP: 59.33.103.255
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <75037282b54d7b2b28123fe5b4418632>
X-ATTACHMENT-NUM: 0
X-SENDER: djw@t-chip.com.cn
X-DNS-TYPE: 7
Received: from localhost (255.103.33.59.broad.zs.gd.dynamic.163data.com.cn [59.33.103.255])
        by smtp.263.net (Postfix) whith ESMTP id 9001MJF9H3;
        Wed, 25 Jul 2018 12:02:09 +0800 (CST)
From:   djw@t-chip.com.cn
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        djw@t-chip.com.cn, Mark Rutland <mark.rutland@arm.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        zxf@t-chip.com.cn, Masahiro Yamada <yamada.masahiro@socionext.com>,
        ezequiel@collabora.com, xypron.glpk@gmx.de,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list\:ARM\/Rockchip SoC..." 
        <linux-rockchip@lists.infradead.org>, jacob-chen@iotwrt.com,
        klaus.goger@theobroma-systems.com, jagan@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        jay.xu@rock-chips.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v0] arm64: dts: rockchip: add support for ROC-RK3399-PC board
References: <1532161826-2537-1-git-send-email-djw@t-chip.com.cn>
        <139327780.KNaNigg5Hs@phil>
        <CAFqH_52baP9yt35yfAdU5wk8DiK67_etPALsmb5K1JPmnW_kqQ@mail.gmail.com>
Date:   Wed, 25 Jul 2018 12:01:43 +0800
In-Reply-To: <CAFqH_52baP9yt35yfAdU5wk8DiK67_etPALsmb5K1JPmnW_kqQ@mail.gmail.com>
        (Enric Balletbo Serra's message of "Tue, 24 Jul 2018 11:53:40 +0200")
Message-ID: <87effsgdzs.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric Balletbo Serra <eballetbo@gmail.com> writes:

> Hi Levin,
>
> Missatge de Heiko Stuebner <heiko@sntech.de> del dia dt., 24 de jul.
> 2018 a les 11:29:
>>
>> Hi Levin,
>>
>> Am Samstag, 21. Juli 2018, 10:30:26 CEST schrieb djw@t-chip.com.cn:
>> > From: Levin Du <djw@t-chip.com.cn>
>> >
>> > ROC-RK3399-PC is the first power efficient 4GB DDR4 single board
>>
>> maybe "is a power efficient" instead of "the first" ;-)
>>
>> [...]
>>
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> > new file mode 100644
>> > index 0000000..207f2e3
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> > @@ -0,0 +1,717 @@
>> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> > +/*
>> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
>> > + */
>> > +
>> > +/dts-v1/;
>> > +#include <dt-bindings/pwm/pwm.h>
>> > +#include "rk3399.dtsi"
>> > +#include "rk3399-opp.dtsi"
>> > +
>> > +/ {
>> > +     model = "Firefly ROC-RK3399-PC Board";
>> > +     compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>> > +
>> > +     chosen {
>> > +             bootargs = "earlycon=uart8250,mmio32,0xff1a0000 swiotlb=1";
>>
>> I don't think we want to hard-code linux bootargs in the generic devicetree
>>
>> > +             stdout-path = "serial2:1500000n8";
>> > +     };
>> > +
>> > +     backlight: backlight {
>> > +             compatible = "pwm-backlight";
>> > +             enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
>> > +             pwms = <&pwm0 0 25000 0>;
>> > +             brightness-levels = <
>> > +                       0   1   2   3   4   5   6   7
>>
>> As Rob noted in the px30 evb patch, there is now a property helping
>> to drop these long lists of brightness levels, see
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1e5e7cc794b5a332c23216dade0a2e937d694b7f
>
> Adding to the Heiko information. Did you try to just remove brightness-levels?
> Without this property, the driver computes a default table with the
> brightness levels filled with the numbers provided by the CIE 1931
> algorithm. That algorithm is used to dim a led for human perception.
>
> Note that the patches needed did not land yet, are in linux-next, and
> you will also be interested in apply this patch [1].
>
> [1] https://lkml.org/lkml/2018/7/24/116
>
>
> Best regards,
>  Enric
>

Thanks you for the note, Enric. I'll test that later.

Regards,
Levin

