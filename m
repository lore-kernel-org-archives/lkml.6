Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDRJSe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:18:34 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39919 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDRJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:18:31 -0400
X-Google-Smtp-Source: AB8JxZqZRgFUXbrtxXGSy2ndyJ2DJ4QKj5PavT86qAErkXV5w0BMa714YFAtTK5x0P/Rt92gGcfc4G+fcCVkLullEgs=
MIME-Version: 1.0
In-Reply-To: <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5@epcas2p2.samsung.com>
 <20180405095000.9756-29-enric.balletbo@collabora.com> <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
 <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 18 Apr 2018 11:18:30 +0200
Message-ID: <CAFqH_51tQ66=oKb0ZhiicRicMd4_zN415tzhHc7X6SUTgg9mFA@mail.gmail.com>
Subject: Re: [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
To: Tomasz Figa <tfiga@chromium.org>
Cc: a.hajda@samsung.com, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Yakir Yang <ykk@rock-chips.com>, kernel@collabora.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        rydberg@bitmath.org, Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Caesar Wang <wxt@rock-chips.com>, Jeffy <jeffy.chen@rock-chips.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mark yao <mark.yao@rock-chips.com>,
        =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>, Jingoo Han <jingoohan1@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kuankuan.y@gmail.com, Haixia Shi <hshi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej, Tomasz

2018-04-16 15:12 GMT+02:00 Tomasz Figa <tfiga@chromium.org>:
> Hi Andrzej,
>
> On Mon, Apr 16, 2018 at 6:57 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>> On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
>> > From: Tomasz Figa <tfiga@chromium.org>
>> >
>> > It looks like the driver subsystem detaches devices from power domains
>> > at shutdown without consent of the drivers.
>
>> It looks bit strange. Could you elaborate more on it. Could you show the
>> code performing the detach?
>
> It not only looks strange, but it is strange. The code was present in 4.4:
>
> https://elixir.bootlin.com/linux/v4.4.128/source/drivers/base/platform.c#L553
>
> but was apparently removed in 4.5:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/base/platform.c?h=next-20180416&id=2d30bb0b3889adf09b342722b2ce596c0763bc93
>
> So we might not need this patch anymore.
>

Right, seems that we don't need this patch anymore, I'll do more few
tests and likely remove this patch from this series. Thanks for
catching this.

Best regards,
  Enric

> Best regards,
> Tomasz
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
