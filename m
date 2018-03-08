Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeCHWoo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:44:44 -0500
Received: from gloria.sntech.de ([95.129.55.99]:34128 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeCHWon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:44:43 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, hshi@chromium.org, wzz@rock-chips.com,
        hl@rock-chips.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        linux-rockchip@lists.infradead.org, orjan.eide@arm.com,
        m.szyprowski@samsung.com, Caesar Wang <wxt@rock-chips.com>,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: Re: [PATCH v4 02/38] drm/rockchip: Don't use atomic constructs for psr
Date: Thu, 08 Mar 2018 23:44:38 +0100
Message-ID: <3403715.fyf8cBQUvz@phil>
In-Reply-To: <20180305222324.5872-3-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com> <20180305222324.5872-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. März 2018, 23:22:54 CET schrieb Enric Balletbo i Serra:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Instead of using timer and spinlocks, use delayed_work and
> mutexes for rockchip psr. This allows us to make blocking
> calls when enabling/disabling psr (which is sort of important
> given we're talking over dpcd to the display).
> 
> Cc: Caesar Wang <wxt@rock-chips.com>
> Cc: 征增 王 <wzz@rock-chips.com>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next after
checking on both pinky (rk3288) and kevin (rk3399).


Heiko
