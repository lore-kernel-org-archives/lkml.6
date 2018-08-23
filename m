Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE6FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4915521557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4915521557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeHWN7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:59:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53687 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbeHWN7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:59:43 -0400
Received: from tock (unknown [89.247.124.232])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id AA3E613F87E;
        Thu, 23 Aug 2018 12:29:23 +0200 (CEST)
Date:   Thu, 23 Aug 2018 12:29:21 +0200
From:   Alban <albeu@free.fr>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Alban Bedel <albeu@free.fr>,
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180823122921.6857d917@tock>
In-Reply-To: <20180821150121.4408672f@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
 <20180821133916.3a1c51b1@eos>
 <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
 <20180821150121.4408672f@bbrezillon>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/clJVj=KipsjMDyfNIMePBO1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/clJVj=KipsjMDyfNIMePBO1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Aug 2018 15:01:21 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Tue, 21 Aug 2018 13:00:04 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>=20
> > On 21/08/18 12:39, Alban wrote: =20
> > > However we still have the a potential address space clash between
> > > the nvmem cells and the main device binding.   =20
> > Can you elaborate?
> >  =20
>=20
> Yes, I'd be interested in having a real example too, cause I don't see
> what this address space clash is.

Let say I have a device that use the following binding:

device {
    compatible =3D "example-device";
    #address-cells =3D <2>;
    #size-cells =3D <1>;

    child@0,0 {
        reg =3D <0x0 0x0>;
        ...
    };

    child@1,2 {
        reg =3D <0x1 0x2>;
        ...
    };

};

Now this binding already use the node address space for something,
so putting a nvmem node as direct child would not work. Here it is
quiet clear as we have 2 address cells, however even if the number of
cells and the cells size would match it would still be conceptually
wrong as both bindings then use the same address space for something
different.

Alban

--Sig_/clJVj=KipsjMDyfNIMePBO1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfoyCAAoJEHSUmkuduC2831EQANEODpUrKPBwoUPR5kK9+xS1
1qpoYGYl6TM2lHAEP7nZP+eNv3rOyBncZoiuVAIAIqYi2cJ1eyury5lRDpgIpZaH
hYDSyeBefkS/qFTH91x3+CYq5wK8uPKEFoDJcAmj0jDw+dEGk9xRohWF0rSR5AVv
IKVtiDByjgCLlNBCmzOe9GAxEU9hSZVRck3u84NA9HlklZ+P3dbEotpRkt3c9qsZ
3HlckafnYuWs3gFW+HP++oALuUa4X7iqHTNi2Wubj/G0K30vhOrSAgCpQty5TqWF
iYiZq/zfZqDJlDkWOYkW9lSdF0tGlCgfsVOrxG5ByG5jMMtW5B7QREyZrBmQzcuz
kIoerm0mjZYCfev2rkdtw0FZWXQdDGp9Rjy28B8RnnSMjR3cljid3wyWRZRhtnOY
6QuHDQ7D5ncqn9LiZIAj4Th6RKgxxd4F7iNDLMY57+GmMVeqdgXJr/vWMXUy+KEu
k9xO3xr+7l7wy23C35vGw+IK2Y9mrWyuchUNF+waa3gUL2L9ufugB8l6Yp+4OjRx
ur16kOtTg4ZTYeRryImv8FLrjjm3FT81aKwZthoLL5W4Wxh5WPU0oMe2YWcE7g/G
K6exE5qdZ285k3uHVgvqXH4SZTcjkqonJZ59Xjl5lb/NWhvMrAY3nXzUH1roM863
jpGm3PZXS4uPr9TwgjAK
=952h
-----END PGP SIGNATURE-----

--Sig_/clJVj=KipsjMDyfNIMePBO1--
