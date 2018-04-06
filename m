Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeDFNRS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:17:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60543 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeDFNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:17:17 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 6 Apr 2018 15:17:10 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
Message-ID: <20180406131710.GM20945@w540>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L0TNCHh3fkwjpuuE"
Content-Disposition: inline
In-Reply-To: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L0TNCHh3fkwjpuuE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the mess

subject should have been

   Subject: [PATCH 0/7] V3M-Eagle display enablement

I copied the wrong one from another cover letter...

On Fri, Apr 06, 2018 at 03:08:05PM +0200, Jacopo Mondi wrote:
> Hello,
>    this series enables HDMI display on V3M Eagle board.
>
> The series is based on Geert's "renesas-drivers-2018-04-03-v4.16" with
> THC63LVD1024 driver on top (cfr. my in review series:
> "[PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge")
>
> This series includes some preliminary work from Sergei and Niklas. I have
> reworked the two final patches from Niklas to enable DU first, add the LV=
DS
> decoder node, and finally add the ADV7511W chip and enable HDMI output.
>
> A branch for testing is available at:
> git://jmondi.org/linux v3m/renesas-drivers-2018-04-03-v4.16/v7-eagle-dts
>
> Thanks
>    j
>
> Jacopo Mondi (2):
>   arm64: dts: renesas: eagle: Enable DU
>   arm64: dts: renesas: eagle: Add LVDS decoder
>
> Niklas S=C3=B6derlund (2):
>   arm64: dts: renesas: r8a77970: add the LVDS instance
>   arm64: dts: renesas: eagle: Add ADV7511W and HDMI output
>
> Sergei Shtylyov (3):
>   arm64: dts: renesas: r8a77970: add FCPVD support
>   arm64: dts: renesas: r8a77970: add VSPD support
>   arm64: dts: renesas: r8a77970: add DU support
>
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 89 ++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 73 +++++++++++++++++++++
>  2 files changed, 162 insertions(+)
>
> --
> 2.7.4
>

--L0TNCHh3fkwjpuuE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJax3NWAAoJEHI0Bo8WoVY8+5IP/0I0zHdhOMVPJe30KKV5PHpJ
SMSaZ8e2TGnueH8VjbxnM8DPsBIiXYe2L5VH58W1BObZHXJRyiBJ5CwNmdbpi1Xg
j4L5dZ5FmmU4eHrgnsYgMKYJckU1QDzx3RwokP/fSaEhaaryCTjaj/+ecWfUsf9P
8eSYaAMP5uAWM1dEp5an0XaIDEaEbq8BPnsVAeLmusihOF0Y4eh+3t0c5JYtXEPx
R/t9SNxQc1RIxI7qa0ME1R0BIP9X3qm179ZPn5qmkM9IUTOAKZq9EaRgOFkxCghi
VRZqeW/bvDToVMw5q09U2yPTMxKnB6s9ddyK0YotQoBnKI7tPH9dXYqEpZYqp94H
DgXB/K05QdhXWHAD8AXzcVjAOitwG+P3Uj4EXQsnBkvA38Rq3svz2HfuImwBRRF2
Rv759loGeVRu9dmU+jGdw33RtS7z+a6WxBa+etiTArpfrcx3Z6LZOk8S8KYx2Lbi
CKvHojx/di8zNNgBzw35tfFMEf1v09041cKoouEznEcS1g2CoBLymrwza07aiP2S
xseLUOIrO7vofVYXtC7MQyczS8f/DtbqxdIm6oXtBwlr32UA/b257hQO5e1TLD+P
Xg5FqMYp1X+k8s2H+BXB6eqJQKdmJ/60iw2Jru3niXgH6Sz+wzOAfw4g3g1ZwG9T
VZYoRSnFaf2/AB2hcNWg
=YeR4
-----END PGP SIGNATURE-----

--L0TNCHh3fkwjpuuE--
