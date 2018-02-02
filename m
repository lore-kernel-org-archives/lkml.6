Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBBJT1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:19:27 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:58783 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBBJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:19:23 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, hiroyuki.yokoyama.vx@renesas.com,
        koji.matsuoka.xm@renesas.com, takeshi.kihara.df@renesas.com,
        harunobu.kurokawa.dn@renesas.com, ryusuke.sakato.bx@renesas.com,
        tomoharu.fukawa.eb@renesas.com, kouei.abe.cp@renesas.com,
        khiem.nguyen.xt@renesas.com, hien.dang.eb@renesas.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: lvds: tidyup header explanation
Date: Fri, 02 Feb 2018 11:19:42 +0200
Message-ID: <8341764.3XndS5yTzj@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <874ln1duih.wl%kuninori.morimoto.gx@renesas.com>
References: <redmine.issue-153275.20180201064632@dm.renesas.com> <redmine.issue-153275.20180201064632.405d9bde0f7709a7@dm.renesas.com> <874ln1duih.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

Thank you for your patch.

On Thursday, 1 February 2018 09:45:36 EET Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> panel-lvds.c is for LVDS Panel Driver,
> not R-Car Display Unit CRTCs
> 
> Reported-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

A similar patch has been posted already:

https://patchwork.freedesktop.org/series/36953/

> ---
>  drivers/gpu/drm/panel/panel-lvds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lvds.c
> b/drivers/gpu/drm/panel/panel-lvds.c index b5e3994..c8075a8 100644
> --- a/drivers/gpu/drm/panel/panel-lvds.c
> +++ b/drivers/gpu/drm/panel/panel-lvds.c
> @@ -1,5 +1,5 @@
>  /*
> - * rcar_du_crtc.c  --  R-Car Display Unit CRTCs
> + * panel-lvds.c  --  LVDS Panel Driver
>   *
>   * Copyright (C) 2016 Laurent Pinchart
>   * Copyright (C) 2016 Renesas Electronics Corporation


-- 
Regards,

Laurent Pinchart
