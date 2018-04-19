Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDSOFj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:05:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42640 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeDSOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:05:38 -0400
Date: Thu, 19 Apr 2018 15:05:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 16/21] regulator: wm8994: Pass descriptor instead of GPIO
 number
Message-ID: <20180419140534.GE27188@sirena.org.uk>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
 <20180212131717.27193-17-linus.walleij@linaro.org>
 <20180213111147.kr4kecqbhmcoq6w2@localhost.localdomain>
 <CACRpkdZVoYsdWy6GwnnSfaSc2_wycEse3JswqufqDoz=GFb5FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <CACRpkdZVoYsdWy6GwnnSfaSc2_wycEse3JswqufqDoz=GFb5FQ@mail.gmail.com>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19, 2018 at 03:55:35PM +0200, Linus Walleij wrote:

> drivers pass an enable GPIO to the regulator core. The wm2200
> for example is just managing the LDO without the use of the
> regulator framework (I guess this is technically incorrect).

It's fine if it's internal to the chip and there's no realistic
mechanism to replace the regulator with an off-chip one.  The reason
the other two CODECs have explicit regulator drivers is that they're
designed to support using an off-chip regulator instead so they need to
look like external regulators do.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYoi0ACgkQJNaLcl1U
h9AKUAf/UeeGkHpltDIu0mgdXSmkD4XnUmXd50ir2OkW+LyfHCtpdx8OSg6ypSBR
b1YQ4VsJ9W2Rh9MgqW+uo16bx18+BZ7zSI5Q+h+hzm67tdiO69+nABwf2DOJDVMC
T5iQdda1izoT5BX08DI/UhsIenio3TLyshcnZ74bi/KMqLzYd5K2gcttjTd5bWwL
YDzAgYmb1kduryrABK54FPPLvTmnT5Zu03AKQdrLQf2bpk1Y84ViWb7vJU9YSSiU
bcDiB/PrNVLD6gG8UJeuPmulvHHMubbqOMtrxSwSyUgNFVtvdX+VGpLcLVhLiaFg
ooHvLthBRq1n01Zu6DMe+35Fptf0rA==
=UYSt
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
