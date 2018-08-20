Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA841C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7442174D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7442174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeHUAq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:46:29 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:50715 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHUAq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:46:28 -0400
Received: from tock (unknown [89.247.124.122])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 01E87B00548;
        Mon, 20 Aug 2018 23:27:51 +0200 (CEST)
Date:   Mon, 20 Aug 2018 23:27:48 +0200
From:   Alban <albeu@free.fr>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Aban Bedel <albeu@free.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180820232748.608c3667@tock>
In-Reply-To: <20180820202038.5d3dc195@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x7JZOIPlUQW1dRdErBSmNuH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x7JZOIPlUQW1dRdErBSmNuH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Aug 2018 20:20:38 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Mon, 20 Aug 2018 11:43:34 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>=20
> >=20
> > Overall am still not able to clear visualize on how MTD bindings with=20
> > nvmem cells would look in both partition and un-partition usecases?
> > An example DT would be nice here!! =20
>=20
> Something along those lines:

We must also have a compatible string on the nvmem-cells node to make
sure we don't clash with the old style MTD partitions, or some other
device specific binding.

>=20
> 	mtdnode {
> 		nvmem-cells {
                        compatible =3D "nvmem-cells";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
>=20
> 			cell@0 {
> 				reg =3D <0x0 0x14>;
> 			};
> 		};
>=20
> 		partitions {
> 			compatible =3D "fixed-partitions";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
>=20
> 			partition@0 {
> 				reg =3D <0x0 0x20000>;
>=20
> 				nvmem-cells {
                                        compatible =3D "nvmem-cells";
> 					#address-cells =3D <1>;
> 					#size-cells =3D <1>;
>=20
> 					cell@0 {
> 						reg =3D <0x0 0x10>;
> 					};
> 				};
> 			};
> 		};
> 	};


Alban

--Sig_/x7JZOIPlUQW1dRdErBSmNuH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbezJVAAoJEHSUmkuduC28QU4P/3pQiuQbGP9YNsymN3BmbTvP
lreiY+6pCAVvk66pR7GcuW4RurUzlj6FunpMY5XWQOkNDQcceLn6rmS51Ga7Xz+s
c7hwUVgd4XByw2REWTAKNo7ygY8gndcMoQ8AzpPGBjGYSN5lp2hrdhvu6FW6DzWe
8Erm3Xdue074z9ag7LMpQnV0ZURoQeUbEsBgaXbrMCmrYabG6Ahr5/YmyaGavM5H
O5sM2yQa3b+MfVxFvAyrDmrPm/onIAZSs8Mh6Z33CJZHeZOfofYD74iJRB7mNnCJ
oy+xu/BYJ2e7/AX595+T0uCG+5IwG99t6oFoqMkKeqKVkv8wzSlQfYJC8t8d5j4f
IgBydMh+sXDvYGp4ftWFTNLbe6exnISxMSiN8VJUHZPj9sC1RDGA3JFs7oMCCsPv
ctZ7jboJ0U0T1GP3R+67KX4qOh3jgcMvFwZvzCZEvXVaIbCaeNco4Q0MVtdRL3yi
6gD2GC0iS/lYQji3HofodBhSfB9JH4GDwDgT8u2WQ4ZT3fDrp/53pvcHwcZ5rl7o
bxofjh4BYDBNh3eJ8nb5KQeqPvuLZhXi9StmOasBu8IsYAHf/ryGmXhcZJuO21zZ
ywcUVHIGvmNthSrs2gdmVO6FzpjQfP6Qz9T0lhd/RMxj5/BXYf8CtP84mNq+MUge
x387wEAOzjA+iSFiQynX
=RS6x
-----END PGP SIGNATURE-----

--Sig_/x7JZOIPlUQW1dRdErBSmNuH--
