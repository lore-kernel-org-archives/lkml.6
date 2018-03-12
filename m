Return-Path: <b.zolnierkie@samsung.com>
X-Google-Smtp-Source: AG47ELsf/OGax9ARD6rEdGCLcINqUclwmVhZvnrrd4PbdR4Z/YgPKm8pGjOa4vkrYq/7F6fQwv9E
ARC-Seal: i=1; a=rsa-sha256; t=1520863584; cv=none;
        d=google.com; s=arc-20160816;
        b=XxZSr41SsdaUWJyEUPG0iFzryMfUA/M4x+tY1bANrM/zlFO09e3bAte0NAXZqNhqll
         cfv6XznLgm87VteIxVMy1EtJ6Gk8nGTWmyaqx+OQuQJ7ckq5L6GaenTBuQdFlZRNr86u
         EpI950mRLW13RMux2c2cAwPmrAekQqetJy4R7SCZAtpFKYoKxl1BXtuDhIWbVfdGIQAm
         u5HTt7AP9DGXYIEJD4Lef/sDRXsBdRL6W5XW935PtTHtXycGvmetz87jMES8N3KkAUuz
         CD5aZtiNWWuJJsZeNr+IAA4esPFKoTDPQ/oL9pX/JN4s9ShmaBe5BTGPCXWdH+a7JKID
         n4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:mime-version
         :in-reply-to:user-agent:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=H4Kw98VFcYEHxfPXww0A28t9pfjdaEXD8B8xN2MrQgc=;
        b=dizr1QD17eyIidWMw07aa8eQ873Tbc4dSFJcNt3k96iLFEUmwW7kXhO/9AmgbrCLU/
         y3PQzG4MiU+4jzthswwnnLrnqsjPksWp7BC+x+b9/358jCT5DBPj6+wFd3UI8rJTF8zI
         5FeujF2RAj6Qa0IIhTNtGe+/iphix4jxOnDbHt04oOdnfaGGtCTXZArGo37OBoGcj5/R
         oxLK5hqfQEXK74EglgK13WEHiW0YSI2BaUtYaF/O//1mpauRh9q2rYEjwT/HgLp7eDMZ
         Vdd7zCIV/YJcAvEonZqt0uvgy/f1jsnrL5P4jqi1qM11DRoQjEdK9iJH6yUZqkjIs/i7
         97og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=re0F2vax;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=re0F2vax;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180312140621epoutp028644b45bc29acd417ee955316672d663~bMV6bNiqL3199431994epoutp02R
X-AuditID: b6c32a38-adbff70000001054-a7-5aa6895db9de
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Kees Cook <keescook@chromium.org>
Cc: Joao Moreira <jmoreira@suse.de>, Greg KH <gregkh@linuxfoundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML
	<linux-kernel@vger.kernel.org>, Daniel Micay <danielmicay@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] vgacon: fix function prototypes
Date: Mon, 12 Mar 2018 15:06:12 +0100
Message-id: <4831767.IeJWIvYDSU@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAGXu5jJBQPPv1jr85wFFKAuLtacMWk+_P-=Yi0UR=E9yJ7nkow@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset="iso-8859-1"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCmnm5s57Iog10XxC1u/TaxaF68ns1i
	eccMVosz3bkWSz/9ZrM40feB1eLyrjlsDuwesxsusnjsnHWX3WP/3DXsHis7H7N5bD5d7fF5
	k1wAWxSXTUpqTmZZapG+XQJXxowZU5gKnopX3J03ibWBcZ5QFyMnh4SAicSBp5PYuxi5OIQE
	djBK3F0+hxnC+c4o8f31ahaYqhXT37FAJHYzSrzb84sJJCEk8JVR4tbmQBCbTcBKYmL7KkYQ
	W0RAVeL7pWZmEJtZ4D2jxJnr+iC2MNCg/3/OgvWyANWcPP6WDcTmFdCUONJ9FcwWFfCS2LKv
	HayGUyBY4s3rd0wQNYISPybfY4GYqS3x5N0FVghbT+JKwwmw4yQEDrBJvP7SyA5xtYvEnq+3
	mCBsYYlXx7cAxTmAbGmJS0dtIeqbGSW+7djDDFEzgVFiz3pouFhLHD5+EWoBn8S7rz2sEL28
	Eh1tUCUeEt/W74QGkKPEh6190GC8wCgxYdpa5gmMsrOQ3D0Lyd2zkNy9gJF5FaNYakFxbnpq
	sWGBiV5xYm5xaV66XnJ+7iZGcKLQstjBuOeczyFGAQ5GJR5eg+ZlUUKsiWXFlbmHGCU4mJVE
	eO9oAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzBgS4RAkJpCeWpGanphakFsFkmTg4pRoYKyU2
	Rz7qZFCK9+t6tuCnj8f8JKc15cEHGE+ueyhslXnH6LA/h2TSnKuq7BskspO4ut4EWR25JnL6
	6Wm1Eudrbydqhn1IzVnrw/bwfmShX8Ep+e4+9ZdZD4+dO3nildTKqQlSPvvXnb3H6yule1Qx
	wsD218ll057+kLi28NKT3mDtz8n/7e/PUWIpzkg01GIuKk4EALBiyX8QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t9jAd2YzmVRBgt2a1jc+m1i0bx4PZvF
	8o4ZrBZnunMtln76zWZxou8Dq8XlXXPYHNg9ZjdcZPHYOesuu8f+uWvYPVZ2Pmbz2Hy62uPz
	JrkAtigum5TUnMyy1CJ9uwSujBkzpjAVPBWvuDtvEmsD4zyhLkZODgkBE4kV09+xdDFycQgJ
	7GSUWHPpKQtIQkjgK6PEoY5iEJtNwEpiYvsqRhBbREBV4vulZmaQBmaB94wSM97sYQdJCANN
	+v/nLBOIzQJUdPL4WzYQm1dAU+JI91UwW1TAS2LLvnawGk6BYIm9/54yQSyrkeif/4YVol5Q
	4sfke2BHMAtoSzx5d4EVwtaR6P3+jXkCI/8sJGWzkJTNQlK2gJF5FaNkakFxbnpusVGBYV5q
	uV5xYm5xaV66XnJ+7iZGYGhvO6zVt4Px/pL4Q4wCHIxKPLwdrcuihFgTy4orcw8xSnAwK4nw
	3tEECvGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cDoVGCe
	Mic8xnRqheEP+er1N2X9BCOqOJX007z+bj+5tUMzt+av/SvDTQweSV8SVP491nCb4PDrLevj
	xuk7mmZenDGpxstC+HNme46azdkrVdJpmbsX5Nk4ZCUqdqy4telkH/OBLwttyudICwuv3Saw
	9ZjXoZ1tTPNUr4ge4n7fk7nldlb9HnMlluKMREMt5qLiRABJZBioaQIAAA==
