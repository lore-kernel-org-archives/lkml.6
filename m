Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeBVLIA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:08:00 -0500
Received: from sauhun.de ([88.99.104.3]:48993 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbeBVLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:07:58 -0500
Date: Thu, 22 Feb 2018 12:07:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v5 6/8] i2c: demux: Use changeset helpers for clarity
Message-ID: <20180222110754.snkn7sgy4cyj7kq4@ninjato>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVy9=e5eZZTdV6E=apvHxL3n5Qqob2JE+FsON3RG-JWWg@mail.gmail.com>
 <2195898.2J8Qfnu3DQ@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zchw23fcb7jg5anu"
Content-Disposition: inline
In-Reply-To: <2195898.2J8Qfnu3DQ@avalon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zchw23fcb7jg5anu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Why? ePAPR says "okay", "disabled", "fail", or "fail-sss".
> >=20
> > Sorry for missing this in the previous round.
>=20
> That was per Wolfram's request, and because the existing code uses "ok". =
I'm=20
> personally fine with any.

I did? Well, today I don't have a strong preference. Any is fine with
me, too.


--zchw23fcb7jg5anu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqOpIcACgkQFA3kzBSg
KbY/Lw//Wu6/UUii+3Pppq877QvjFQWj7sOO8l/Qpko2IH5z7CriP+6V8A9NMBeL
CnSfbosoDBCiASIK4HUu+NU4XxtWc2kC3dap8nKfY+mUg+hcLYjkPQyJedkDS/IC
5LsYayvWr6P5rkDBF3fpSfOdkI55T30u5k4N4bZfNjQ8y6kHVFnLJXISQ6HB/feO
nKhWnL9A3Fc4TA9/iibB/qFOb7aQn4SRJy/KyZAIlUAxi3UQPlkRQVzrVXy/l8DM
vdvbonQkJtgJs173LtDmXfGKDf1PKsUD5YkBvM3oAbyn+BjnJqUKjJxHR4xk3V4j
CKaMHisEUPjJJgun3MUwd8+lF6j5z29OcZTqVz6ez6VQC5yXyyGP8BFbOxGsl2wZ
5+u4H52x2ZXlhoT0WlyPSZb0MH+k6Rem7Dkt1FExyiILPZ2QFbp71ypfRFoRsWRc
nZRyXFDsD/AZdOepedxyUihI2fzLCHDcscEGUptAuFBhMkJmp0C6CsebABFsK0ib
rmlNrwhqXnWcTqYSP7XsKboKy3GVG3ph9BoPye+kUyZ/K4taTitAUxoqWcOKkFG/
4poPQKZiifP5DraddGVLSMI+Bcj4Ly2/0eVvz89HDzHPgZHwmX8lxtqjmYYM20d/
uiGf72jB4Cl0eeqL+NMbmegS1LjE4iivcMRAxEO5d9rv204azpU=
=qf5c
-----END PGP SIGNATURE-----

--zchw23fcb7jg5anu--
