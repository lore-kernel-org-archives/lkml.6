Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88260C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5907F20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5907F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLKTto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:49:44 -0500
Received: from sauhun.de ([88.99.104.3]:45240 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKTtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:49:43 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 6E3444C0E8F;
        Tue, 11 Dec 2018 20:49:41 +0100 (CET)
Date:   Tue, 11 Dec 2018 20:49:40 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's
 at24 EEPROMs
Message-ID: <20181211194940.u6ru27qfvrxc3xey@ninjato>
References: <20181206094550.18082-1-brgl@bgdev.pl>
 <20181206104421.a6njveg72dcguckp@katana>
 <CAMRc=MfRBgF9CSzGb=VMUGiCsFc1B_y=d5yMgPJ3xc0GyytATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hp3uq3uf7plgsilw"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfRBgF9CSzGb=VMUGiCsFc1B_y=d5yMgPJ3xc0GyytATA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hp3uq3uf7plgsilw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 02:18:15PM +0100, Bartosz Golaszewski wrote:
> czw., 6 gru 2018 o 11:44 Wolfram Sang <wsa@the-dreams.de> napisa=C5=82(a):
> >
> > On Thu, Dec 06, 2018 at 10:45:50AM +0100, Bartosz Golaszewski wrote:
> > > This is a follow-up to Thierry's patch which missed a few occurences.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >
> > Since I dropped Thierry's original patch, I wonder if it is okay with
> > you to simply squash these hunks into it?
> >
>=20
> Yes, feel free to squash those two with my Signed-off-by tag.

Done now, thanks!


--hp3uq3uf7plgsilw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQFNQACgkQFA3kzBSg
KbaKUxAApaFbz8HNFCpbawjy/bW1uuTvKOdoPdLY9+KiygbTLqqVAfaKxscKpmA+
IpKiVyT1UpYFarePvzZ37z5m3+r3Qk72Sy04bK/eJk2dMZ8PYFEaQrCYlTDBOxEu
Qu3YedaF95i9V1nCZ5JUOOopH03zPYSlSjQRUZfZpBjY9CnYRyV9BVlKmzw8hXH+
ztOu7omw2EQVB7Xu6qPyX5HL6Yy6qK8SwFbZJca6oezlVnphUoy9kYSSMSSTSLAZ
yEHzP2oDFQIyKSWy+crCg0kVYm+vjxkCxGtvhuGwCSfMHHuU8X/BWpZx5ObqIe9F
bMCDmZO4FAq/FRQGGRFN0J/N49d1vklFzy0azGD4o5yTlWDCdJ5kE1y3xHhcn7M3
7EZIiozo2MBFBqg+ifPlepEysE7WYvw/6KNJCSoeeBs2jILElFbyZbNKqmRb5US/
x6nU1ZG+BExn+5yGKEiCss5h+0UyDHjYZt4lC3pazhOFsvRP7VgMNYy9/z9+Ui8s
KhB+fmnRHqKptnQe85SThlD38Ghw5BB5c4sr2rW8yZQO7m5rnGUcRyBxinLziwu/
DM8gDaR/FzqrMkzZ+BkUjEoymdf3tgAZKdmzAJ+jWxdEhFaJc4sF+wH50K8hUSKx
o1LK+nmb63WVCygOog9alOpY5b7Sns9Pf/tja5Y5a31PCkmK/oA=
=Y9uK
-----END PGP SIGNATURE-----

--hp3uq3uf7plgsilw--
