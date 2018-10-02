Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C11C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90DE206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90DE206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeJBT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35868 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbeJBT4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 89FA4207CC; Tue,  2 Oct 2018 15:13:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 59C622072D;
        Tue,  2 Oct 2018 15:13:12 +0200 (CEST)
Date:   Tue, 2 Oct 2018 15:13:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rodrigo =?utf-8?B?RXh0ZXJja8O2dHRlciBUasOkZGVy?= 
        <rodrigo@tjader.xyz>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
Message-ID: <20181002131312.soqwybsohdifvso3@flea>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
 <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
 <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea>
 <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a2jg223ixwczhtcz"
Content-Disposition: inline
In-Reply-To: <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a2jg223ixwczhtcz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2018 at 01:51:02PM -0300, Rodrigo Exterck=F6tter Tj=E4der w=
rote:
> On Sat, Sep 29, 2018 at 12:47 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 11:49:20AM -0300, Rodrigo Exterck=F6tter Tj=E4d=
er wrote:
> > > On Thu, Sep 27, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Tue, Sep 25, 2018 at 02:47:59PM -0300, Rodrigo Exterck=F6tter Tj=
=E4der wrote:
> > > > > On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@boot=
lin.com> wrote:
> > > > > > We can't really do that, unfortunately. If the device tree name=
 was to
> > > > > > change for a given board, we'd break all the build systems, boot
> > > > > > scripts and distros out there.
> > > > >
> > > > > What if we keep the device tree for the version without WiFi and =
eMMC
> > > > > with the current name and create new device trees for the other t=
wo
> > > > > versions?
> > > >
> > > > Wifi and Bluetooth should be dealt with with overlays in this case,
> > > > and since the eMMC is already enabled, then there's nothing to do, I
> > > > guess.
> > >
> > > It's WiFi that is already enabled, not eMMC. Only one of the three
> > > variants has WiFi.
> >
> > Ah, right, sorry. In the board that doesn't have an emmc, are the pins
> > usable for something else?
>=20
> I don't have the variant without eMMC nor could I find pictures of it.
> The schematics do mention that the A64 pins could be used to control
> NAND flash, but you'd have to solder that yourself.

Ok.

> > > We can't even remove a node from a device tree? Removing the WiFi node
> > > from the current tree would make it correspond to the variant with the
> > > least features.
> >
> > Not really. How pissed would you be if you were a user, had wifi
> > running on your board, you upgrade your kernel, and then it's just
> > gone? :)
>=20
> That would suck, but what about someone who has the board with no wifi
> and problems start happening because the wifi is enabled on the device
> tree?

Did that happen or is it a theoretical issue?

> > > About device tree overlays, I read overlay-notes.txt, but I went
> > > looking for an example with "git grep /plugin/ arch" and it came
> > > empty. Is this approach not used for other boards?
> >
> > It is, it's simply not stored in the kernel, but through other third
> > party repos.
>=20
> So that would mean that it's up to every distro to support the boards
> instead of relying on mainline support?

Distros would have to integrate it either way. One would need to
detect and / or ask for the board variant in order to load say the BT
stack, or to know if you want to boot from the eMMC or from the SD
card.

> > > Does the overlay approach make the device available at boot time? That
> > > is important for a storage device such as eMMC.
> > >
> > > I went with the separate dts approach because that's what I saw was
> > > done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
> > > and its variant with eMMC, among others.
> >
> > Yeah, but in all these cases, it was done from day one, not after the
> > facts.
>=20
> For the LIME2 the dts for the emmc variant was commited two years
> after the base LIME2 dts.
>=20
> What if instead of keeping the current dt for the least featureful
> model we keep it for the most featureful model and create new dts for
> the two less featureful models?

This is a different story though. The LIME2 eMMC variant was created
way after the original LIME2, with a separate name.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a2jg223ixwczhtcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluzbugACgkQ0rTAlCFN
r3TZhRAAmuF5QybvqGWs7s0VgT/GzcpRGvF6kiXIISdlS2dUyOYfN6+B8hFjlC3y
uNcbhBTRRExSF8V1ejlVSb8eBCsegyGYDzm9wZ9u0ypUf6XpRRey8FeMtAB+igb5
o7hmtFqlJAzQg3s20hGcQ1J+nB+g/EHfxfpxrCN7Sx0hBkcczETF7aRLT7XzUR//
Lt0i53xnQprL1bm91Fr3uS1g93r2Onv7Li/UimOlOWo9m1TYXrbfJbcQP+pDvYgN
nz/MVjFYbzel/m5mDUzdUX9FWibovvSq10sTkV+sWnyyP0RyVljehizJsPYifYP/
osnTWbM7evGkQVaLs7n5zrJpHW6aOKIms0XYxSFpMkKA6OXEJ1npwUQry9/rHFfQ
pt7d3Aw/9b9dmyaNrHnSj/7g8a0AfkzLZAfrwrVeAGuVIu1rYDH5o3aQRnUSW9l9
Wgyqz7IfRdosjaYmJDiHC4Sc9sY1rYeQIz3o4pi2LqgOFWl1EpATW3cB0xTqKx8k
AfEYaa0DCawB/9iTpSX8a+NlILLdfD7AAOjLyE7rkduu49N+tCfNi9KxZ2QojoZk
r6IX0IWlAdr9hJ2+QBq73YsKLg0WZDbazBP0HsurDe2tfxCzkyMsHtieKlCado0v
LN8lcw0cFlhGyw6v+dX7sd9EI40pEyJXn0yvGyIIOP5OosUa/L4=
=Xi7c
-----END PGP SIGNATURE-----

--a2jg223ixwczhtcz--
