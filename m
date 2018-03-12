Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeCLCOr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 22:14:47 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41946 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbeCLCOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 22:14:45 -0400
X-Google-Smtp-Source: AG47ELtFLdGsgNE7/YT6LonTViYh7RACpjhHx2nhXHFng0AF0IFruUwDaU3So/eANuGJHBQaaW0LF6kcMcza0dg+5w4=
MIME-Version: 1.0
In-Reply-To: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
References: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 11 Mar 2018 19:14:42 -0700
X-Google-Sender-Auth: 0Pai4-UiBDgUBvereWBpf41gzI4
Message-ID: <CAD=FV=VG0CSaLGyyfHAdvn4Ud0D3tab0c3pMEvqcFxAJ+5c7Zg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: assign clock rate for ACLK_VIO
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 11, 2018 at 6:50 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> The ACLK_VIO is a parent clock used by a several children,
> its suggested clock rate is 400MHz. Right now it gets 400MHz
> because it sources from CPLL(800M) and divides by 2 after reset.
> It's good not to rely on default values like this, so let's
> explicitly set it.
> NOTE: it's expected that at least one board may override cru node and
> set the CPLL to 1.6 GHz. On that board it will be very important to be
> explicit about aclk-vio being 400 MHz.
>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 6 ++++--
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi     | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
