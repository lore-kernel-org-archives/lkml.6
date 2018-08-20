Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39985C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D911320C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D911320C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeHTPVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:21:08 -0400
Received: from sauhun.de ([88.99.104.3]:58838 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeHTPVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:21:08 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id 971D12D48BA;
        Mon, 20 Aug 2018 14:05:44 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:05:44 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774a1 support
Message-ID: <20180820120544.n32mf5hcziig67ey@ninjato>
References: <1534249975-15588-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3oguvm2jdlcgjoo7"
Content-Disposition: inline
In-Reply-To: <1534249975-15588-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3oguvm2jdlcgjoo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 01:32:55PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) I2C compatibility with the relevant driver
> dt-bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Applied to for-next, thanks!


--3oguvm2jdlcgjoo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6rpEACgkQFA3kzBSg
KbbpcA//aEkYTxgwNKn6XZFiti/Qw3VOFoxdVw7HASemXBSbvOH0DFTXakiMbfqY
gWj8vK9roGm3ELPY++z+RzUz7MKXArl7TGwn6/3wlSogFY0rlg4tonSER81AYenQ
B0akqSurz+swKPSJizsv40BlUcS8ZSJxM8dXcbO8CCtyH/o7eeqnet0MExYu0+Oq
mtQffB0KuvRksflmYBTlhfSz08sBuYIkHtv5nT11NDGyuSxu6yOj1PoPJHW5ltWK
4IK7o7DqjpRRX0n/00Ot6/6p4/LFnagdYfToIRHNZTK182A3PQr4GzvGixWjBbbw
20QpK/eNWrUG6aKqWKYaMVGQjokA2eRttJYv9eOUUPxLTy7ujh0qo41aMCsw+I8V
oBINzC1Sf1/YjsgBEhb4dAT6MqUTFyKt4ZMrqFyv+b6dJqO3NpBURVopyVSET1q6
i4bcP4fK3kbL19yn/dKapUR+kR8ebcIwnIQES78tg93ByOyg1+kjj/2Vh39bB/Ov
y+UNApx27GiO2jI3n48euB2Lgg0eB25+Ag5h04y6xSNStengN9JmAMBEnwGN6KXk
K13fva4rXsFPtkl0fNlMToW6c4a0ItTdJaIy3Tj61nFli6VPN/yqd2s+Jfxma6z7
u4jkg6uV8Js7hknsSkgkGm124vnAIPXd/Vd/42ZV/0PlwINsN7I=
=Jved
-----END PGP SIGNATURE-----

--3oguvm2jdlcgjoo7--
