Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeFBRnN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:43:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33049 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeFBRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:43:09 -0400
Date: Sat, 2 Jun 2018 19:43:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add pci=safemode option
Message-ID: <20180602174307.GB14870@amd>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > And you should explain what exactly in PCI is "optional".  Who defines
> > this and where is that list and what can go wrong if those options are
> > not enabled?
>=20
> Bjorn and I discussed the need for such a "safe" mode feature when you
> want to bring up PCI for a platform. You want to turn off everything as
> a starter and just stick to bare minimum.
>=20
> I can add a few words describing them. The goal of this option is to keep
> base PCI features with MSI only. Things like PME, AER, ASPM, Extended
> Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. safemode
> is certainly not intended for production environments.=20
>=20
> I can taint the kernel as a suggestion.

I don't think tainting is required. even modern platforms should work
in the safe mode.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlsS1ysACgkQMOfwapXb+vLNGACgvXxEN0Xsaay3KFmc9pcELqNp
yN4Al2Wb+Hsizgq51WxdnORdI/5DhSY=
=BqMv
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
