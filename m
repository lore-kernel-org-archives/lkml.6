Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeDPQOm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:14:42 -0400
Received: from sauhun.de ([88.99.104.3]:49230 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeDPQOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:14:39 -0400
Date: Mon, 16 Apr 2018 18:14:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: renesas: replace toshiba,mmc-wrprotect-disable
 with disable-wp
Message-ID: <20180416161435.g7na5yk2v2e2y633@ninjato>
References: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6q5tvrnjeljvmcmh"
Content-Disposition: inline
In-Reply-To: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6q5tvrnjeljvmcmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 12:02:32AM +0900, Masahiro Yamada wrote:
> Follow up commit 788778b0d21a ("mmc: tmio: deprecate "toshiba,
> mmc-wrprotect-disable" DT property").
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--6q5tvrnjeljvmcmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrUy+sACgkQFA3kzBSg
KbZoBRAAqTX6Vs6Rq7RTzKSr0G+5l+LZQmEeorV/p3RuvxU+PdfGSqMbJfBWwPis
pJ8jTyUslLPz+dKHmyKWkejKtHTNwcz8rIDW1xGyXJEGEeuqnF1kOyddpacS8Q2c
6N8nXpkAe5/8Gh7fWd15nWG1wBQ0LnNZEWRNn0Nnw3ZqxPDv2GeBZogO3+5ueQUu
65IxptFIPz6k9hKDaIopsf1lJRiIXoTFty/Vw4Y2O1gLAA6sakcEskCi86UhwI2N
q9y86LL8E+mXD16EWMmEqsB/m97RIoRxXzJhr9WxwSU7ond88FJZkaJ72Ay2jUcg
VbUZ97A77kLOY0RisXzDS9btdKsNMBqs7qINiPsN4ZXRE4xd56tx+uxmZsdrAuYr
HUFXURET6T/p8t3YAtjDP9gDXjKflrD0Jol3XlpAmOJwbB/PXjYTemkIYtmU+CzY
YuwZnYGg0wqB4dodSsm6CBC6NtxB19cgNvDPoSuXHX4PH84SVKh/d155EoMbAheS
A+01obX4SdBCBYtA1HNkqMsvLC+QHJKdk2afOWHdLJakQ70LRG52rzCxa6BuGRPp
t+W60ztaDBK8h8k05vrbQsmIDhpbVnZYwMSXBxXh/S9OFvOgu8nfTtu+RfMbHtYL
udn+1x+d45gPssKOIDhXeclh7T1CJbufUNpFFgV8x+sZWKEmwr0=
=d5X2
-----END PGP SIGNATURE-----

--6q5tvrnjeljvmcmh--
