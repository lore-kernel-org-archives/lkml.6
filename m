Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbeCIM5F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:57:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeCIM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:57:03 -0500
Date: Fri, 9 Mar 2018 12:56:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v6 0/5] Add coupled regulators mechanism
Message-ID: <20180309125659.GE5252@sirena.org.uk>
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
 <1520598128-11768-1-git-send-email-m.purski@samsung.com>
 <20180309124234.GC5252@sirena.org.uk>
 <5cf960c5-73ab-fd53-fb68-b6f7f92ca3e7@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <5cf960c5-73ab-fd53-fb68-b6f7f92ca3e7@samsung.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2018 at 01:50:20PM +0100, Maciej Purski wrote:
> On 03/09/2018 01:42 PM, Mark Brown wrote:

> > Is it possible to respin this in terms of the test/coupled branch in my
> > git tree?  There were a bunch of build fixes that got sent and I don't
> > want to loose any of those.

> I have included those build fixes in my new patchset. I can extract the
> newest changes and rebase them against your test/coupled branch, if that's
> what you're asking for.

That was what I was asking for, yeah (though it can wait till people
manage to test).  It would also be helpful from a review point of view
to see what the fix is.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqihJsACgkQJNaLcl1U
h9D2ZAf/dv5w6RfzbQD/mCwS9DehbZ/Lwp+FsupWsCKuYLkxNg0xdLQ5GpxY+DE4
7O63T7K4iqUguJOH6kKbrs49hLm1kfeQCWtPz+P8CC17NfhnbvHKYX+2HDn3w/m3
GvvJpOhZ7sgiIgzy2qNT3c8FLtuhwSF/183ZW0nSaEYKfkQYChoOPtzw6Crf+Hm5
T+4dQ3rDukS1PpQZqvcdoG1N1v3Ksp4F5mBeAdxj42XpTH01jiqk9nPhwicE5Sh0
zc/WyUC3D9hZ+ljTbrXZ1h/bKYrLxxd3cA5qAxMdOO2abtCQO+SkeOJRA9mWoq9Q
WypHqcPXKFwuY2tw2PVfF6n3zMBv2Q==
=lUJC
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
