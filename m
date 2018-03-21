Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCULuv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:50:51 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:51609 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeCULur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:50:47 -0400
X-Google-Smtp-Source: AG47ELtXFUohrNHNwjyyKBQLJ5wji4iHNxOaAXNVHB7Vk1bOxgbld6ck03m9gDCCunTfOew9bbcR3w==
Reply-To: monstr@monstr.eu
Subject: Re: linux-next: Signed-off-bys missing for commit in the microblaze
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180321075251.49f3c1a3@canb.auug.org.au>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <31dbebc4-8889-85de-aa12-7dab4cc0494f@monstr.eu>
Date: Wed, 21 Mar 2018 12:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321075251.49f3c1a3@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pHdN8pa1OqTaeOabyfQTMvDtMFzoj6oi4"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHdN8pa1OqTaeOabyfQTMvDtMFzoj6oi4
Content-Type: multipart/mixed; boundary="yskl06NdrmMUJpHyP1fgvyRXHe8refFJX";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <31dbebc4-8889-85de-aa12-7dab4cc0494f@monstr.eu>
Subject: Re: linux-next: Signed-off-bys missing for commit in the microblaze
 tree
References: <20180321075251.49f3c1a3@canb.auug.org.au>
In-Reply-To: <20180321075251.49f3c1a3@canb.auug.org.au>

--yskl06NdrmMUJpHyP1fgvyRXHe8refFJX
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On 20.3.2018 21:52, Stephen Rothwell wrote:
> Hi Michal,
>=20
> Commit
>=20
>   39a21eefea04 ("MICROBLAZE")
>=20
> is missing any Signed-off-bys.  In fact, it is a very strange commit
> message.
>=20

Thanks for reporting it. It was just my testing commit not it shouldn't
be there. I have fixed that just now. Interesting is that my local
branch showed that this commit is not there.
Anyway thank you so much for reporting.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--yskl06NdrmMUJpHyP1fgvyRXHe8refFJX--

--pHdN8pa1OqTaeOabyfQTMvDtMFzoj6oi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqyRw8ACgkQykllyylKDCEu3wCdEf6dvOJRS/+Svx2OjjK8HWsG
OlcAoIDQ6hyJe7mNLSDn2v4myuDAN0x3
=Ac5b
-----END PGP SIGNATURE-----

--pHdN8pa1OqTaeOabyfQTMvDtMFzoj6oi4--
