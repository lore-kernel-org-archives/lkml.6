Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeCIEpA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 23:45:00 -0500
Received: from ozlabs.org ([103.22.144.67]:43789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeCIEo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 23:44:59 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 9 Mar 2018 15:44:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20180309154436.79df1526@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3DhefnmpCspuG5zmYqbj+3K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3DhefnmpCspuG5zmYqbj+3K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  37a94791a097 ("drm/amd/pp: Add #ifdef checks for CONFIG_ACPI")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3DhefnmpCspuG5zmYqbj+3K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqiETQACgkQAVBC80lX
0Gy7EggAnWChpO1LzmHDaVHm3NBfatk3jYrROuG013ElPnD/fstQHGi3dgwGbMNJ
r+TBOHejMf+7APbEH97PsLvDeoQDBjpouG5tywxPjCqdj1qLtxFCPJOm4onAE6vo
Y/q4lN6UwHVFNEJiQPHqfcbVJXgS5IvwZinpRZWQI1YctkOuXEZveJSf8HK7zJa4
0CPNTN6eepWzELup1d033gfwdufP1fWMQDHtqTSlbiaMX+lQ3bPam62+a9ZHDgZy
ZBdC6KXdWabzUzeLdD3u8/BB702oevMJUyv8cXYBigcpTzx+ONWyiMy2vL9WEdUH
QhAuWbn85+ueWjdhhuGaQr5kG+PRqg==
=fCqz
-----END PGP SIGNATURE-----

--Sig_/3DhefnmpCspuG5zmYqbj+3K--
