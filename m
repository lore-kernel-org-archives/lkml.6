Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7984FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE3120879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbeLNQYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:24:02 -0500
Received: from sauhun.de ([88.99.104.3]:45062 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeLNQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:24:01 -0500
Received: from localhost (p54B6730A.dip0.t-ipconnect.de [84.182.115.10])
        by pokefinder.org (Postfix) with ESMTPSA id 6DE064C0E8F;
        Fri, 14 Dec 2018 17:23:59 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:23:58 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0
Message-ID: <20181214162358.GC4236@kunai>
References: <1544732547-7094-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <1544732547-7094-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 08:22:27PM +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
>=20
> We need r8a774c0 to be whitelisted for SDHI to work on the RZ/G2E,
> but we don't care about the revision of the SoC, so just whitelist
> the generic part number.
>=20
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwT2R4ACgkQFA3kzBSg
KbZ1qA/+NS6qfKjAEvNvhXbRSYG/nFdc9P04h0DnBHKuFEEMuDx+hv2EDOuYwd5p
0dJSRU5YF9QoxQA/INbz4Nvb63cWdbHfes41G1L6KlZ7/ohJ2uGp5OonxFm4qbXq
wZSrq/01pYO8dpQg2P7n4Dyirxi0BjPoNYIoWpK4vZSY1c5pTW0zljd/4DcUGBa/
kAigWo2jNE8xLPoRCjksVW/NxpKJwfzQU6bz57OB6SwmEkUkoR9Te+k0PfGiNW2E
W5AJaTVkKqOI9UlnLNjHpv5IY5K386bqsa5JFRMBcA6VFVAGMfExqGla/Xp5um+V
QJONgOdcauAxAUC5Omyd2WC7GVXCC2IgvOkcQMNG8nUA1Jb1DtdZOYTXbO1qQtDC
maEP0sh8GeAs9S72TOVyq12WJpY6guc0hrfwj/d/N9+a7w86Uv+On+gmhTuV0s+H
h0sjvIsb0CArAIBSwP1TGZ3EO1bkWAKpivWcrDcXwhYIBcPmz26UWFb0VHj+88VM
HSoTFrnpa9iHZsrdVZ5c5r9NBLpwve9cBKm++cr6lRM3G+A95TaNPRSnQc+Rium9
OhicYKYmcuDM9SoKaI6WbcrxQ6fNWvcx6GRyK2c2Ch5phD3M8trK5DkVzlaDDPw8
eiE9O2LiJ2fJwN9zOkYv5n3wa1DZpjvBBpaBhcZzypIZbS27VNk=
=Brpm
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
