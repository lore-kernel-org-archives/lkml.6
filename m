Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeBRKvV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 05:51:21 -0500
Received: from gloria.sntech.de ([95.129.55.99]:37308 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeBRKvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 05:51:20 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yakir Yang <ykk@rock-chips.com>,
        =?ISO-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
Subject: Re: [PATCH v3 02/43] drm/rockchip: support prime import sg table
Date: Sun, 18 Feb 2018 11:51:04 +0100
Message-ID: <5656532.R6xNvaMjTF@phil>
In-Reply-To: <20180130202913.28724-3-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com> <20180130202913.28724-3-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Januar 2018, 21:28:32 CET schrieb Thierry Escande:
> From: Haixia Shi <hshi@chromium.org>
> 
> The prime fd to handle ioctl was not used with rockchip before. Support
> was added in order to pass graphics_Gbm and to support potential uses
> within Chrome OS (e.g. zero-copy video decode, camera).
> 
> Signed-off-by: Haixia Shi <hshi@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

applied to drm-misc


Thanks
Heiko
