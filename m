Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeAaIh3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:37:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:60558 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbeAaIh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:37:27 -0500
Date: Wed, 31 Jan 2018 09:37:17 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180131083717.xhwaepwd6qxeqncv@latitude>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-4-j.neuschaefer@gmx.net>
 <CAHp75VcWshngZFuUp4hzYdD43HF7TZ1sRE3Dh+HckB5do1=gGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4afc2a2wktuivren"
Content-Disposition: inline
In-Reply-To: <CAHp75VcWshngZFuUp4hzYdD43HF7TZ1sRE3Dh+HckB5do1=gGw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:4qH1iDHxP2wgd0CPGWWv9OLYheSsvaBgwdmtFc7KphRE3W+WYB9
 Am8YBvQOyZDbb5jvqh63VyOP8Fk1FwLE8Osr21SFr6pSSWk9d+Ba2et1gsQaDPfoW2aEWNz
 1JR4R2bTwqPsznyLayHOm6HEdWYrI6V7GUNs6zBdKsVqdjuiobS4krKzWu5yvQb21VI7hcT
 Vd6D50HVSTHuPvynqZPOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RLjTi2SjzGk=:PL2K7NnyosrGGy4lLYhN02
 ERnE+JfrhSFUuTysIXGqwkQf28wJU/hzCCGL+IGa6KKX1wV7OIWIahcqxYgJbDDdnWTWVGVGZ
 nz/BruPgWSlxbN7ZiUuO4NzoIcSqXlupvpdZO1kUf+CV5ihWfAdh3ehEDJDtfjDDvrzErGMfT
 DrwsZ9jWX4iMfwqtMsj4vAhu4wwgbLuNefogxO8hTZih4p+57M+IDwlw7PtEu1Kzdxx1d8nvn
 RV5WWOlhYjFXCDgMBb+Smdg75ZnAnzAutmP/WgaRD7lFFVbrsjDUenZwvMQI37UA3rXoI0hUK
 CS0c4EfaSWrOxqCqkP+qmEj8GVntnKAE4PAfZrdDSHU51wMiNNVymHbPYwSCO/52b/lIIkgfx
 /wRnPbLu9njNHHeZi33Z12IaSo+meUQWWJcibefzU9RA1nF12IuoLGfy/fS/En+K/PTIdtsZc
 aezgt54a65TV1F9y/4znp3uloRJIv4avRv0mWpntek3HlZLVRFHQQOwhmV3K0dNW4sEmrwSbw
 ZuF6P9uN0QX+2W9omvJJZXSgo9CelSk1we4o+EaU8sxD8Z8nFdgljFs7WMNAcktYD3EY4ResH
 vFBcXombaV15BTAznzUqccc0ij0tVJViBkqub9A2BM50GwVj/2WQniVALEWZGtyBy4KBzSAOZ
 OsJAY7tybnLSS39UOEFxy4xwlHa0JDfSXF6cZxTHOnoDrQe56D1Kyuel7+udDd513kk4D2Fp4
 bM4ffm5vqkoSeWpDmJrXTaCj0G4CQmYoYEZStySljh02hOW08x1jgqIRuOTJqvTlzIZJC0wRp
 bGg7tiVMnuI+tGfPGyqmg4lHdzqJA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4afc2a2wktuivren
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 28, 2018 at 07:31:58PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 7:04 AM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> Style issues below.
>=20
> > +#define HW_GPIO_OWNER          0x3c
> > +
> > +
> > +struct hlwd_gpio {
>=20
> No need extra empty line in between.

Ok.

> > +       struct gpio_chip gpioc;
> > +       void __iomem *regs;
> > +       struct device *dev;
> > +};
> > +
> > +static int hlwd_gpio_probe(struct platform_device *pdev)
> > +{
> > +       struct hlwd_gpio *hlwd;
> > +       struct resource *regs_resource;
> > +       u32 ngpios;
> > +       int res;
> > +
> > +       hlwd =3D devm_kzalloc(&pdev->dev, sizeof(*hlwd), GFP_KERNEL);
> > +       if (!hlwd)
> > +               return -ENOMEM;
> > +
>=20
> > +       /* Save the struct device pointer so dev_info, etc. can be used=
=2E */
>=20
> Useless.

Ok

> > +       hlwd->dev =3D &pdev->dev;
> > +
>=20
> > +       regs_resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
>=20
> > +       if (IS_ERR(regs_resource))
> > +               return PTR_ERR(regs_resource);
> > +
>=20
> This is redundant. Below does it for ya.

devm_ioremap_resource does not check if the resource argument is a
negative error (which is what I'm trying to catch in the above code).
But it seems that platform_get_resource can't return a negative error,
so you're right. Thanks.

>=20
> > +       hlwd->regs =3D devm_ioremap_resource(&pdev->dev, regs_resource);
> > +       if (IS_ERR(hlwd->regs))
> > +               return PTR_ERR(hlwd->regs);
>=20
>=20
> > +       res =3D bgpio_init(&hlwd->gpioc, &pdev->dev, 4,
> > +                       hlwd->regs + HW_GPIOB_IN, hlwd->regs + HW_GPIOB=
_OUT,
> > +                       NULL, hlwd->regs + HW_GPIOB_DIR, NULL,
> > +                       BGPIOF_BIG_ENDIAN_BYTE_ORDER);
>=20
> > +
>=20
> Remove this extra line.

Ok.

>=20
> > +       if (res < 0) {
> > +               dev_warn(hlwd->dev, "bgpio_init failed: %d\n", res);
> > +               return res;
> > +       }
>=20
> > +       if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios))
> > +               ngpios =3D 32;
>=20
> A nit: I would rather go with
> res =3D of_property_read(...);
> if (res)
>   ngpios =3D 32;

