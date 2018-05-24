Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969519AbeEXL7G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:59:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42991 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969503AbeEXL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:58:56 -0400
Date: Thu, 24 May 2018 13:58:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Luis Henriques <lhenriques@suse.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: class: ensure workqueue is initialized before
 setting brightness
Message-ID: <20180524115855.GE27040@amd>
References: <20180523222221.27621-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20180523222221.27621-1-lhenriques@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-05-23 23:22:21, Luis Henriques wrote:
> An application can try to set brightness before all the initialization is
> done, in particular before the workqueue is initialized with the call to
> led_init_core().  Here's a WARNING easy to trigger:

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsGqP8ACgkQMOfwapXb+vJ6JACgi04gYcyZrSvzMLIIVPwyCtHH
vF0AmQEYa39unPnJ8xLUBks95xU+3+Dv
=S7Vp
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
