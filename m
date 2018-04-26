Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755818AbeDZMQJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:16:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46778 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755172AbeDZMQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:16:05 -0400
Date: Thu, 26 Apr 2018 14:15:59 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, brodkin@synopsys.com,
        linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        l.stach@pengutronix.de, christian.gmeiner@gmail.com,
        inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        stefan@agner.ch, alison.wang@freescale.com,
        z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, p.zabel@pengutronix.de, ck.hu@mediatek.com,
        matthias.bgg@gmail.com, robdclark@gmail.com, marex@denx.de,
        bskeggs@redhat.com, tomi.valkeinen@ti.com, eric@anholt.net,
        airlied@redhat.com, kraxel@redhat.com,
        laurent.pinchart@ideasonboard.com, hjc@rock-chips.com, heiko@sntech.de,
        benjamin.gaignard@linaro.org, vincent.abriou@st.com,
        yannick.fertre@st.com, philippe.cornu@st.com,
        maxime.ripard@bootlin.com, wens@csie.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, noralf@tronnes.org, linus.walleij@linaro.org,
        shawnguo@kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, etnaviv@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Message-ID: <20180426141559.6811127b@bbrezillon>
In-Reply-To: <20180426102819.6985-1-vthakkar1994@gmail.com>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 15:58:19 +0530
Vaishali Thakkar <vthakkar1994@gmail.com> wrote:

> It's been a while since we introduced drm_dev{get/put} functions
> to replace reference/unreference in drm subsystem for the
> consistency purpose. So, with this patch, let's just replace
> all current use cases of drm_dev_unref() with drm_dev_put and remove
> the function itself.
> 
> Coccinelle was used for mass-patching.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 ++--
>  drivers/gpu/drm/arc/arcpgu_drv.c                   |  4 ++--
>  drivers/gpu/drm/armada/armada_drv.c                |  6 +++---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  4 ++--

For atmel-hlcdc:

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
