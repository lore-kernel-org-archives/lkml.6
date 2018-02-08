Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeBHQqH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:46:07 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:48958 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeBHQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:46:06 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
Date: Thu, 08 Feb 2018 18:46:34 +0200
Message-ID: <101210971.aHjggv2rq0@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180208145805.24762-1-philippe.cornu@st.com>
References: <20180208145805.24762-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Thank you for the patch.

On Thursday, 8 February 2018 16:58:05 EET Philippe Cornu wrote:
> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
> host controller driver.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v2: Update to "GPL-2.0+" following comments from Laurent
> Pinchart, Benjamin Gaignard & Philippe Ombredanne.
> 
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
> 7bac101c285c..99f0e4f51716 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   * Copyright (C) STMicroelectronics SA 2017
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   * Modified by Philippe Cornu <philippe.cornu@st.com>
>   * This generic Synopsys DesignWare MIPI DSI host driver is based on the
>   * Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.


-- 
Regards,

Laurent Pinchart
