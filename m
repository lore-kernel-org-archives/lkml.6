Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97538C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5922C20C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5922C20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeHTPVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:21:17 -0400
Received: from sauhun.de ([88.99.104.3]:58858 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbeHTPVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:21:17 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id 6C3282D48C2;
        Mon, 20 Aug 2018 14:05:54 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:05:54 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774a1 support
Message-ID: <20180820120553.ch3bu5xqaetevg5c@ninjato>
References: <1534249988-15635-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kzlhsmoaul2vbg3q"
Content-Disposition: inline
In-Reply-To: <1534249988-15635-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzlhsmoaul2vbg3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 01:33:08PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Applied to for-next, thanks!


--kzlhsmoaul2vbg3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6rqEACgkQFA3kzBSg
KbbGTxAAikahaDNtHBJdm1lcsEqDCd7H0OvzHU03kTHjb22ACWAiaxVoUpcBcD1O
vcxBDUIuSOuUZ7CLdrjPLBYY+PEpw40UTNRH+QKLLeH1eZpTVrBLxY8RGnjJ/seY
Fjl3ZrOMV+P1MBzlYjW/O2XXRdDzVvAMHMH3cAkbfeM09o7P50WZYU7tbi3FAjJO
uuQBMTn+A6nm3/rSzl5H/BsvJ9sflyOW+evrOWBgqn9YgVONePVOEbSiNRFDO6Bo
zXXVZuYJnOgb2Mxxcr3BSpwC6R9OwY/07QFCYAidDPSG3jkcgUhW3o2h0T7ZnGJ8
Xk2IpqRIj1LQrpDjvNgIdFxTNU5hdYCZT9M38nb9TuCBJFILxvcgjyrCp8tHS21q
qhNwREosFOLb1A+RQK/P3tSegznGuUP5JyBMqfqMK7NDsqlYa4FlITwgKUk5THnW
5EjS0NioLf08Se4Nq2cJej55B00GStqBPvDfEXALeNVrV7qGw4ta1rsY4dUG3T7G
POnLAVn0cD0YhBhwQy5agfFnbFM4DztC30e/WIX+5KKt6A2ek/fLuXXUGPoCgYAr
LoGfDnhvNU6wO9LwCuSHPC8PsYAKsL8oW1yf8OGfqBD3jG7zRxtCTvDbFwe7W97Y
11Arc3AvaqVFOhBWlaGd4pNxi9kDVYjDUM1JhnFmHPZWPh3iBXs=
=Rd/P
-----END PGP SIGNATURE-----

--kzlhsmoaul2vbg3q--
