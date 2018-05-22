Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEVQQ0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbeEVQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:16:25 -0400
Date: Tue, 22 May 2018 18:16:22 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 18/33] power: supply: use match_string() helper
Message-ID: <20180522161622.iwfo4ppcqpthxkum@earth.universe>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-19-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VfnJQBdXiVuv9OOT6w=wD5rKDCJKA7M2iyxxmQndNhoRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgfopwpbzziugpzd"
Content-Disposition: inline
In-Reply-To: <CAHp75VfnJQBdXiVuv9OOT6w=wD5rKDCJKA7M2iyxxmQndNhoRA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zgfopwpbzziugpzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, May 22, 2018 at 12:58:14AM +0300, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wro=
te:
> > match_string() returns the index of an array for a matching string,
> > which can be used intead of open coded variant.
> >
>=20
> This doesn't make code looks better anyhow. I even think it makes it
> worse to read. That's why I dropped my version of the change (and yes,
> I missed the type conversion which looks here just ugly).
>=20
> Sebastian, if my opinion makes any difference here, I would say
> NAK to this one.

I agree.

-- Sebastian

--zgfopwpbzziugpzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsEQlYACgkQ2O7X88g7
+pqGJg//SQU/lRqfRD0aUmCRA10EE3J0EWHgyGDMRu2IthzfQ6HGRt6QAecltrqd
hPyfv/9WX9G9tAI4tcYdlPu76bxmoq4rm8ZfTO0MAGc0pYum5hhQ/S6iARBN1Giy
miutTMYI6h1B5p4ZERk9oEPNZxaPfizO1pDsoH67vnid7jQmkhHTc3bVxN6sX/Hi
eig6S4jeoJFFDLQZZ5aeHBLKYhhC0L8cPyUbLpGb5J2QKhx49uw1bdbwCX2BYGlW
N8K6b8AluV8g9wGGR5KVSltjXWMVpjV5At1Sh3dm9zQXUNVwX8L3XmgExkdBWXKN
fae3Sw3wmF7sZdM4HtkEv+GHEbJUoSDlpEAgj2Zuss+WSehBODA5U2LpU0cNh2LS
zlqvoS3Ik4FEcfpt9Uay3uxTFGFz5T3zhGPelCrA3dZJNd7yZbXDdPvfC+CChtFH
yFke68PKXqw+ymI4gvtrK8hcfghqBHfi7SfPW94gAwvkLTBkQ0/uUsdEFrDwx06F
ujZ4/WL7gPoPq/oSBfDrrtpTEuAgk+7NOh7LJouYkvMjxtgWGElWxAFv5Mulj/0Z
F6sTZ+002HQHrkGGMpO4EpVGefXYxy8dvVHUuee0z+fNPubusjnUnNFWx6H2Jn00
oJF8zB2D7A3JJtja1ffqbzz/80MH2wkYggr3n1qLAwK/vYygqTQ=
=hudn
-----END PGP SIGNATURE-----

--zgfopwpbzziugpzd--
