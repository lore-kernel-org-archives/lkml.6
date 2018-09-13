Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E98C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C673206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C673206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeIMOpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:45:44 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56479 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeIMOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:45:44 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9E323FF806;
        Thu, 13 Sep 2018 09:37:01 +0000 (UTC)
Date:   Thu, 13 Sep 2018 11:37:00 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kbingham@kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] MAINTAINERS: rcar-du: Add co-maintainer
Message-ID: <20180913093700.GZ28160@w540>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWT/WNRdoJORH3Bm"
Content-Disposition: inline
In-Reply-To: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWT/WNRdoJORH3Bm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Kieran, Laurent

On Mon, Aug 06, 2018 at 03:39:01PM +0100, Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> Add myself as a co-maintainer for the Renesas DRM drivers.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cebd5bba8a8..c7cecb9201b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4764,6 +4764,7 @@ F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>
>  DRM DRIVERS FOR RENESAS
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-renesas-soc@vger.kernel.org
>  T:	git git://linuxtv.org/pinchartl/fbdev

Am I wrong or this git repository isn't actual anymore for DU?

> --
> 2.17.1
>

--pWT/WNRdoJORH3Bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbmi+7AAoJEHI0Bo8WoVY8FO4P/2nYQQeiNOwV5u+Gcsg5qmDW
SMwiBIOnYKakvPMFd9r53qkFRuLQBBL/LQUuniR9XJkkYKxOakW3XjrzkAAp9Aw7
u59m0E5AAQ51Mj4b70WITctpJBuR8Pbb3no0If+iSNejg5wnc1O25S3kRipeJUDn
3ynzUYqw0uFYtYPGPb8/fxDNTfOahVsU4QUh3SGduVzKrwojcaC2MXweabAVN082
uyq0874XfvItoMEc7u7SK4ON7VFGVHMlREGzv9yPJ0jIF7v/Sl278U9rPey6K3Jw
Adatg9XvCpp2R+fau8xeAPbS2tLy9qdsDecMjqHarle83W4A7JlI55h3reCxcION
s6akr5e4bzSe9EUZNr2oZtIfe+sC7TmIAw1psMqp0TMTrDzou9cTFVAf2XLdZ+ts
C03VNlWL8QOt++fdiaHPmd9odnl2VY/cVsdJhUA9JiokFW+ecxUfrF7fOIxmh0jn
hXwTeeFl+oaxn3Bfrb7A++d+1f4FrQekfce1UmKBqD2gdIl+DiVTP8J/44JTQ4ae
BzGITPcr8gAyhwRSSTcyHlj3F2KrorhqqfX7VM5kpQsintDw+VjwKGDk+mzKts9h
2IaxZOdoudBHHPUe5Mpgl+JVEdW5SqDD2TpSX/jbR2b0dzWK0SaIa5Kxe7RWlrTU
2Gy0cz9a267LHE7ylH5K
=oxN4
-----END PGP SIGNATURE-----

--pWT/WNRdoJORH3Bm--
