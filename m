Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FFFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DDD206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DDD206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeJETeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:34:46 -0400
Received: from sauhun.de ([88.99.104.3]:39090 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:34:46 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id BE44C2C146C;
        Fri,  5 Oct 2018 14:36:12 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:36:12 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoyou Xie <baoyou.xie@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mail to Baoyou Xie bounces, so remove
Message-ID: <20181005123612.GL5433@kunai>
References: <20181005123021.13364-1-wsa@the-dreams.de>
 <CAMuHMdVw0RDa+dqTkN7fk1rfi-=aoDx8JdoEz2QxRQMZDd2DOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVw0RDa+dqTkN7fk1rfi-=aoDx8JdoEz2QxRQMZDd2DOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 02:35:16PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Fri, Oct 5, 2018 at 2:30 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > No activity since late 2017 and I couldn't find a new email address.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >
> > This patch can be happily dropped, of course, if someone knows a new
> > contact (and assuming still interest in this maintainership).
>=20
> I found a recent bug report sent from Baoyou Xie <baoyou.xie@gmail.com> (=
CCed).

Great!

>=20
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2263,7 +2263,6 @@ F:        arch/arm/mach-pxa/include/mach/z2.h
> >
> >  ARM/ZTE ARCHITECTURE
> >  M:     Jun Nie <jun.nie@linaro.org>
> > -M:     Baoyou Xie <baoyou.xie@linaro.org>
> >  M:     Shawn Guo <shawnguo@kernel.org>
> >  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> >  S:     Maintained
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3WrwACgkQFA3kzBSg
KbYPXw//Yvv2oDcAWcr8n6VOYWqG/h0LZf72HdN+vN8mZ3yRboDHYi41TXP+cZsW
p9s4K8A9W/N3GXXTOgn2oCKtW3LdwfsYF+eWJYfazLxK2LHiFjnSo80JS123d+//
7cXFkNXqvHGuidtis/3jgHYmQRaDaDlphA9Kj+gtORmkyUYQ5KSPlC+r/icP7asg
9S7/LYwmJx6q9a7Qu0IGhSuyaJc3aM9ThJJTVRI4REc5xajIveRc5wgLoO6VAQTd
jeI34cHzd9k5/XHvbtXZMWNQxNHsCgn7RH3K7RcRe8892IR5LHMIEFoZf4jwXkZj
JA0YKXkWzNE82lgikFr2zCPmX7z11P5NJOvUx2qG5z97DL3M5ncO00x2i70h2qWI
U2gT2aPAsKxL1e77XL/Zkv98YlDMcwn44GUguJ9iru/dXp7jJb1LoXZb5scDQk51
Ep2Kh23jPGCDoI+VLXkhYWAeoNONncaq9x/FPMFLt5EDjJTY/AGTrYRNjWSiqQmz
WwA8goUBl7yxYEDdHPhyNOyLdwqN67AJqs6kegoVloahLzpz/lS70Qsz8UaqzVna
nynPuslA5VywEO8MtFiqbo29T34r1XM3udWdFq1skg/cNyqrubv+vR5rPrcO0Sg3
dvY/tAD4hx9Gd/se1+aH25v6QqdpjvVFIKRz9FARXlCeAElzEyk=
=xeu4
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
