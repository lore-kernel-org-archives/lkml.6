Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E7AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B04E21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vohUJHGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B04E21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeHBMIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:08:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeHBMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r8FOyH64w9ZNYWywPsjFBJhYLx3765SYJttn3f+ph3g=; b=vohUJHGeang+hnjD/mpKoWHV0
        mWmMyqSwpn4gqgIm1rXoB4XDugL2uNLkbb60UwRsjHjGiGvCGGiUWUvj7LPXxlYuow9voTvgQJavQ
        gsBzlwtJJ7Xjs/Z5FU9zggrp/F9+la5f0HlG1qF5Fdw3GHirsGUYmh75MRICWw5MnOr9k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flAfu-0001sw-R7; Thu, 02 Aug 2018 10:17:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8A3C911242E7; Thu,  2 Aug 2018 11:17:42 +0100 (BST)
Date:   Thu, 2 Aug 2018 11:17:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180802101742.GF9117@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk>
 <20180801215733.4dfa3a95@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <20180801215733.4dfa3a95@bbrezillon>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 09:57:33PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> 2/ Getting this patch [1] merged and implementing the ->get_name() hook
>    in this driver so that SPI NOR devs declared to the MTD layer keep
>    the same name after the transition to spi-mem and mtdparts=3D passed on
>    the cmdline keep working. Without this in place we're likely to
>    break a few setups :-/.

> [1]https://patchwork.kernel.org/patch/10508693/=20

I don't seem to have a copy of this patch...  not sure it was sent to
me?

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti2kUACgkQJNaLcl1U
h9BcOAgAgAz5lMpc2flvBJhdnlT29tzROXqSpM6wz1kpJM0vXKIBnD1f+CVqWg5x
isd9zCSCYinC8A8qNtC8KeRZNWDWsuSc0oiizuFp8G5Nf/ep6iIoxlKV8FMwmOVm
DITz7SZUqd/Ej1peuGNsE3/3dGd2sT0TKnjrrJT7ZjAjfH4OwfWkUS9lshgp0H+y
l7HDz5Z5JAmEkkCbe97AHnZQv0jths9imXVpaAJJl6uYRkxM3zIAp6vRKf71MSSz
ubaV2h3gejoYUviXa6zp4+o373AwNwSV/2JSV93wt4ogLkuECl3PMTzm74d+jlJq
vRr2BQqeV9RkMdcDJmrV27AxH4TvsA==
=R9Tx
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
