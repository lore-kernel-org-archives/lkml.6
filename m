Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964849AbeCTAv4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:51:56 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:35955 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933411AbeCTAvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:51:53 -0400
X-Google-Smtp-Source: AG47ELuZVqUmx/FzvrP4lSJp6B2yrRsWHTn9E2hz0gp1I5rcQQ3stwRLqkBtkG+BAiVlijORQePs5A==
Date: Mon, 19 Mar 2018 17:51:48 -0700
From: Benson Leung <bleung@google.com>
To: Salvatore Bellizzi <lkml@seppia.net>
Cc: linux-kernel@vger.kernel.org, bleung@chromium.org, olof@lixom.net,
        linuxbugs@vittgam.net, bleung@google.com
Subject: Re: [RESEND][PATCH] platform/chrome: cros_ec_lpc: Add support for
 Google devices using custom coreboot firmware
Message-ID: <20180320005148.GB57573@decatoncale.mtv.corp.google.com>
References: <cros-ec-patch-20180307@mail.seppia.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <cros-ec-patch-20180307@mail.seppia.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Salvatore,

On Wed, Mar 07, 2018 at 02:56:43PM +0100, Salvatore Bellizzi wrote:
> This patch adds generic device information to the DMI table of
> the cros_ec_lpc driver, needed for Chromebooks/boxes using a
> custom coreboot firmware.
>=20
> The DMI info would not contain "Google_*" as BIOS version string,
> instead the system vendor string would still be "GOOGLE", so this
> seems to be a reasonable match for every Chromebook/box running
> a custom firmware.
>=20
> Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>

Applied for v4.17.

Thanks!
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwWyEACgkQHwn1ewov
5lgt+Q/7B54BqwPP1sGa0E69wxU7ViJ+x6YkGIUMWIMiuW+DE1SdttZAz0w2q94k
w0JXh6qp3PH5lh2aomTE4AMcmAD411DAOWVQYBg5cyP0IdheZKDpfnYdyYCDh3yY
6N70UQmJZsPDrTO+v8mHLBuMbK0kxK4422/1OVXiEMc11A9mEQqZfOShHtayR32w
85QYEW3g/4G+QJX5KsVOhxj2oz/HWi4LpA19/BwaBeekUxg0HGifGy9W02XN1joU
pZUSDnJJA8GMZzix1Kb1jBNTP00W2lFifwmripXAATxyjILTmzJuxPId6rjDi/g1
+whWhs5HZ/0Wz1cK526prDfhY1l/ZuI2eYd1yXT++KwGHcB+OeoOfg9foa8ULQNT
POTtpw6FdIq34bPoG7Z9v9MY5G33mvoE0qhEtn/0d37VRKoFDdcSTQeufhEzulQM
3IDvap/ybtXo5SBtN+4FjIsWIikcDIuaGwoQ647vze7hpJRyiFp0Yk6RttopSHOS
mrGreP5LVoyb2ilFaYihovlYAMnhfBd3iRqDWrKPbjKgiXALFPnt0Lck8OZNwr0s
xI0KSl6PTNyWD+6s2qpsz7g6y4GAc3VBnPnwRGGWQCACHVuVfr3gZsGF20d7iuQQ
iJqTcV8HZ3R3eNm3J1wiEtyp/czKRwq23FswcTgT1G2XVQCHo5Q=
=Vjtx
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
