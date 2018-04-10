Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDJMN7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:13:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52493 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeDJMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:13:57 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 10 Apr 2018 14:13:52 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH v2 3/4] arm64: dts: renesas: r8a77970: add LVDS support
Message-ID: <20180410121352.GD6436@w540>
References: <1523357646-3946-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357646-3946-4-git-send-email-jacopo+renesas@jmondi.org>
 <0baa0f6e-f275-4a27-c76b-e4f8aec0b5f6@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <0baa0f6e-f275-4a27-c76b-e4f8aec0b5f6@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On Tue, Apr 10, 2018 at 03:02:39PM +0300, Sergei Shtylyov wrote:
> On 04/10/2018 01:54 PM, Jacopo Mondi wrote:
>
> > From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > Add the LVDS device to r8a77970.dtsi in a disabled state. Also connect
> > the it to the LVDS output of the DU.
> >
> > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > ---
> > v1 -> v2:
> > - Rebased on the modified endpoint name and changed patch subject to
> >   comply with other patches in the series from Sergei.
>
>    Stop, what was wrong with my R8A77970 LVDS patch, reposted on the popu=
lar
> demand? :-)
>

Nothing wrong, I found out about your right now.
I see a very small difference as
         lvds@feb90000 vs lvds-encoder@feb90000

You can add your signed-off-by ofc if you think that's the case.

Thanks
   j

> MBR, Sergei

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJazKp9AAoJEHI0Bo8WoVY8MlYP/0UNZorlwhPmv0oZ6+PpWmqg
MqR64kkrWYWhUPoUgGa4yLwx1wpcuDARGDirRBwAPQJSqCz4mR2YN1IjR1Tn31fJ
rxWjae+N1BQWhmRzvapAWrogmQc59vrAJVCILnrtalUqMCFg6gjsX3WNkhE9tznG
nj2pK4Jpa3DT0lONo6PNZjMtcsPuWmvJtTHKUuDlElCEZx4wmPkjUvIsJCQtjOeh
cN2z49O6unMXJeNZB8hnoU+BU9/qHo/RvuwbyrLeqkQNOUiUj/rY98WwLi9Jx+sq
Nq4R3X0odONsmuWlC1sl7GdSBYYOWbywmkOK3/AbvtpKkYQ4/FmJ+Ni6LoH9UKc3
8bkgDayGM+7xOb6j4/3OgHiz0s/Nr6pvfnXYN1WBho4RkNnbadfdx4tSAypEu9A9
3uoXE+hvVzUbSevWSsjvHwmB3MdPMH2HliKp3YUw513F/QfiXgZAUp9c7luKqGcS
jDR1Y3zXiLYU200ep+BqtR2jKakYSSai+63qlFgZj8PuW8m1M9bEzQvQhDxlPhn4
dXhMK79wleevaMAv7hGLc2p+X5XRRwqnTY+xVQ+jsnCLr/0N1I8E8+p3NXoxYsIZ
eNv02rv9iORNmUswkwqvA8fniYCf5soIWGQQftVuzYUTUTKrIJGKfu9A831HyDUT
WKDn5ZNUyP6jQ/qmeCIj
=Q4re
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
