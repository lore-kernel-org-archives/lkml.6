Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 22:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2595520878
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 22:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfBXWX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 17:23:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34601 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBXWX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 17:23:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 513658056B; Sun, 24 Feb 2019 23:23:19 +0100 (CET)
Date:   Sun, 24 Feb 2019 23:23:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Olof Johansson <olof@lixom.net>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Arnd Bergmann <arnd@arndb.de>,
        fbarrat@linux.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
Message-ID: <20190224222324.GA6109@amd>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So, I'd like to propose a drivers/accel drivers subtree, and I'd be
> happy to bootstrap it with a small group (@Dave Airlie: I think your
> input from GPU land be very useful, want to join in?). Individual
> drivers maintained by existing maintainers, of course.

Does this sound similar?

menu "Remoteproc drivers"

config REMOTEPROC
        tristate "Support for Remote Processor subsystem"
	        depends on HAS_DMA
		        select CRC32
			        select FW_LOADER
				        select VIRTIO
					        select
        WANT_DEV_COREDUMP
	        help
		          Support for remote processors (such as DSP
        coprocessors). These
	          are mainly used on embedded systems.

=2E..we already have that in tree...

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxzGVwACgkQMOfwapXb+vJGpQCgjI95tx7vz8F+NpL5rR1Bf09C
tMQAni3z/5Kq98msjrJdYKBzf4yEoPlZ
=fo7O
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
