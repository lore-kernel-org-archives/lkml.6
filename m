Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DDCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62005208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62005208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeH1Lhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:37:47 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:58918 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH1Lhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:37:47 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.204])
        by regular1.263xmail.com (Postfix) with ESMTP id 6C379403;
        Tue, 28 Aug 2018 15:47:21 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.10.60] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id EBFC7399;
        Tue, 28 Aug 2018 15:47:14 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <2101aedacd5fe366a2a688ba1025f484>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.10.60] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 218206KC8MU;
        Tue, 28 Aug 2018 15:47:17 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/rockchip: fix coding style and incorrect description
References: <1535351378-128643-1-git-send-email-hjc@rock-chips.com>
 <CAFqH_514pyvKTNHYM=wDab6yAPB+cDCNy8shHPpOP5aeLkyafg@mail.gmail.com>
Message-ID: <ec6f41f5-dc3f-0c5f-e2d4-22e12e8d7e39@rock-chips.com>
Date:   Tue, 28 Aug 2018 15:47:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqH_514pyvKTNHYM=wDab6yAPB+cDCNy8shHPpOP5aeLkyafg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi enric,
     thanks, this will be upated at v2 patch.

在 2018/8/27 15:02, Enric Balletbo Serra 写道:
> Hi Sandy,
>
> Just noticed a typo that I think will be good fix also
> Missatge de Sandy Huang <hjc@rock-chips.com> del dia dl., 27 d’ag.
> 2018 a les 8:31:
> >
> > Align with other drivers, tab + 2 space key for description.
> > and this option should be enabled on both rk3288 and rk3399.
> >
> > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > ---
> >   drivers/gpu/drm/rockchip/Kconfig | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> > index 0ccc762..601234b 100644
> > --- a/drivers/gpu/drm/rockchip/Kconfig
> > +++ b/drivers/gpu/drm/rockchip/Kconfig
> > @@ -45,10 +45,10 @@ config ROCKCHIP_DW_HDMI
> >   config ROCKCHIP_DW_MIPI_DSI
> >          bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
> >          help
> > -        This selects support for Rockchip SoC specific extensions
> > -        for the Synopsys DesignWare HDMI driver. If you want to
> > -        enable MIPI DSI on RK3288 based SoC, you should selet this
> > -        option.
> > +         This selects support for Rockchip SoC specific extensions
> > +         for the Synopsys DesignWare HDMI driver. If you want to
> > +         enable MIPI DSI on RK3288 or RK3399 based SoC, you should
> > +         selet this option.
>
> s/selet/select/
>
> Cheers,
>   Enric
>
> >
> >   config ROCKCHIP_INNO_HDMI
> >          bool "Rockchip specific extensions for Innosilicon HDMI"
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>


