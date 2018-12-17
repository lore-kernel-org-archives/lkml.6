Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574682133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbeLQWYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:24:13 -0500
Received: from sauhun.de ([88.99.104.3]:41594 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbeLQWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:24:13 -0500
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
        by pokefinder.org (Postfix) with ESMTPSA id 668CA2E3656;
        Mon, 17 Dec 2018 23:24:11 +0100 (CET)
Date:   Mon, 17 Dec 2018 23:24:11 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Message-ID: <20181217222410.dfy2them2skvlnuw@ninjato>
References: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7dt2z4ll2efnf3bx"
Content-Disposition: inline
In-Reply-To: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7dt2z4ll2efnf3bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 08:19:02PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) I2C compatibility with the relevant driver
> dt-bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Fixed the typo in the commit message and applied to for-next, thanks!



--7dt2z4ll2efnf3bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYIgoACgkQFA3kzBSg
KbaWSQ/+LbpQI8hOr1Zwos9aH3AL4C/xMnhpg1VIG7cLc82/YpBoHeK9hS2UmWzl
jGa4SQLjKKyJfxNKEuhado5zqHCZD1r8VpYvK4BuEsNdPC/lyYsC9XGr9fpMdRhu
OXjiur9a1A80rRLPvvsvqYeAK4GEdhD30IKYkOwe9PjofEZJ5RP34c/7v0DY7UrJ
WfE3NCohBcF6DWAqNa/qonTVHJgAsrktj9AqGqYUoUCAdsDqHgp3SumOo59HQXpD
9i9ctinI1J3SXjvdV+MJ08z5tGMJShYywGlhOEeP6jeQtix/OUov6M4Rq09ZBXoH
n9KtXNFbLJ3AkUUjT+KxiXLKBpNFqHY4bxVeitYooGAIB+pxEc+i4BOCL4LMtTIN
Q4AhFbeeQFxcrAAftwUiQG+QiGx7pn4IDiMa1njQ7DyPNw8MoJsDKfUjNF2bE/Tf
3uGvTZwk2baXCLCnDMNyxcJSo9zrTqdZfspLdX5y1Ql4JVgYx07wrhpDlCFWoOI2
KDckCMpXHuK0xsacs68MfuPrbD6eErgwjt9MJzEmllAOdJ74SNpj3nUIF/C3HiS4
qoNcXKsygZPYbtPgUaKJPZzVDoAuGgmAV7dzb++1wp8apztwFMQdysn66eS+t3tv
FkZQbdTQ3LDQfUbAGj83RjK+kt3WIZXS72Gd/0nuizU4IshRHi0=
=G+Yq
-----END PGP SIGNATURE-----

--7dt2z4ll2efnf3bx--
