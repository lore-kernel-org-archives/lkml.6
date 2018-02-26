Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeBZJqg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:46:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42634 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbeBZJqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:46:32 -0500
Date: Mon, 26 Feb 2018 10:46:30 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [GIT PULL] GPIO fixes for v4.16
Message-ID: <20180226094630.c4yh4fyfjdeurqo7@flea.lan>
References: <CACRpkdYGQUynZJu+4-Bj=TzL5=C4qt2cYav__9aHSnwD2NERDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fwk4wwcsyg5cmbhp"
Content-Disposition: inline
In-Reply-To: <CACRpkdYGQUynZJu+4-Bj=TzL5=C4qt2cYav__9aHSnwD2NERDA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fwk4wwcsyg5cmbhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Feb 26, 2018 at 10:36:00AM +0100, Linus Walleij wrote:
> Hi Linus,
>=20
> two fixes to GPIO, both by nice colleagues fixing my mistakes.
> Please pull it in!
>=20
> Linus Walleij
>=20
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1=
b2:
>=20
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
> tags/gpio-v4.16-2
>=20
> for you to fetch changes up to c2b3eec47c1b2161adbc70676f1422e6f56aaa32:
>=20
>   gpio: Handle deferred probing in of_find_gpio() properly (2018-02-21
> 09:37:34 +0100)
>=20
> ----------------------------------------------------------------
> GPIO fixes for the v4.16 kernel:
>=20
> - Two patches fixing up my mistakes with device tree properties
>   compatible for SPI and regulators. Nice to smoke this out for
>   v4.16 though, when we actually use it in v4.17 it will be
>   in nice shape.

As I told you as an answer to my patch, it still needs to be amended
in order to work as expected. The one queued in the PR doesn't work.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fwk4wwcsyg5cmbhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT13UACgkQ0rTAlCFN
r3RArg/9Expm+jIBNt4BDuGadgbINFQZTj6beXHTGTkd09nan0o0qIT7dKBjRDco
gx9ajlgVfiFaAQro1JLhJQH2YO7oDw8hIMWvWEK0Fbyu0lQIk4ft48S+sStt5I8z
WXD7hzFnbohI7aXfARWdL5/ja+0eitTv7w/ltXituHrXqrI+oDgrQ6Cmh6iwpmD/
tS8AEuTUlxJvMUrSROwjBbOUWRSmeayzCIdA5Xh+9GZa6q7d/5MmG6LXMT3iUmD2
CK+yHRgLeF5iosf7OYUjM/5Omep7yzvMvhXlNVzo66IYC1aOEEnZ63kAcLP0MEUv
JsI1H8fKmZLhg+2gWQ8LPoGom+FgL/w3QwEubud8pLbGQPt6LC5VMnlWcziayarG
68YBsP9PHVpTo8EvwRb9ekxsWM0sXx3sn9GySVcp4R2bmqPXxZAiF/l8TbaxaE9l
HK+06Fcb0y3lkl4HUe2M06wGP4bIgDaFzZYvur9lCr13ilDw9vVEGEsy0x3xPC0g
MEufkpfnShhOJCcfiQr7KtEH2XxpMyYAPySqqYRjeeAk/eyDI99aCT2Xcx+bhOu4
2kPOm2o1MFROuBq/qcaiv07LBt5tGH8ZeKhAmWAVPcuq7i/arKTky/2+VBJx99KJ
I7OJs79Yno00CH2E2kyuhsvDGY/cSTv8qVQiZkuAkQ71uGnUwds=
=4ZiN
-----END PGP SIGNATURE-----

--fwk4wwcsyg5cmbhp--
