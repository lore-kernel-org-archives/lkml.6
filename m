Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B58FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D311217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfACMfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:35:03 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:46126 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726259AbfACMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:35:02 -0500
Received: from localhost (ovpn-brq.redhat.com [213.175.37.11])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43VnS40TQnz5D8;
        Thu,  3 Jan 2019 13:34:59 +0100 (CET)
Date:   Thu, 3 Jan 2019 13:34:56 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: cgroup: highlight all paths using the :file:
 inline markup
Message-ID: <20190103123456.GA7586@personal>
References: <20181230165044.GA3097@personal>
 <20190102160149.GQ2509588@devbig004.ftw2.facebook.com>
 <20190102090948.1500a4a8@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20190102090948.1500a4a8@lwn.net>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 02. Jan (Wednesday) v 09:09:48 -0700 2019, Jonathan Corbet wrote:
> On Wed, 2 Jan 2019 08:01:49 -0800
> Tejun Heo <tj@kernel.org> wrote:
>=20
> > On Sun, Dec 30, 2018 at 05:50:44PM +0100, Otto Sabart wrote:
> > > Improve readability using the :file: markup. =20
> >=20
> > Heh, that's a minor plus for formatted output and minor minus for the
> > source.  If this is a convention generally followed for
> > documentations, I have no objects.  That said, can you please reflow
> > the lines?
>=20
> The convention is to minimize markup, especially in cases where it's not
> really needed and it impairs the readability of the plain-text file.  My
> feeling is that this particular markup doesn't provide enough benefit to
> be worth the cost. =20
>=20
> Otto, we all very much appreciate attempts to improve the documentation,
> and I hope you won't stop.  If you would like to do RST work, one very
> helpful thing would be to look into the conversion of the (many) remaining
> plain-text documents and integration into the doc tree.
>=20

Hello Jon,
ok, I try to take a look into it.

Thank you,
Ota

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwuAW4ACgkQgjuumfi+
HjxeGA//cxpZOHNqU96ZxAzCnyO2U+ze5WE/dL6GN9B/itmhXfS+6YNZ7mg3ArhT
v5fEzhYN9vuG5scgMBW61wWXlq/PQvvfyPd4s8PDzLx/oiBKz4bVoi0Mn2pBM+yK
oQ0ew94tWXSBbJplovsegvkZLrd3H1+N4ah5IbHZ5RMtCYYe2/bm4Juqu+mYp53R
ieEpzFTrqo8WNi+YmiYW0bt/SQQpkeuzpCF7dtFryFVd44A4Qt0myTW56JVOMzeZ
mNRIuqcyOzmS4dndBd6g5PDpX5SP73y9P6/sV02LW7G8B+UqTPnBqms6egkIQCxy
2TCmgtE4fnhw+Agex8wCxvo31+oKSLIWiz3x4ieyrE8KdSwoWTThRXTUE/2uHQZK
p3fH7RNXCqefF2NlhYhnOzGjFsAS8NTwYNui3uA6Y6rJ1WqRLAP3PmdPllTFQGjD
oXtuHxNKkaJ+NwnrEk3FtCR9MzhwmuWKvUC2M+xhyoDPxCzx2M7Nrbtd+aERwChD
rs+VwsnN6xQacmgM6v7i+6m7uAj2GyWKc/jPdC8ll2uZFFsqh4WaoGONI2HDDYZq
ouxW7BRz0Yr0jfXWo0boaKfHebnQyPypZx62HqqD2nGa0PIqD+v3X2Czk9BNlHmK
5XsHPTFGRcbTdLdC/zrYI9mSnA/OFlDYOpBgscwm7s25vKsiVDY=
=wwrP
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
