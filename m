Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B330C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E30920848
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E30920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJ2HUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:20:53 -0400
Received: from sauhun.de ([88.99.104.3]:58212 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJ2HUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:20:53 -0400
Received: from localhost (unknown [87.113.172.131])
        by pokefinder.org (Postfix) with ESMTPSA id A5E1D4A1CA7;
        Sun, 28 Oct 2018 23:34:50 +0100 (CET)
Date:   Sun, 28 Oct 2018 22:34:50 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Message-ID: <20181028223450.GK1882@kunai>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Content-Disposition: inline
In-Reply-To: <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2018 at 01:23:40PM +0530, Vignesh R wrote:
>=20
>=20
> On 28-Sep-18 10:55 AM, Vignesh R wrote:
> > Couple of patches to enable i2c-omap driver to be used with TI's new
> > AM654 platforms.
> >=20
> >=20
> > Vignesh R (2):
> >   dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
> >   i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
> >=20
> >  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
> >  drivers/i2c/busses/Kconfig                         | 2 +-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >=20
>=20
> Gentle ping...

Maintainer tags are missing. Tony is listed for this driver on OMAP2+.
Is this his realm? Do we need a specific maintainer for this driver?


--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWOYkACgkQFA3kzBSg
KbYIFBAAqCLZ65V0I5GPyJjznioZ2Fw/6JUr+Wn1LrqT3chwhG67zkJcTlxP3mxE
2PommoAQUO0/thFaRkHEfZoC/JfqxhtgLlqdWU+SlVUXw3gt2FJ07eJ9KdAL60/w
wqrHz0UmXhz8PqqRY5R24lgcJYqMSSi6tiq+SiRvb4iFwJPTj0giismR0iS6wDT+
no+1XlB43WfZBYJ3Aj0gAdGID5+DtxkLjuy+/+NEhP9KLWpZYjVOJ9GgfNGZkeDJ
rp4Rd+ONT9xf3/00Y7EpruPsXyhLN4/TcYIjJrk9jpme7RtHjnZVrVWcsT0bKMYl
st8dLJBAD0MeBDAsPOUV0tw36aSV/ttyZDP+kl5BswFbFZ9OKhtvQggyHezDU2eh
C7S1f8goOOK71qkHMmT0ZZ4nTXm84vIqS/8PqTQt9SAfkHBzBUwCr+Qo8EMHkrDp
6Dya/Gwe4E5oEqNdc26KrrBqWiZVYzttIcfjVEV5GzKhQyzfBXDBWAoKZS7kyxeV
yVZb/QFCH+0LB5aNiuc2HRI5XXze8WwpCJmU1zcg/yi2UT2LAE1XbIfeV0vat6q6
osQFXAUScydV0/cy93bxarnpxYIRPezTJRWvWj/qaHF+Ev3lQ2lW3CBfy0MboiOE
ZY1ZwYrroAIpgWxDNLhV4hshBJNkDmMqX+p3ThocSB328PT5AOc=
=0lwQ
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--
