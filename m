Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeE3Mbb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:31:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:10929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbeE3Mba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:31:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="asc'?scan'208";a="45916173"
From: Felipe Balbi <balbi@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
In-Reply-To: <20180525160729.92026-1-arnd@arndb.de>
References: <20180525160729.92026-1-arnd@arndb.de>
Date: Wed, 30 May 2018 15:29:31 +0300
Message-ID: <87o9gxcono.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> Without that option, we run into a link failure:
>
> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_r=
equest':
> hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
>
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlsOmSsACgkQzL64meEa
mQYpww//bW0hiy5g1A740zHe4YOPu2u2iAT6MnYfmvEBKgqd0klf2HA28+Sn3+se
zc6flrbIEQjUUGZY72fz8/sAl6JjjLX2O3GAV68UIy/YgXD4LNSels6Q8J+ybjFS
1xH6g/25c+jIqj2KGbEHY9rpU8GiEQPWJyuUPDQXBA2ye2VHaJmJsVG7/WyHaZbk
F3wVKtSUMkRjqdTgmcsiaGbu08EdnaYLUB+CKP2671ICOs5s3iEcS+F7RBze8b31
Sq+XY80wybHWUmEiLzd6efzLlyWNFY4Z5JLFbVdgGEiTnPCJMCD3QSbYKIKkp6HE
qijCOs/4VU3TdM/32qrbErmqZrM+82mstZ8TIhEjkQaG2yGeslB379+En6E8APNk
uDTCRORyLzsLihdfxGPmlAo/ou9UIKJmid6V5L4hEGixfranxRwsQbbvXLoju88w
GKpVcTjjRNh9Iiu5y5J2gFikontlXGgRRigKXmgDNH7s4sOrpfOmmucKMMU5PbS5
8se5ZWH0gtUVA6Lx19hPbn0rCPCBQUV8MmWwbIc6VTuyyHNSArmsudQMUd2AJrA2
nAg5yJ37cHlsnb0T4CZsNiudLUoSmONJ4fa2t+Ba6DDT9ViR3pRGtb6xdfXPpdpK
6b4TsX86/P4bhcrGLa7QPNraYId60VgnX/sZ/GXkmy2la2nItus=
=skhR
-----END PGP SIGNATURE-----
--=-=-=--
