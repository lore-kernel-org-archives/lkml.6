Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeBBPGV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:06:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeBBPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:06:16 -0500
Date: Fri, 2 Feb 2018 16:06:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Message-ID: <20180202150609.GB7101@sirena.org.uk>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
 <1517475954.8615.18.camel@nxp.com>
 <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
 <20180201134840.GA10785@sirena.org.uk>
 <CAHp75VfydH+9ABZRbV++Od3+wnvQdzXyyDFtfi-1FnOUYjOXQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <CAHp75VfydH+9ABZRbV++Od3+wnvQdzXyyDFtfi-1FnOUYjOXQQ@mail.gmail.com>
X-Cookie: While supplies last.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2018 at 04:46:56PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 1, 2018 at 3:48 PM, Mark Brown <broonie@kernel.org> wrote:

> >> >> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> >> >> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> >> >> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >> >> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

> > Honestly the signoffs above are nothing unusual for a driver contributed
> > by a vendor - things are often bouncing around internally for ages and
> > it's good to keep credits for people.

> We have Co-developed-by: for the authors.

Which doesn't really get miuch use and in this case where it looks like
the code has flowed from AKM to NXP the DCO bit is pretty important.

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp0fmAACgkQJNaLcl1U
h9C4RAf/RHdMOddvylREHgB3b0yMmn1+egkt9EVJ0piJ76T5txB8fSnwyVGLn7c5
2vXcEmyuOoA4eSbfWeg8s4I7XTtUedb5v5eGkM9NZxGlCjhYUY5EGZ1t7e4pviMt
uWcm6SfLlFtjdr1hGEiMY3QEHbqfyyJ6w9yxJbf+07TTgpcAjL5h0NEuHClMsuM8
+sqBvP/LmcjV30yfOeEfecJ91Rg24WZRqE+R2SiwRm8fyX0/ZTM1VpLi0BNtqGXZ
bDGyseWDs4RQdR6i8aRMhAcHYzp5sNF30Msl87gc8dsiMF+0EqFWMy1F8/ILXW6y
Bwv4GDuJz3jARvmUaJ038VayckVo/w==
=mCOM
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
