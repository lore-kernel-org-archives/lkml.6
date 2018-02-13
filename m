Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934184AbeBMPph (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:45:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbeBMPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:45:35 -0500
Date: Tue, 13 Feb 2018 15:45:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RESEND2] regulator: fixed, gpio: dt: regulator-name is
 required property
Message-ID: <20180213154530.GF5988@sirena.org.uk>
References: <1518532988-10990-1-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <1518532988-10990-1-git-send-email-harald@ccbib.org>
X-Cookie: Blend until smooth.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 02:43:08PM +0000, Harald Geyer wrote:

> BTW, it took me a bit to figure out that by "content free ping" you are
> refering to the quoting of the patch. Maybe you can reword your canned
> response to make it easier to understand.

No, a content free ping is when you just send a reply saying something
to the effect of "hey, what's going on with this?".  As I said in my
reply best case the answer is going to be "I have no idea, you need to
resend since I'll need the patch to do anything with it" and worst case
it just won't get seen at all if the thing really did get buried
somehow.  This is unfortunately something that happens upstream, things
fall through the cracks sometimes for various reasons (eg, if a new
patch gets sent in the middle of a thread sometimes it'll get deleted
along with the reset of the thread). =20

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqDCBoACgkQJNaLcl1U
h9BlvQf/eMwr0k0vC5oTHJFv3eGkyYG79i/2tUztyYo6BM8icOr15zmxTEyijZJp
AhyGMsaJLjrYXv0KTjmCXNAAk2i4jUzPgfV0YHrEr8HNIVWUF3aGqIhXwDtV1PqI
SYGM9AP+r3Dq6qThCaEBJdvl6BS49IzDGDQ9iauJzPn1VKxWSKa+KLdwd9bOETpZ
JKZDG/XnAzIJ2pyCZy/Zw0IgRGwCp0UMPtkWXXzqz6qFr43p+YDHmcMjf63Q1pdP
yDuzmBH4DY5Roq64vYwrGR/R34mqhZKVVQTuMISb5QajjlaMlYdJ/iPz3CG04LdP
0ENNKcDB0qn2EB7lN4p9gEfoQEOoiA==
=7HBL
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
