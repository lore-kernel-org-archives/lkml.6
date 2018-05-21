Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeEUIAg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:00:36 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47485 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeEUIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:00:35 -0400
X-Originating-IP: 2.224.242.101
Date: Mon, 21 May 2018 10:00:30 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 17/26] drm/bridge: thc63lvd1024: provide an owner
 .odev device
Message-ID: <20180521080030.GB4432@w540>
References: <20180516101510.13215-1-peda@axentia.se>
 <20180516101510.13215-18-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20180516101510.13215-18-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,

On Wed, May 16, 2018 at 12:15:01PM +0200, Peter Rosin wrote:
> The .of_node member is going away.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

For this specific driver

Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

> ---
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> index c8b9edd5a7f4..4765c9c45aef 100644
> --- a/drivers/gpu/drm/bridge/thc63lvd1024.c
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -167,8 +167,8 @@ static int thc63_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	thc63->bridge.odev = &pdev->dev;
>  	thc63->bridge.driver_private = thc63;
> -	thc63->bridge.of_node = pdev->dev.of_node;
>  	thc63->bridge.funcs = &thc63_bridge_func;
>
>  	drm_bridge_add(&thc63->bridge);
> --
> 2.11.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbAnyeAAoJEHI0Bo8WoVY8VVsQAK/CUrGWGVxadXAPmgZITp0t
EiAszh7gYOvxLraJZk8Uw4XWudTWrL85mam0+B+4vKYFflQGoLVgC5E1j5x3vwDU
suKa2qhuIxLf3OwnSehYmHuxOcGfN2+3PiTYsTrRJRaQlBJXxxoXJbnK9esTlzNP
8mJlP8+TVUlUpZUEMsSTar19xLN8wQ0Vpwb6Os9i4tQgxa3IP497tuOh+P7K6vP/
uZyX88pOnN2gNaFdWSkfAqIlLL0NRv147TD7JOv/r34RhuYDkKUX3AWRdpCvAGsQ
XPSnLsuYau8QfgALxD/h5WoWuOhu0MHqLQCekYBy9HR8XZVQMYI+wrrv++Ra9yPN
+wrRB8sI7hgPOwRVnD1065rQ8+CUgvCx74t4nnB7XqPUzyCPZlig13QKkFAGUWBT
THUwNbhWgHIYPTGT3odDjyEv9flh7I8VGjjKxhhvSJRRTijcew5R9hdW6YLYJ/EQ
LYaeKENQfTq2IyMveUcAKi/qx2NogpZh22nOuedySWRATi7LrLtwp1/hbwB/Fcwu
+/eOkWf6hK7yILJSbX8eQG8rp7ECn/4uS+FGOjJ+EUOBXCa98DBdH4ctMGHdGlK1
S0ajpoo0O9KUhceg/eYpDoUZ24Q1KvfTwxHYz70dFcJbP6WYF7ELsYbbzk0TIDhL
ctcJDnqA6yFY+TUZVYVZ
=cKjF
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
