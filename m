Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbeDXReZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:34:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeDXRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:31:14 -0400
Date: Tue, 24 Apr 2018 18:31:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com,
        ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Message-ID: <20180424173106.GE22073@sirena.org.uk>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
 <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
 <20180423115043.GD19834@sirena.org.uk>
 <f4025431-be9a-32f9-06e1-9c6ac185c96a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <f4025431-be9a-32f9-06e1-9c6ac185c96a@gmail.com>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 04:07:10PM +0200, Matthias Brugger wrote:
> On 04/23/2018 01:50 PM, Mark Brown wrote:

> > So it looks like there is a dependency here...?

> Yes, regmap_read_poll_timeout macro uses for example ktime_compare which =
is
> defined in linux/ktime.h

> That's my understanding.

OK, it's important to make sure that people getting a patch series know
about stuff like this as it will affect how things are reviewed and
applied. =20

The following changes since commit e241e3f2bf975788a1b70dff2eb5180ca395b28e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ms=
t/vhost (2018-04-11 18:58:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-ktime-fix

for you to fetch changes up to f15cd6d99198e9c15229aefec639a34a6e8174c6:

  regmap: include <linux/ktime.h> from include/linux/regmap.h (2018-04-24 1=
8:11:50 +0100)

----------------------------------------------------------------
regmap: Fix missing include of ktime.h

Required for some dependencies.

----------------------------------------------------------------
Sean Wang (1):
      regmap: include <linux/ktime.h> from include/linux/regmap.h

 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfadkACgkQJNaLcl1U
h9AlHQf/bC6mn12CND4+25wXDK/guAEy3YpckmZXliCZ67oYASB1lLcKxu1OqQjN
U/QLwp1Xbo0HhKmvT3OQBZAEtPPUOJOEHWCevu/jVi+9j3W793P5hW3+vzAhYvVc
MlD1/9xSqskL8pSVIfiQMRa133zKUPN7Yb1VmP/Y2I+kksgB0llJakMegX1ljpka
uHKCweP0yli6KmZL6um29miFw6NZ0GOhVBrYucPPe8ovmJmrfQFT5B/zPRAqlJmu
eWi1+hXjk0o7KHXx3J3wHgDk9hXGO2eJlyKghOX0efIWWw9Jznir1BZg4V+dpVdh
OMaPVaup5ztQWdB+vNK33I1jZxd3Ig==
=aChS
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
