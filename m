Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFBTCa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 15:02:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35246 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFBTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 15:02:29 -0400
Date: Sat, 2 Jun 2018 21:02:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: rjw@rjwysocki.net, chenhong3@huawei.com, ravisadineni@google.com,
        dtor@google.com, len.brown@intel.com, gregkh@linuxfoundation.org,
        tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rajatja@google.com, bleung@google.com
Subject: Re: [PATCH] power: Print wakeup_count instead of event_count in the
 sysfs attribute.
Message-ID: <20180602190227.GA19946@amd>
References: <20180602023215.176521-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20180602023215.176521-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-01 19:32:15, Ravi Chandra Sadineni wrote:
> Currently we show event_count instead of wakeup_count as part of per
> device wakeup_count sysfs attribute. Change it to wakeup_count to make
> it more meaningful.
>=20
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsS6cMACgkQMOfwapXb+vIP7wCeL74QOuUejgN08PA+1PEuh8QP
wVcAnAjb093p71AEH+d0wnEkpVLSAxzY
=X4MI
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