Ok, I have no strong opinion on this, so I'll do what you suggest.


Thanks,
Jonathan Neusch=C3=A4fer

--4afc2a2wktuivren
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJacYAtAAoJEAgwRJqO81/bVJgQAL1/2rgESM4tkvX4NJOLl1yv
g01sSRRpfTSazmyCfLillW1n+cYVx2PVG0RWtwWUIqFUjqhQvkLETQGAhL2OUaWW
1K3UmpGnlJy2Yp/lqunk5VVKUt8N5CAxl3uABoiq9voryacDoA5qC7YoOwaGvpAl
6xGdL9HtHsRgziuSJrSl+bszeZnI2Q1k740t9TSwl14xGwUre3xjSDiXERlRupOM
yQq6WvS/RsWkpW+AaYqMGacSuozT0dR3zIVGOGTc/onCNkDKLSasbzyY2/qmyx79
zWINWza/AJnqWTuIZcUJPiODvYzBy9pg3l9hFJxrYwTpknbSC1vwFF9s3lh2Q9LI
isyl5u/UKu1nuuSetNF7FHBMKooVakWKPyS1fJ4LDSv3qgSxWkqTC6PbYKsdgy4B
oR7wy59l2hZLoShrpuF0ftTYeZ20Y7iBHG4o/Zu9PYBrKCS/sSLPBASV5ClfTyyd
WrRmw84ovfMMLuYjoyumAaLCUzBurpt5VHjkKtIpkrNtc8TEoZvMqW5mjLeRD8Rg
LMWfXi9jY8CAPsGfMU87jrd2Pdf1+QEOsROiFWIC7XpGs5wASEWySCI1+nylJkBE
GKg3NVdIbHU1XdPH6LKXAwjpr/yUtqYCHF8dmzDtHCenf6VXETaZ5qq7HpdAzyGT
21yVh2djBZ2XNXaucN+I
=K7YI
-----END PGP SIGNATURE-----

--4afc2a2wktuivren--
