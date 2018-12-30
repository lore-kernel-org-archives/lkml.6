Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA83C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA00920836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeL3S5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 13:57:39 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:45085 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726300AbeL3S5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 13:57:38 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43SV7L60mcztq;
        Sun, 30 Dec 2018 19:57:34 +0100 (CET)
Date:   Sun, 30 Dec 2018 19:57:30 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: cgroup: use graphviz code instead of ASCII art
Message-ID: <20181230185730.GA14598@personal>
References: <20181230164945.GA2644@personal>
 <20181230104020.1074d807@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20181230104020.1074d807@lwn.net>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 30. Dec (Sunday) v 10:40:29 -0700 2018, Jonathan Corbet wrote:
> On Sun, 30 Dec 2018 17:49:45 +0100
> Otto Sabart <ottosabart@seberm.com> wrote:
>=20
> > The graphviz looks better. This patch also fixes multiple build warning=
s:
> > "WARNING: Block quote ends without a blank line; unexpected unindent."
> >=20
> > Signed-off-by: Otto Sabart <ottosabart@seberm.com>
>=20
> The graphviz looks better *in some settings*, such as the formatted
> version of the docs.  Please remember, though, that we need to preserve
> the readability of the plain-text documents as well, and my own feeling
> is that this patch is a step backward in that regard.  I'll defer to
> Tejun on this if he feels otherwise, but my sense is that this is not
> something we want to do.
>=20
> OTOH fixing the warnings would be a good thing; I think it just needs a
> bit more use of literal blocks.  I would gladly accept a patch that did
> just that.

Ok, no problem. I will send another patch which fixes only these
warnings.

Thanks,

Ota

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwpFRUACgkQgjuumfi+
HjyxXQ//eJWgKhQmx0338uLCy3X18ipEeD9pw9WtP3RDJedX/dqM+yPXmVvijI3T
7tGV9nBI8hvbMUjlz0Hu8F+uYjNSrK7Z+ydTGTckE/T/VdJlesxn68gv8f3obA1C
7+KLmJ4BGgRRrk6tMJNzt5X0Oao2EqFatd8F8lL1t85I/BzK3uIES3DE13fltGpi
jY+EnoHVrtWKZiAKzsHMrA6CyCzuCH+Bpwjh6PrAyHm9pJ/gsMMpFyvaN9PWOokW
VVqU5xsCxEnR2ZQvoEbc+jFW26ny3u2X4EVKg5yFlJDNWx7k9wtulJtWUSYwMbz5
Z6XpVjuVXiRY5JXBPRE4nnlKzEVYUsYHOeyCF/z8ez1cp+PA3v/oLgAT0ks/Gz7L
6JyQywrB8EGcLmymO0eOwUMFmde9Dz8u4k0AF8+8QllnLWn5sXry+HK/6R4k1ABS
APqajMBmVwhSTYtgMEYQdOmb7XdvtKTlRfKqN5l4OeZ50uqUfvpFR45v2Kw92sa2
GrEhvc7ClHS647V/iy8Q73zOHwsaXzF3okis2uwkoSayoRzGev/1Rkc8vT0wKUbB
DHeiXzaJznX3UW8xOhY3eHHLkv7NCwsj0xujDy83/KegOJR5Jxudv5t5rtZ4PsS3
eKji1pA3on2w5YsCkI4DLgvOsdemBuoPxxG5rML3FVJL40/uU6w=
=e97b
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
