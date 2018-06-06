Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AD9660555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=theobroma-systems.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeFFPb4 convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 11:31:56 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:44646 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751914AbeFFPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:31:54 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] arm64: dts: rockchip: Switch to SPDX identifier.
From: klaus.goger@theobroma-systems.com
In-Reply-To: <20180606152109.12359-1-enric.balletbo@collabora.com>
Date: Wed, 6 Jun 2018 17:31:34 +0200
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Simon Xue <xxm@rock-chips.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        David Wu <david.wu@rock-chips.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        William Wu <william.wu@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        devicetree@vger.kernel.org, Pierre-Hugues Husson <phh@phh.me>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Yao <markyao0591@gmail.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DCD2814D-35CD-4856-9479-3A09922586DD@theobroma-systems.com>
References: <20180606152109.12359-1-enric.balletbo@collabora.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

> On 06.06.2018, at 17:21, Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
> Adopt the SPDX license identifier headers to ease license compliance
> management.

[snip]

Heiko merged a similar patch 2 days ago
http://lists.infradead.org/pipermail/linux-rockchip/2018-June/020939.html

Cheers,
Klaus
