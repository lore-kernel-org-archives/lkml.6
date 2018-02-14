Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967323AbeBNLN3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:13:29 -0500
Received: from gloria.sntech.de ([95.129.55.99]:41982 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967252AbeBNLN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:13:28 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>,
        kernel@collabora.com
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: enable DP for gru.
Date: Wed, 14 Feb 2018 12:13:19 +0100
Message-ID: <14329289.ZsZsSgLk6a@diego>
In-Reply-To: <20180213143549.15197-3-enric.balletbo@collabora.com>
References: <20180213143549.15197-1-enric.balletbo@collabora.com> <20180213143549.15197-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 13. Februar 2018, 15:35:49 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> Enable cdn_dp and create a cdn-dp-sound for the DP audio. Delete the
> endpoints between dp and vopL for gru, since we want the DP only use
> VOP big, which can support 4K mode.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


applied for 4.17 after dropping the vop-related hacks

The devicetree should only describe the hardware and is generally not meant
to do configuration-related things. Selecting the most suitable vops for any
given combination of outputs should be in the realm of the driver and not
hard-coded in the dt.


Heiko