X-CMS-MailID: 20180312140620epcas1p10db98576017a2e4ef9a6ada74eb5daf0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180312140620epcas1p10db98576017a2e4ef9a6ada74eb5daf0
X-RootMTR: 20180312140620epcas1p10db98576017a2e4ef9a6ada74eb5daf0
References: <20180310064059.12720-1-jmoreira@suse.de>
	<CAGXu5jJBQPPv1jr85wFFKAuLtacMWk+_P-=Yi0UR=E9yJ7nkow@mail.gmail.com>
	<CGME20180312140620epcas1p10db98576017a2e4ef9a6ada74eb5daf0@epcas1p1.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531866995400675?=
X-GMAIL-MSGID: =?utf-8?q?1594741053566168916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

On Saturday, March 10, 2018 07:27:21 AM Kees Cook wrote:
> On Fri, Mar 9, 2018 at 10:40 PM, Joao Moreira <jmoreira@suse.de> wrot=
e:
> > It is possible to indirectly invoke functions with prototypes that =
do not
> > match those of the respectively used function pointers by using voi=
d types.
> > Despite widely used as a feature for relaxing function invocation, =
this
> > should be avoided when possible as it may prevent the use of heuris=
tics
> > such as prototype matching-based Control-Flow Integrity, which can =
be used
> > to prevent ROP-based attacks.
> >
> > Given the above, the current efforts to improve the Linux security,=
 and the
> > upcoming kernel support to compilers with CFI features, fix prototy=
pes in
> > vgacon console driver.
> >
> > Another similar fix can be seen in [1].
> >
> > [1] https://android-review.googlesource.com/c/kernel/common/+/60201=
0
> >
> > Signed-off-by:  Jo=E3o Moreira <jmoreira@suse.de>
>=20
> Whoops, I missed this one. :) Thanks! Greg, do you need this resent
> directly to you?

I would prefer for drivers/video/console/ changes to go through
fbdev tree (like suggested by scripts/get_maintainers.pl)..

However since Greg has already merged your CFI patches:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> Acked-by: Kees Cook <keescook@chromium.org>
>=20
> -Kees
>=20
> > ---
> >  drivers/video/console/vgacon.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/video/console/vgacon.c b/drivers/video/console=
/vgacon.c
> > index a17ba1465815..f00b630f6839 100644
> > --- a/drivers/video/console/vgacon.c
> > +++ b/drivers/video/console/vgacon.c
> > @@ -1407,21 +1407,29 @@ static bool vgacon_scroll(struct vc_data *c=
, unsigned int t, unsigned int b,
> >   *  The console `switch' structure for the VGA based console
> >   */
> >
> > -static int vgacon_dummy(struct vc_data *c)
> > +static int vgacon_clear(struct vc_data *c)
> >  {
> >         return 0;
> >  }
> >
> > -#define DUMMY (void *) vgacon_dummy
> > +static void vgacon_putc(struct vc_data *c, int a, int b, int d)
> > +{
> > +       return;
> > +}
> > +
> > +static void vgacon_putcs(struct vc_data *c, ushort *s, int a, int =
b, int d)
> > +{
> > +       return;
> > +}
> >
> >  const struct consw vga_con =3D {
> >         .owner =3D THIS_MODULE,
> >         .con_startup =3D vgacon_startup,
> >         .con_init =3D vgacon_init,
> >         .con_deinit =3D vgacon_deinit,
> > -       .con_clear =3D DUMMY,
> > -       .con_putc =3D DUMMY,
> > -       .con_putcs =3D DUMMY,
> > +       .con_clear =3D vgacon_clear,
> > +       .con_putc =3D vgacon_putc,
> > +       .con_putcs =3D vgacon_putcs,
> >         .con_cursor =3D vgacon_cursor,
> >         .con_scroll =3D vgacon_scroll,
> >         .con_switch =3D vgacon_switch,
> > --
> > 2.13.6

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
