Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeD1NMa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 09:12:30 -0400
Received: from sauhun.de ([88.99.104.3]:57820 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeD1NM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 09:12:29 -0400
Date: Sat, 28 Apr 2018 15:12:27 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jun Gao <jun.gao@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] i2c: mediatek: use of_device_get_match_data()
Message-ID: <20180428131227.u7cuvdhuo3dahsdt@ninjato>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="elwt6h2lmsgibred"
Content-Disposition: inline
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elwt6h2lmsgibred
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 10:32:52AM +0800, Ryder Lee wrote:
> The usage of of_device_get_match_data() reduce the code size a bit.
>=20
> Also, the only way to call mtk_i2c_probe() is to match an entry in
> mtk_i2c_of_match[], so of_id cannot be NULL.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to for-next, thanks!

Does somebody from Mediatek maybe want to maintain this driver?


--elwt6h2lmsgibred
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrkczcACgkQFA3kzBSg
KbbwoQ/+KCYGO5O5SkhaWxtb6akUXQgTnvnsoBHa66kJugWnzMyHIVwxCS6hBhRw
qMtiZ2kiaoQfg+2JNhr2va1a7k+sQBV7xNjMkVJjKwvXEiYsFqOjSMOkf9q+8nAZ
eTegPYX4f4lcdW5ObBP0GlekMywa29/I7VjfqjPjL462XeCp38aO3dATUomuZcmz
770Ndja8cEfzO/PCulmGvF9ca/nC8Z1edsxo9YWcWL9+ylGMEfHdByk7njBrmVL1
4nGkPhLq3sRssrjXKxiHT3S6QcJVSwJAd+zU7vq/kBm16ddpQEacAyeCGghr9RUt
Kttd1THKLeYdYoamim/I//9UCNZG8eiuQxYNQbYIu1III3QYoxh6hpIqcUS8rene
o9mKokCxLjEfD8ukzorO/+MbXfFdkUHbQUcnUkYrHGitDpg4fCILFovf9DNJWuO4
+F9PijySeWCD3sEQ/xZR/zm5dVcUe/N4K4p5QIZZSq+ZFFrcbooMSN4JmceUn/E1
wexz+hBVcsa3h2S6CspDWt7yCZIRoRRiB2TBQo4NswaUX60okf8A+4mpu6ndqFau
x8FOOk6INLThEvLDxjfuAgxw98piC944eWx3T6oLnT3qz6m+lNKynWOgIhWR2b2w
QBF+IcqJJFowGzu3hlwcCk2ET5ha2j0PAj78iPZfUUxS8OSlSDM=
=9Ftn
-----END PGP SIGNATURE-----

--elwt6h2lmsgibred--
