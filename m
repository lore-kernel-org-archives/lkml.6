Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D6CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F5E2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeLQWWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:22:42 -0500
Received: from sauhun.de ([88.99.104.3]:41536 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbeLQWWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:22:41 -0500
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
        by pokefinder.org (Postfix) with ESMTPSA id AB4622E3656;
        Mon, 17 Dec 2018 23:22:39 +0100 (CET)
Date:   Mon, 17 Dec 2018 23:22:39 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Message-ID: <20181217222239.djwackpdkn7dv4qe@ninjato>
References: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6vw7cy44rgrxdwoz"
Content-Disposition: inline
In-Reply-To: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vw7cy44rgrxdwoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 08:41:47AM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>=20

Applied to for-next, thanks!


--6vw7cy44rgrxdwoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYIa8ACgkQFA3kzBSg
KbaR+A/6A5sIJpSrElqX8AP/F1lKn7uOpQHbkFXBAWi1Vo4w1CELOe1ipxqlPk5+
kIJyjN5Ud9gm8C2fiesUlSDJCeysIoh+k5RjWQIjHzh7LLuY2t1ex7M2O7VfePL0
5LtvBgFHNVNu1yohnpRV4+X/SDlN4AH4DYIjk8x1yef6NNhIHH9Fj0HsXA7BgMVa
g7uZ2Ar9+z7vLYaNCzpN8lwz+AbD3mb4ZX/2TrGUgn8iymFq9PfTTYVQCX3YisuP
LBcrUhPgNQm6TAkSwywY+ZbwQbhRA+dbJ56gIzxGFxMT9RzObFJnRC5gOJvN/7Wq
8P73MzTs9OHrz1hqI20z1AZd1DAl50TyS71UltWKq0ZsHmiTZ0MdWHZeeTlj2/Hg
/utqaz736vZJM+3ae3PpBH8y49G9IutVtfiHUE2CiZW84c8a861ncgSMBcHvSsZ6
vdZjGthnRd3abjdcYpD9zOHiCRzgUkMoAy8JonlKSpDPnTQBTSsEBuaSp9eezE/+
XJ2miCkoXpNzNQZeQYFbEIYUmLRsLJTxqnjPy25FfQkUAiBogRXCy67WWVr1llbz
MjFi7BgzLuAKFrZRTPLhErhNEbb0e6G12624L6rH3MkhUmq0/bP4omx8euOy8/jA
yd06dha4rR750DgIVXCZbSWAaVk8w0B5Oe2uOVyc9AaMWc+VkrU=
=lbQT
-----END PGP SIGNATURE-----

--6vw7cy44rgrxdwoz--
