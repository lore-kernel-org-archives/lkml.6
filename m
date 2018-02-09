Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBIQ7N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:59:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:36465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeBIQ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:59:10 -0500
Date: Fri, 9 Feb 2018 17:58:58 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180209165858.ebm7ed7f4b5uakju@latitude>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
 <CAHp75Vf=Z7DTMvbacLN+E-hScBD3ZNpnf6Ch+5xm=JNbX2cbVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i7quqgrx7stws5lv"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf=Z7DTMvbacLN+E-hScBD3ZNpnf6Ch+5xm=JNbX2cbVg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:2fSTFeuf3tn0sfi5VBhwPZ29pJqZaZ++bpu6KzeNcCj+YxbEnBQ
 33jFsYNNZPZFdp4QE+9LXIgHjbaLBcKemT5PG/OIXw+/zvn6lSWFaHY78By0SuLeLe/eT92
 AFMdPubfCEsHw81+MBy17V3qGmfU+aa0QTLRCkqeLZAc8wkddp3TkmYrnVgfPPQkeprryeL
 I7OqcmHRJ0OU5a3NxVvcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DT5ASuMO/uo=:1+9htVVJN9brB6S/MbNyt0
 0yeaajFMM/Y4E3NGssd13/XwnJlDsdmNAVScGFB8VYyPze9vLvtCW4iAtuxu8fbEPHMO+IYZP
 kriP162yx0k/I+NczhoQ0fhsID1PPW0w27thosN7CMZ2YHHXAMwnxzu8XtRNrPAS6A1uIfJZD
 /zUrk1CWyd9ctw9Ny7E0mp0H+OIYEjaDPT7upbXaE6Cj07nboptAsLuJSSKKDXrCTF6yQLTZw
 06EsHFFFcJ6SHoXn01dQb29aXi9yK18L6qTmxPPs6Xk2hKrPOWPKwR/9Uweo3EYLPw9/rNRf8
 SesHgoXwGADinqM9ohNuP9hYq35n3krAYreevtYhIdIAiRO468m93Tu3Y4wbl6kmEeIg0FsZT
 m5EJ9+Ls7Zmi3buTBcg1ZI8IAZ9WAlSu7lewb5o7vDfXnpw3kYvmWZWPtfrqoCG7NwUAVy4DS
 uZoloi13oK8AyaRbS62ZsTJm9UhXfjrzYHP3/CW+yF4fjRqcJd/3AMCpYhl7GRegEL3wvkdB+
 +QiV8jQbg5+YAgyhhtULlzq31lqnU57dBsNCv39xn1tomfexLZ0rhgxSk5wuAhK056C4oLOpq
 oB4ur5lpMeTD/ln+59iJWPe+xTFTwnchIuH7nZ55TEnOlhNHQ5X09tmKXNfk75ldxDOQg6bus
 jkAklmSc/q5aMmIf5hhq34df8JlqQLuPz0NPfhmHYMzIrZk1PxiKERTnj3TEWK9O8RE5RlpP6
 8Sgseer3mNjPPGiZkVWv5JKlMH+ptek4f7B4lBKwX5/2S9SE1RzZC3tNnTJAubioo1+5gLNPz
 Jxlk9f1OAddFKHYkdKTi42KiQIWXw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7quqgrx7stws5lv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 05:30:55PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 9, 2018 at 2:07 PM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> > that supports a configurable number of pins (up to 32), interrupts, and
> > some special mechanisms to share the controller between the system's
> > security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> > not supported.
> >
> > This patch adds a basic driver for this GPIO controller. Interrupt
> > support will come in a later patch.
> >
> > This patch is based on code developed by Albert Herranz and the GameCube
> > Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> > available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> > has grown quite dissimilar.
> >
>=20
> Fine to me, though one comment below.
> In any case,
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you.


[...]
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index d6a8e851ad13..47606dfe06cc 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -229,6 +229,15 @@ config GPIO_GRGPIO
> >           Select this to support Aeroflex Gaisler GRGPIO cores from the=
 GRLIB
> >           VHDL IP core library.
> >
> > +config GPIO_HLWD
> > +       tristate "Nintendo Wii (Hollywood) GPIO"
>=20
> > +       depends on OF_GPIO
>=20
> You may get rid of it if...

[ Even if this driver isn't switched to the unified device property API,
  I think "depends on OF" would be enough here, because it doesn't use
  the code that's guarded by CONFIG_OF_GPIO (gpiolib-of.c), but this
  applies to other drivers (e.g. gpio-aspeed, gpio-bcm-kona) as well, so
  this would ideally be a bigger cleanup patch. ]


> > +       res =3D of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpi=
os);
>=20
> ...if you switch to unified device property API.

I don't think this change is worth making, unless/until the of_property
API is deprecated. I'm rather sure this GPIO controller won't appear in
an ACPI-based system.


Thanks,
Jonathan Neusch=C3=A4fer

--i7quqgrx7stws5lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJafdNLAAoJEAgwRJqO81/bixcQAIr1riJeusqVnVSqFoRF5AnI
E5rzLIjuyrWdakM/xRDFvHhKJs2CVNVWyzxsPefEfdYZjPx7jxy9g2ZC0fOR8MRd
F26NvxC6+x5piXsGXixyWdveWSe5ePsp041xQylW/6J8c9rWN6/H2K0PFaig/oEC
eRuzu3Ow4G4m6PHYDeiorz7CHZGKYF9bCqPxSXhJRL1GWv2eahlB6MHe+fnSxI/3
YogJGou88lMQryAG2zLy2JUuXMFR2wcixjso8Np9VwqQiTIWTr+ONqhMDx/P7rfB
IU1PW027x/571T7dC40jDrtGERe7IPtGtqx86qnO71cczBJFla6Hu8Tjdirs+haZ
+0AeTpshCXNEG2Hnb1FML9LzO5bMwTqMWFsF8loek4XtJR9/ZJ/xmLk6ieE1ShWD
+yjjgPpMoqeGFaCZkwzITFZ9XbUV51nuElSLWbwFjagUAzWx48G5/2iml6coFlCA
a4Z17JNZw9ue68es/nakJiwPiUpA7/73Ck8JzIq4AIXdW+Aiz8H72rnudqCX6qZ5
ccBbhW2VgAtSE7RYQqK6i6q09Y1RzheUqTwhcDIQ+kGAhWeGCG02mzOHcyUYPUGG
tsBoqPTeqibSkmo4ZMYTKDacXFq5MYdTZ5M/rxz+sXxLKVYFzNJwHbzvogCXom2G
6YvcnxSVm0mft+2eLQqs
=SLYv
-----END PGP SIGNATURE-----

--i7quqgrx7stws5lv--
