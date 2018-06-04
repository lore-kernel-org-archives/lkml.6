Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeFDJJX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:09:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41870 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbeFDJJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:09:21 -0400
Date: Mon, 4 Jun 2018 11:09:19 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 2/2] arm64: allwinner: a64-amarula-relic: Enable
 AP6330 WiFi support
Message-ID: <20180604090919.s2mp7etd2eao3w6b@flea>
References: <20180601173527.18051-1-jagan@amarulasolutions.com>
 <20180601173527.18051-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imuw6uj272abzmoe"
Content-Disposition: inline
In-Reply-To: <20180601173527.18051-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imuw6uj272abzmoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 11:05:27PM +0530, Jagan Teki wrote:
> Enable AP6330 WiFi/BT combo chip on Amarula A64-Relic board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PL3
> - 32kHz external oscillator gate clock from RTC
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--imuw6uj272abzmoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsVAb4ACgkQ0rTAlCFN
r3QLYA//XX6AgPIIPWlnDRs0oerry9XmtGVsdtRtuoQKqlvto+gqPO19gNSa7I3M
xFuB4zqtzrRdxmqACVWTgOvz8NPaUDhtxTAJZ6RXwk1ebdPyUV+y9e0BTYCHG32c
EsD0khoVWwrt49cBGO/Kv6uT8FJkIY29QrovSWz452ChPOFhWzW3lE48gtX/+CB3
y3DdL4CGdnBy2PmhZStekltB7LyUGGozD+W5/xqXFhjkEHWupwqk/gjrwpk5JQfA
4rlkSwIBp97haivMliT+Cy6M38hXmf+9A51IZ8HRXIvOXqtFnonGaxQu3uGvqhc6
wEp1WTcOZFeZAb6tEDBY+V7LelcT7usj4iyC1tS7uR6XwkndmMFy/gFy3h/uzfbS
RASaFAOMkYeCnIKYeRw0jlxXMsjpY/0Vfz2UALZHUMgGdfz1ik8CF2cGdNzoKdO+
ejZ5dO6bpcxKi1U2X40rgi+aM9IwuvU7mahZAf4mAUfS+Av2MZ4tCItPGyqhjnjF
3hJ8C9Qz3nfK4DqAEGrZSfTBPbsEstERRsbWZvWgu5hr6HQX4Hy7U62CHFrROO9m
9LJLhnOsjd6YCTHXF1vMHnLnjD3f0axeKiujmLGazfLIutsGdD34cYNTYXOSRfdb
lgxZ+BFYx2CCZ/DxMPDyEWGi03LutjZtkteUrg1BDZsHQPt1TNk=
=9XoQ
-----END PGP SIGNATURE-----

--imuw6uj272abzmoe--
