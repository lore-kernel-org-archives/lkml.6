Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeFAPGc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:06:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57299 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeFAPGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:06:30 -0400
Date: Fri, 1 Jun 2018 17:06:28 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: allwinner: a64-amarula-relic: Enable AP6330
 WiFi support
Message-ID: <20180601150628.zqo6jjd6ch5dvqtl@flea>
References: <20180531165109.8476-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdsrlxivdtqrlhbd"
Content-Disposition: inline
In-Reply-To: <20180531165109.8476-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdsrlxivdtqrlhbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 31, 2018 at 10:21:09PM +0530, Jagan Teki wrote:
> Enable AP6330 WiFi/BT combo chip on Amarula A64-Relic board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PL3
> - 32kHz external oscillator gate clock from RTC
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Move external rtc clock nodes into main rtc node definition
>   of sun50i-a64.dtsi

Please make that a separate patch.

Maxime
--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fdsrlxivdtqrlhbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsRYOAACgkQ0rTAlCFN
r3SKVA/+KSgS7Z7b+L0QfZp9WdK9q7N/y9YepzNqwqaP2dUVWJxhIgHHCioRV061
arjeqhLPNGZzJTeI7GL6HjH1Yhei2OnJp8x7bligc43SljoP3YXxEpYwsefd0clB
OGczLlpOFeitL+g+RoxSYRE2EfnAsQspCPum8NmKoIutHlInjrWaNr0mJB3XJg2t
YFv3KrxoFe4LNqKFw/JZAh7+MQLigoPGQgt0JsylwUjwjVPGnHHmPw5M6GbD2aTT
5mPG4AFxjUMe/O0kECk79HH/lAXyizPLcX9nUcj2dHwKY62aMG8TqNgwilKSQ03C
10Sll6+llRCbU9boZ4m5vlMOaUBhT7wkrdRCM35qIHUsuoqIjkP/ABz6rOXpVQD9
ittTpUDAc7qwk7vNHPIQ2NMJXWWOJRJfuktMOyNTBoGpUOifEJIidDlC2zYHUSP7
ia8T+LCQAEg6e3kyIuvxpkV8Ja65P4NtVCqy2DWHzdKzlGQWNCzEFvW/XUP1LPsi
0pnSNvfrnsPFycMUEUL1fEjoXdgtJY5QyxFVm229+c8Sp1epQ3d00+LnLHXhao6u
FAB02DXSLvMkB+8bKIBf+aD1VN2G47ijDAGJtTFphYx7plp4TkAP0sF0xNhKGdbA
xibHdgEEn89t/oEmmNRLLtGUWZJ46ihA2j1ZpC6mxJjOz5Cotoc=
=Kwbp
-----END PGP SIGNATURE-----

--fdsrlxivdtqrlhbd--
