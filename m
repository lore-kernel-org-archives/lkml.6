Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C72C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642FF20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642FF20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeLNBky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:40:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45568 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728130AbeLNBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:40:53 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gXcTD-00017u-Ge; Fri, 14 Dec 2018 01:40:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gXcTD-0003ZD-CD; Fri, 14 Dec 2018 01:40:51 +0000
Message-ID: <bf885f925b8df55bce969a341d472f0e2c21bd10.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 038/328] tty: fix typo in comment of
 tty_termios_encode_baud_rate
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 14 Dec 2018 01:40:43 +0000
In-Reply-To: <ddddf0dd-5a6b-044b-4875-d9d13cc6eaf3@gmail.com>
References: <lsq.1544392233.593642394@decadent.org.uk>
         <ddddf0dd-5a6b-044b-4875-d9d13cc6eaf3@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-pCp+JQJtBjAz4ZfpXl1e"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pCp+JQJtBjAz4ZfpXl1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-12-12 at 14:57 +0100, Matthias Brugger wrote:
>=20
> On 09/12/2018 22:50, Ben Hutchings wrote:
> > 3.16.62-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Matthias Brugger <matthias.bgg@gmail.com>
> >=20
> > commit a1d51aa2214cea3f91611893610a2f769cada0e7 upstream.
> >=20
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  drivers/tty/tty_ioctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > --- a/drivers/tty/tty_ioctl.c
> > +++ b/drivers/tty/tty_ioctl.c
> > @@ -408,7 +408,7 @@ void tty_termios_encode_baud_rate(struct
> > =20
> >  #ifdef BOTHER
> >  	/* If the user asked for a precise weird speed give a precise weird
> > -	   answer. If they asked for a Bfoo speed they many have problems
> > +	   answer. If they asked for a Bfoo speed they may have problems
>=20
> I don't think fixes of comments are good candidates for stable.

I agree in general, but this allows commit 1cee38f0363a "tty: fix
termios input-speed encoding when using BOTHER" to apply more cleanly.

Ben.

> Regards,
> Matthias
>=20
> >  	   digesting non-exact replies so fuzz a bit */
> > =20
> >  	if ((termios->c_cflag & CBAUD) =3D=3D BOTHER)
> >=20
--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.


--=-pCp+JQJtBjAz4ZfpXl1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwTChwACgkQ57/I7JWG
EQlirw//XHg0WxPO9Gm8FwJLdC/pI6B7dU5BfrbzJhlRZc0t7KkBWBtS0m1I29QT
diwbk/ifHd+OwVYqkjaMSqkR5+MrkYmd9gOQGkkARX0DSFJCFPxU9TiLvV7ZXUvl
MFXyec20zoyW89KSd5djBF0/MZBjvUhJaWseFu2ct8VlDR4FeUERLQJQJWcEJYJ/
7IUWfJwiAppV4tugU/yQtMXW8WTr0hCcNtbXnPtV5/b2Oz/AwSC5cLw6GL99IDOa
0dGLxhqV8noLv53b6kOFV5GcFvBK1OpkWiVXXo75cnfaunb/jqfW81l5N3nrRpz8
jC5bNqmqFt+8L9YWod3dCN7RcCrSOe8eyds6NUpLqhx2qah21R3KjjsfTMqgiQ+R
jdNy6jAT089KiB9HrvbYQybhNezw+3jafpuV/bf9fPhZPcUZ2WZypthMA+b6mvrH
+azggDnMvKGiJaLxMkDd4ANaTRhZwUW4eAS4eA/e4Y359qU3g46splGKyNUGHTsN
XAw59r4CcJFf81PV3h4hKJPqc52JQBQUJoatYPE0MdnbiPK6uuFNwH6WoEK2MsXF
f2pIVJqcjuHgGTpl2W8iL5uxxpDv6TYSbhCNMhc9TqyEQK8gaYkZOHLMedhvuQew
yB+AnRMmz2kvr4xnBSJMqXea4MkLDJ6CIPHUeabW4+Nq+GQJK84=
=qboi
-----END PGP SIGNATURE-----

--=-pCp+JQJtBjAz4ZfpXl1e--
