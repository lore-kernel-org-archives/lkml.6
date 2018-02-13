Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965373AbeBMRnr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:43:47 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:42853 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965169AbeBMRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:43:44 -0500
X-Google-Smtp-Source: AH8x225e+70Ivx+ll1EJ35YKPqdYf+rklHK0I/1rcbrCO+fBxIp391Nt+VsYWhVtNSbcPvqB9h8NBA==
Date: Tue, 13 Feb 2018 18:43:41 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180213174341.abcjlfjymxbcz25t@pali>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
 <20180213085030.kiksdi2a7ksae5wz@pali>
 <20180213132726.GD5453@intel.com>
 <20180213133842.i5z5jj3sllorsy2w@pali>
 <20180213153654.GG5453@intel.com>
 <20180213160437.gy5luyygjvuktuqx@pali>
 <20180213161221.GK5453@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="36owxysgwas25iow"
Content-Disposition: inline
In-Reply-To: <20180213161221.GK5453@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36owxysgwas25iow
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 February 2018 18:12:21 Ville Syrj=C3=A4l=C3=A4 wrote:
> On Tue, Feb 13, 2018 at 05:04:37PM +0100, Pali Roh=C3=A1r wrote:
> > $ cat /sys/kernel/debug/dri/0/i915_gem_stolen
> > Stolen:
> >    ffff8b55bf17e080:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 1) (ggtt offset: 00083000, size: 00004000, type: 0) (stolen: 00001=
000)
> >    ffff8b55c2693040:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 1) (ggtt offset: 02b9f000, size: 00004000, type: 0) (stolen: 00005=
000)
> >    ffff8b55bf9a7300:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 0) (ggtt offset: 0f6b4000, size: 00004000, type: 0) (stolen: 00009=
000)
> >    ffff8b55a6161040:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 0) (ggtt offset: 0937f000, size: 00004000, type: 0) (stolen: 0000d=
000)
> >    ffff8b5563e0dac0:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 0) (ggtt offset: 0f714000, size: 00004000, type: 0) (stolen: 00019=
000)
> >    ffff8b55bf17e800:    g         4KiB 41 00 [ 0 0 0 0 ] 0  LLC (pinned=
 x 1) (ggtt offset: ffffe000, size: 00001000, type: 0) (stolen: 0012c000)
> >    ffff8b55bf02d540:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 1) (ggtt offset: 00141000, size: 00004000, type: 0) (stolen: 0012d=
000)
> >    ffff8b55c2989340:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 1) (ggtt offset: 00148000, size: 00004000, type: 0) (stolen: 00131=
000)
> >    ffff8b55c29890c0:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 1) (ggtt offset: 0014f000, size: 00004000, type: 0) (stolen: 00135=
000)
> >    ffff8b55c2989840:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 1) (ggtt offset: 00156000, size: 00004000, type: 0) (stolen: 00139=
000)
> >    ffff8b55bf02da40:  p g     14400KiB 77 00 [ 0 0 0 0 ] 0  uncached di=
rty (name: 1) (pinned x 1) (display) (ggtt offset: 0015a000, size: 00e10000=
, type: 0) (stolen: 0013d000) (p mappable)
> >    ffff8b556dfba780:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (=
pinned x 0) (ggtt offset: 0ad2a000, size: 00004000, type: 0) (stolen: 01655=
000)
> >=20
> > > likely you'll have the fbdev framebuffer taking up a sizeable chunk.
> >=20
> > Seems 14MB.
> >=20
> > > You could get some back by reducing fbdev depth to 16bpp, or even 8bp=
p,
> > > but I'm not convinced the fbdev gamma LUT stuff really works currently
> > > so you might end up with bogus colors in your vts with that.
> >=20
> > Ok, I could try it. Via fbset tool?
>=20
> Kernel command line. We don't allow resizing the fbdev fb once it's
> created.

Ok, will try.

> >=20
> > > >=20
> > > > [    0.000000] Memory: 7972840K/8282704K available (6196K kernel co=
de, 1159K rwdata, 2848K rodata, 1408K init, 688K bss, 309864K reserved, 0K =
cma-reserved)
> > > >=20
> > > > > The BIOS may or may not provide a knob to change the size
> > > > > of the stolen memory.
> > > >=20
> > > > In BIOS Setup screen I have option to choose GPU memory and I set i=
t to
> > > > max 512MB. So this is not the right option...
> > > >=20
> > > > And why cannot kernel use some continuous check of RAM itself?
> > >=20
> > > Because the hardware won't allow it.
> >=20
> > So it can be done only once after reboot? Or only prior to booting kern=
el?
>=20
> Never.

Never? Now I'm lost. Why then dmesg message instruct user to try set up
it in BIOS if you say it is never possible?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--36owxysgwas25iow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoMjywAKCRCL8Mk9A+RD
UpMbAJkBohPykjHUAY6fu51YkYdtlqE6QwCfeXdg/X5DSVoZbIYGA8HH8/vvRns=
=88wb
-----END PGP SIGNATURE-----

--36owxysgwas25iow--
