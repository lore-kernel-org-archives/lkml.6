Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeDZGLL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:11:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55173 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeDZGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:11:10 -0400
Date: Thu, 26 Apr 2018 08:11:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180426061108.GB4977@amd>
References: <20180425154602.GA8546@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20180425154602.GA8546@bombadil.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
> developers report bugs in hfs, which they deem a security hole because
> Ubuntu attempts to automount an inserted USB device as hfs.

We promise "no-regressions" for code in main repository, no such
promise for staging. We have quite a lot of code without maintainer.

Moving code to staging means it will get broken -- staging was not
designed for this. I believe moving anything there is bad idea.

Staging is for ugly code, not for code that needs new maintainter.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrhbXwACgkQMOfwapXb+vILRwCePKl/ETUU0wWG96+tXyQKzoiq
Bq4An1bxPszkX/nco+RsP+Mw1NNlL0Zg
=K+sj
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
