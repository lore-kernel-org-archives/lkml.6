Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB3C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9268204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9268204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeKDVrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:47:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40635 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeKDVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:47:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 539158092E; Sun,  4 Nov 2018 13:32:35 +0100 (CET)
Date:   Sun, 4 Nov 2018 13:32:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/15] dt-bindings: olpc_battery: Add XO-1.5 battery
Message-ID: <20181104123236.GC23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-11-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="exKAuxcSaZxx4B14"
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-11-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--exKAuxcSaZxx4B14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:55, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rob, can you apply?

Thanks,
								Pavel
> ---
>  Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.=
txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> index c8901b3992d9..8d87d6b35a98 100644
> --- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> @@ -2,4 +2,4 @@ OLPC battery
>  ~~~~~~~~~~~~
> =20
>  Required properties:
> -  - compatible : "olpc,xo1-battery"
> +  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--exKAuxcSaZxx4B14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve5uQACgkQMOfwapXb+vKOOgCgvORUsCnIW67FaO2Fa19FQF6m
GQYAnj3CcS/pyVP4+UBUMA4sAss8/1AK
=deGE
-----END PGP SIGNATURE-----

--exKAuxcSaZxx4B14--
