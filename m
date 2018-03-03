Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeCCVGS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 16:06:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54126 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeCCVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 16:06:17 -0500
Date: Sat, 3 Mar 2018 22:06:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: Hibernation on i386 failure...
Message-ID: <20180303210617.GA22392@amd>
References: <1cd7fdbb-3b3e-02b5-743b-2cc8c4d755b5@intel.com>
 <92900026-5110-bde7-fba2-89d545bca29a@gmail.com>
 <20180109223047.GA26431@amd>
 <cf0cf715-a8bb-9bc9-e308-223712498f31@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <cf0cf715-a8bb-9bc9-e308-223712498f31@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >On Tue 2018-01-09 16:54:51, Woody Suwalski wrote:
> >>Hey Pavel, so you have found that issue earlier... Do you have a patch =
to
> >>try?
> >Did I? I do not remember clearly.
> >
> >Anyway, here are my hibernation-related patches... Absolutely no
> >guarantees.

> Pavel, here is my attempt to convert your patch to 4.15 git, it builds
> cleanly, and it does not work. If you have a moment to spare - could you
> check if it is a classic case "everything is good, just does not
> work"?

Sorry for the delay.

I've tested today's linux-next, and hibernation works for me, no
patches needed.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqbDkkACgkQMOfwapXb+vI8WQCePYrXdOtccBQ9Xp2prSipe9j9
IgAAnRUBvhIxpVaDUf3P/5KQt25mRvrK
=MqCI
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
