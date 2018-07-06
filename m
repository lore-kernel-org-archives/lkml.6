Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0423C9B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB0423C9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeGFLcG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:32:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeGFLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:32:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9C3BF263B44
Date:   Fri, 6 Jul 2018 13:32:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: tps65217: Switch to SPDX identifier.
Message-ID: <20180706113201.4p2sej3kpimrg6t3@earth.universe>
References: <20180605100021.3789-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clunkcce4e4i2qx3"
Content-Disposition: inline
In-Reply-To: <20180605100021.3789-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--clunkcce4e4i2qx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 05, 2018 at 12:00:21PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

--clunkcce4e4i2qx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/UzEACgkQ2O7X88g7
+pp3kg/8D2boLqxvVX7Qthsp7VH45/GSEyk6/Bavy4baeO4J65JAEsLItzlTrgTp
dcQymHZexZORa75HXjRCEywRh9jv646j6joRTIKpGFJhxI7RKoBe3ttcLZVV7PFd
Mjul1WB+5Lcp2k3Omtm5nQUECIxNhlBRr3Q+/XVsIVxSTgq9InhsnlcFh+jlarUO
9+Q/ScuQ7jBOqzBiNBVkudl1s7mS2+vxDDj6SLnRfHl7jCTX4PrwwAjBqvCWrluv
asdVvOVq6O0j9GFoOnOtW7Ka1hye32HfbE8e+w0LStOfaYHzBWgoms8dFJmRPLVv
uDs9qUu4KTv7RQWYLL/oQ1FB9iu+ZY/CRwpniwT0n/vysWc3ecoEOZtgBt2B9fhy
KM04zOuyff/gOIGyGGy8E3LIv2tDTfujaYlAbsX6uIwCahBRteK6QlAZPwsFuj6H
GucPCwn1uHkUGoTQ8SoThwjCFnKP0/EzIlplxZJ/trxza6802r7AChP+W+qHpElJ
AVJgit6Llgwu+I60OetgCjxv/kG6YG5SqyV+Zdzu13cMqTHFB0feulk1B9A3MR+C
4GoKWhW0HTz/Xhiht1IqFQ2vCgd17pHgzr9Nm7U9wJomfLVRNAzWNjxHEh0sUlFV
vxcEoWzONfjNBcLZ27eXxsFj6Aq2XN7vPBwXTpW5EVnH4kz7VJU=
=/NuL
-----END PGP SIGNATURE-----

--clunkcce4e4i2qx3--
