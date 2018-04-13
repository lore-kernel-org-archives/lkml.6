Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeDMXct (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 19:32:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38858 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDMXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 19:32:48 -0400
X-Google-Smtp-Source: AIpwx4+EKG0VxF4/NVCeinHVaUBsFaKwAf9Yzjf1PQtmUi9KuS35DQn6UG/jOmy3aAH/Z7iZyrp1og==
Date: Fri, 13 Apr 2018 16:32:44 -0700
From: Benson Leung <bleung@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, dtor@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>, Guenter Roeck <linux@roeck-us.net>,
        enric.balletbo@collabora.com, Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [GIT PULL] chrome-platform updates for v4.17
Message-ID: <20180413233244.GA108443@decatoncale.mtv.corp.google.com>
References: <20180412222101.GA242548@decatoncale.mtv.corp.google.com>
 <CA+55aFwSStqgd-i86ubpLRWPiYTyC=Km--t2C0TF1UqMUv0kgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <CA+55aFwSStqgd-i86ubpLRWPiYTyC=Km--t2C0TF1UqMUv0kgg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 04:26:41PM -0700, Linus Torvalds wrote:
> Please don't do this to me.
>=20
> You're sending me a pull request in the second half of the second week
> of the merge window, and none of this has been in linux-next as far as
> I can tell.
>=20
> I don't even check linux-next as of when the merge window opened - I
> check it as of "one week into the merge window".
>=20
> Ok, ok, I do in fact find two of the commits in linux-next, but even
> they have been rebased for some reason.
>=20
> The others? I can't find them even in some rebased form.
>=20
> I'll take this for now, but next time I see this kind of "late in the
> merge window, absolutely zero exposure anywhere else", I'll just skip
> the whole pull request. Don't do it.

Sorry about that, Linus. Won't happen again.

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlrRPhwACgkQHwn1ewov
5lh2Jg//cEEx7vXCMQIuD+YNHDKFw4CtaA2MeWOcwkre1QJZTLAJF6B44WDPArdN
WgTGzUTzNpQUnjaTT00HFy3UMGH/lM9/aJKiEvyXNFK+amjzL+0Ae3gSgaNoCGrH
7fNqLOG6j8cTU3Hpd0b9V5wLwzjRmxni6OFCpTIffW9fBjNL1j1GUpPvJxRPTSmW
EZq1HOi+6WKcRa8n2eXKpXHnOdWgf2Cp5Qs2UHuUfH8iPqudn7o6MU9D/v966+aM
u+Bk7gZ2ZiWno7TkoomOUQzrOJGYJ9accFR0ld1bMw6UcZ1rHZu6jkYHFahqQCmA
nALP2zhX3bY9HrECLX/+lwrSDf1/L+wxyQcvygcwgoKiRoeFJWDIgjtoblDqO1XN
FwDK2HqADpd0/f6IFyMZ6Dx6f5MNEprX1JQcfVinDe40B/GBJ9RmrqwqIJRqqG/M
y2IWVMMeVAYTzk/avEbZTjODnVo0MVHuER5XXkNhhcZDIBooxUnCN2xxElsojhKo
MDPgJ0DLNds8b/OM0XpgYviUbT8mckY19zKg2XdmMMnv7jLuGFZ7pFKZuaWO/2qA
Ll0ZBtN2jMJsfGNlBxNjINexR5AchDvzVydRTl35KXDgIko9CRXvsRDSiQA/v/DD
BfYPVERK53bCNPgkiejbQSSbacrmO9GNOjg+ErhE48WLSZqM1mQ=
=Ie0l
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
