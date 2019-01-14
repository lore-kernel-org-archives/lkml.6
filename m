Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF28BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86977206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfANSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:38:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:54671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANSif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:38:35 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBdv-1gVeKU1QzH-00F7j4; Mon, 14
 Jan 2019 19:38:33 +0100
Date:   Mon, 14 Jan 2019 19:38:32 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpio: hlwd: Add basic IRQ support
Message-ID: <20190114183832.GC22334@latitude>
References: <20190113135844.13109-1-j.neuschaefer@gmx.net>
 <20190113135844.13109-2-j.neuschaefer@gmx.net>
 <CACRpkdYyMwu+hFQF4PUSb8N8zo3QEFt5=curhsdTFP1FCtGpNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <CACRpkdYyMwu+hFQF4PUSb8N8zo3QEFt5=curhsdTFP1FCtGpNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:U3pQZhgrR/R8GbiDLLyrPvJoDdcjcoPisdXaphTe7zmHiefYnhx
 zP+P7yVGGlsk8tSGGGhwMVuUzT94s0PhgToCjaCpcB6Vi3lVrjPxwlH0jUuh2uHcVS02Loq
 pPibKk/33GfOBze8LrQh0U5TYG0iZ8QoUBZh+m/o7vdyF7m+0rGcD8dxJIx8zaDWEj9Wc03
 LBVUDAdXRazVKqtDIfi5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qxADPsZgf+I=:sJQ+f4DvqzU1hwreuyYsxv
 /4XU+oAXaNuFJ2ZXB/2xMizWqTRYlDwrxEhIdZfdFOoZrQI1tONSnIJMIo4F7k/W7rjvWqb+l
 +pbx+Lyi9Xzdc506E+LsgPfQRcjqYEM7iOswNewi1ovn756T4GJ55F7bKaTVvDTqVhNiaiMeV
 fUV50Gh/N8Me1azzEZR7bw/VdACegM+o8IONsuUYvFRXgWgH6rWxFu0XXIzuNOtKi8ABgYtbd
 9+axMAprZg1tWrfibuHHaAiMANEqsEdOKyR2oyapBkdQs+NU9i98GCXJeHS3MzDNQj7eR4FNL
 I0qlIrBFykZKVD9bkUicEZLKnneMb1E6FdWlhUKgxY8wpfyFDT4PwkmLkjxecTBOYmokTNvbu
 T1ltvR2AWOFGKszLc7De2DT0VbAF4w0UzWViMgu76msQijsvXwwAuj+zSbwMmnC3zB43PpfM3
 Bzt143g+DERCJLYdUU8ASgzYgoMSfX0dEjtEKXY3e3pbQ32RqWamuGoVDHrxyDhQGzHP11pCl
 7/lHpiPDeqyYG0Rse0J+ikIXspPcGq+fFZa6kly4HINFGvqQwDHkYoJbX9tFUg1ZX5cXDa771
 3g0GJddfASG0dxyHFS1+rhosT3uA4W5cI6BA7snPpKIW0444wK7phWy3JjEpbRHjIPHy9WvSl
 YcYRIFf0VBaOfH8281lYvDeEFa4kv0JKhwMjsc6qdtVziW1Oh9gyxllWH2ifLdjxlRkpKsMIN
 IEqjCKLv/1K/Q9Y9M77bjzh/jRZ/cw3l3B2Z65Wy6KgRTLUW7Uj/ppe6PgTfsxgAwyi+pY07p
 1zzEny0bCKZKd0NoT3Y9VXQskWumf9QcUhvHg0l7vC3pQpGmnTw+ZkugFawP+FDlrBjYWNN8a
 HJKHNzFL/CMJAUNrnpR0uonq2qq8Nf5GCYozIjNSY2BhNSAiytrpDweDmQEsZl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2019 at 11:20:49AM +0100, Linus Walleij wrote:
> Hi Jonathan,
>=20
> thanks for the patch! It is looking very good.
> Some minor comments:
>=20
> On Sun, Jan 13, 2019 at 3:00 PM Jonathan Neusch=C3=A4fer
[...]
> > +       spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
> > +       pending =3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTFLAG);
> > +       pending &=3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTMASK=
);
>=20
> Please just access IO directly instead through the helper.
> ioread32be()/iowrite32be() I suppose?

Ok.  Yes, 32-bit big endian is correct.

[...]
> > +       hlwd->irqc.name =3D "GPIO";
>=20
> What about using something device-unique?
>=20
> hlwd->irqc.name =3D dev_name(&pdev->dev);
>=20
> for example?

Good idea, especially considering that the Wii U (the successor of the
Wii) has two of these GPIO controllers.

> otherwise it looks fine!

Cool, I'll send a v2 with these two points addressed.



Thanks,
Jonathan Neusch=C3=A4fer

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw81x8ACgkQCDBEmo7z
X9v8VQ//RWS8DkzWf3ymr3emRhbyPFiKaoZLgeFMZ4O66xHNeSmlTsS0kKe0kqRE
BTNtPodF3OeJyf5xH0shvWSZ5r+3rdxeOEVaRf2/MfCJIA0KHiCU3siflmzHTcL9
U8Ik+xeqew/x5klPefxg+mhnuYV0nygDjdZL0YvoYsQaPItNozXLr3h5pft6hfOz
hUhl7TKg/kLN7/hri2QM9SUzFnrc5TXgUGXcWq3ExEaY9As15i+hwhK16rXokQnU
gN/qbaCgzgpgg+Gpt3WBJMVfZNvMaiZYscnplA6OlFu/aFHP1VBSj0acidWD2HpP
eWygJXGM/OnBpLwjSrin+46rul43Bv2/8AdyGJWnMOPiPbkuJzSmyLXZkW9UG/Iy
1OpZ8Yn4bNuQ8jcoOYFaMvRaUUjRUfXkC2drECBF0MwzkK/mUEVqS/Io7FusIVo3
aIS35Mv0wd35bX4dvviszNVIrz9F5vOwfH/Ho5NYZ3V9+iV8eZF35pRonRe3SyPe
Ul8w11e2/Dhm7jS4OebveghSEopmewCRQ2VkOaW2vdQywg87IS7KdWR2o47JILS7
t8P7csw+jRP/5ORCMQPbZeODMH2pLI0AZofklnIc0ShjN9UhHLLcdwlAeTFxA405
7ve9tPxRfR/fQkUDGoGsBF2DAA8y7bvOokLp9/NS8BhcHywnX6I=
=yBbl
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
