Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDKJxg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:53:36 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40939 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeDKJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:53:34 -0400
X-Originating-IP: 2.224.242.101
Date: Wed, 11 Apr 2018 11:53:28 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        niklas soderlund <niklas.soderlund@ragnatech.se>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH v2 3/4] arm64: dts: renesas: r8a77970: add LVDS support
Message-ID: <20180411095328.GE20945@w540>
References: <1523357646-3946-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357646-3946-4-git-send-email-jacopo+renesas@jmondi.org>
 <0baa0f6e-f275-4a27-c76b-e4f8aec0b5f6@cogentembedded.com>
 <20180410121352.GD6436@w540>
 <9f54ba77-368f-3d0c-cb58-4849672af449@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BPjCafsbA2ap7OrL"
Content-Disposition: inline
In-Reply-To: <9f54ba77-368f-3d0c-cb58-4849672af449@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BPjCafsbA2ap7OrL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergei, Niklas

On Tue, Apr 10, 2018 at 08:12:36PM +0300, Sergei Shtylyov wrote:
> On 04/10/2018 03:13 PM, jacopo mondi wrote:
>
> >>> From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> >>>
> >>> Add the LVDS device to r8a77970.dtsi in a disabled state. Also connect
> >>> the it to the LVDS output of the DU.
> >>>
> >>> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnat=
ech.se>
> >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>
> >>> ---
> >>> v1 -> v2:
> >>> - Rebased on the modified endpoint name and changed patch subject to
> >>>   comply with other patches in the series from Sergei.
> >>
> >>    Stop, what was wrong with my R8A77970 LVDS patch, reposted on the p=
opular
> >> demand? :-)
> >>
> >
> > Nothing wrong, I found out about your right now.
> > I see a very small difference as
> >          lvds@feb90000 vs lvds-encoder@feb90000
>
>    Yes, I thought the latter was closer to a "generic" name that DT spec =
requires...
>
> > You can add your signed-off-by ofc if you think that's the case.
>
>    Didn't understand what you mean here...

Don't worry, I will resend this and use (part of) your series
[PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support

But please note that:
[1/5] from your series has already been collected by Simon
I have to reapply Laurent's comment on this series to your one (so I
have to resend it anyhow)
[5/5] from your series shall be resent to take into account the newly
developed LVDS decoder driver (once it has been accepted)

I have anyway to repost your patches then, and as I did in this series
you are ofc listed as author already, so I have missed what's the
difference actually except from LVDS patch I collected from Niklas and not
=66rom your series.

Niklas I picked up patches 1-3 of this series from your tree.
1 and 2 are patches from Sergei's series
3 is from you but was also in Sergei's series and I picked yours as it
was there already. Can I rebase on top of Sergei's one instead?

Thanks
   j

--BPjCafsbA2ap7OrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJazdsYAAoJEHI0Bo8WoVY8xygP/1o3/NInRo/dR0Q8+CXBqSUy
YEw8pzlz5SFEVw0nmbqlRkBwgRme91bN+jel6KvIn3pfphPK9dM9zlbsBOpxk+wX
ioD1Z+KxaF7hVcSUpdTMOHrSGFVr1PTCKhsCKJ3qEXTghHJuUCMybJSrCEMFHxMJ
XpdA21OxeE8N0ILN4qt3TinlhI90q77qbVxFaAXphF+RYF92GJIzbJVDp2Q9mR2y
ockisijWc55Pn12xk2zUWZ/pfQ5k5remjLCchRpbMoyTPo+17mev7QpGEOCjOxwy
cmsRdWk4d74QD2MpV9kCGvoIEzeQwp2TzothFS71L3gnE3aNQkLF40IB+c6PboFa
hXwp1bP0Fe6gSktNQVhv9Un01OfIipo70llTF9RrczpEmXIF3IB/+XZcB6k1RE2m
eLwULfmBccV1X1+oxiWaUYrpBq6fu3DvQamKxf3iuP+cm3IS7I1ZnG6HE0ZQGhPe
Yr1z7isBincTBIQGGAYEfe0m/qfeDXjAHMALxwhje8WKND2MuxvC7lD286kM09ST
s2IR1XT61c4eh1FH5D/AQtEeIaoJKZI3EFn2zB8Pv9wf1w0DX/b77m0EkJBv/RJi
eYxGLpsZX82rcg8NX2aka6WCDXfIenjxj1msSp4tA+WVJANlkdKGQLQQIIsuKFfA
AB3Z4r2TwvEPjlXc6ro8
=sBVT
-----END PGP SIGNATURE-----

--BPjCafsbA2ap7OrL--
