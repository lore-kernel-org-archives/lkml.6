Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeEAVBS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:01:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42764 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeEAVBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:01:17 -0400
Date: Tue, 1 May 2018 23:01:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PM / core: Clean up suspend/resume diagnostic
 messages
Message-ID: <20180501210115.GB9637@amd>
References: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-04-26 16:36:20, Bjorn Helgaas wrote:
> These are pretty minor cleanups to the suspend/resume diagnostic messages.
>=20
> The first two are trivial.  The third may break scripts that parse dmesg
> output.  I looked at scripts/bootgraph.pl, and I don't think it is
> affected, but there may be others I don't know about.  Let me know if the=
re
> are.

Looks good.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlro1ZsACgkQMOfwapXb+vICHQCfepsrP/0TGbrVIm9yHq5lZrU5
8wgAoJCeACqeBpJgMMQs2sr8zplvkPAp
=dICQ
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
