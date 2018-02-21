Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeBUJLf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:11:35 -0500
Received: from sauhun.de ([88.99.104.3]:44201 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753110AbeBUJLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:11:32 -0500
Date: Wed, 21 Feb 2018 10:11:30 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Message-ID: <20180221091130.4sdfnalrng4sd77i@ninjato>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r2eb7okx7lhiwtec"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r2eb7okx7lhiwtec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 05:56:52PM +0100, Bartosz Golaszewski wrote:
> 2018-01-29 17:17 GMT+01:00 Rob Herring <robh@kernel.org>:
> > On Tue, Jan 16, 2018 at 05:06:15PM +0100, Peter Rosin wrote:
> >> Makes them easier to find.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This one should go into 4.16. I can apply after rc1 or apply to tree
> > with at24.txt changes queued.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > Rob
>=20
> Wolfram,
>=20
> can you take this via the i2c tree for 4.16?

I missed this mail because I leave at24 patches to you now.
Please send pull requests for patches I shall take. Least room for
confusion (I hope).


--r2eb7okx7lhiwtec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqNN8IACgkQFA3kzBSg
KbYBFxAAms4N9T01ToIDTtK0i0l6S21CWRH9VsyfnUKa3QVG8p2ggl5+TVixMFNm
aQk0C91VQIo0WqHRYCudv26GstuO29dycaF8lwrgKtAiFGTTVSEqIGJqpQdRH+vo
f/qsdCtTBsM7lBLL1pnUr/m7rOivS21Xsi2lhG0WxS3zFSWYSiyRlVtSCq7UPADY
/D/PObzpndnOxwLZT9ra5yoELn15YZM69G82x0f9yRsBAj7h8d0ZphIJby7AA05r
uLkOmiQqaH31oa2HPbt268NH9TLvE4oBDptCqKDnxoi6S5Qtk7n8sIZPrh0SPFfD
nPdW3ZySuOwIUMIzmL4mhjoZ0VfgESF6gZbc7VG00rMB4CORmDbvXkKcrkphU85k
+MXK9q6O1dTJNFWxsYzrcLVFMwHf0InLH2wlX/+lbh32HBIuECQlZih2NaANLJ1k
3W5STVUmhHDtaT6pGnF5dH5dOzPUbdvH9ins52GWYoWhzZqefpSbUTMxqGyKhQ85
kYD72/y5EoPSaMYu0s6zSHH7qsUY+r3Zb8rGpwTd5xM8GnGGUuLj+4cFbnoIZ82m
P6nDFQqSmHCdhFFMP2e2pvsaI4xAA/CzOmlC3F6NnWO3BITKMN561s9eT8Q3aazt
Bu5PjGV9v6B7gvpl7hAMcwzBcDWaoQaPfhTiDwJ+li7ucnyHt/w=
=mnhA
-----END PGP SIGNATURE-----

--r2eb7okx7lhiwtec--
