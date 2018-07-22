Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E96C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E3820854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E3820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeGVXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:15:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbeGVXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:15:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E231026BA64
Date:   Mon, 23 Jul 2018 00:17:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max77693_charger: fix unintentional
 fall-through
Message-ID: <20180722221717.fgx6nzljnfrw3d5a@earth.universe>
References: <20180717214739.GA19410@embeddedor.com>
 <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msgxhjy6fxkewk3c"
Content-Disposition: inline
In-Reply-To: <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--msgxhjy6fxkewk3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 18, 2018 at 08:14:50AM +0200, Krzysztof Kozlowski wrote:
> On 17 July 2018 at 23:47, Gustavo A. R. Silva <gustavo@embeddedor.com> wr=
ote:
> > It seems that a *break* is missing in order to avoid a fall-through.
> > Otherwise, the calculation of *data* makes no sense.
> >
> > Addresses-Coverity-ID: 1271172 ("Missing break in switch")
> > Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 776=
93")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/power/supply/max77693_charger.c | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued to power-supply's fixes branch.

-- Sebastian

--msgxhjy6fxkewk3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltVAmwACgkQ2O7X88g7
+pptaA/+OESU5zKYOrJ05RlVn2tQKdpdZEXcdc5FTsi02KRMvfQfkJ2LGLDxbRl1
mmRa16jmPpKlpT2rMK4C6+9bu8olUT/BjEe14OCuwknhGQpaSooRPNTez2ihahu0
UPNkqTXerRy7P4CsmVst9O4QOVL8p56qpF5MHAgsVUh2HdprlM5BjaVofqPA5CV3
g8JbTWMFcDycSvQdbfgwYtzN66vUs6kRPY5doQ8IMk0qM+euk90edm/rQExeYYmz
Q8+ZqZVeK9bYrbVYrFu4FYKzaIVA2pbjMCRF6RjNO5kdQIqjNvLuEvgXIMqqfLO/
aHhHqNlxmoAU9VD23hRAROnYS/05z4iDhbIkckTRFiOgI2UTGiUsRw3chT0c/ZRY
yYQuAy3g+WCc/ZP2Exj+rUs5SMOO+O0PtTMhkm/klls1emQrs4lSiJ7PU2d5Z2AR
58oxEh9EzIVCoNEqkRL4yGbZcRAIyRq2pPAhznxEscD5HV1fImgD3Ndd+x5KWkbl
bRi1VtGOg5y0tGFY5YTqOGXzshOcevolPgg6pBhYuV5bWXt/foPqKiiVuLsGDfQJ
at2K+Gnd3zkZcYWHxBAww3JIo8AtdGheaY7wgQi89Q5TYJry2AF4xgmCBgj0doNc
MQABf4w3RKc+dE0mbHKKAHfe5stF8HOFIk29UHiHvaonkenAbxI=
=9hbD
-----END PGP SIGNATURE-----

--msgxhjy6fxkewk3c--
