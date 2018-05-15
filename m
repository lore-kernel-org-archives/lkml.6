Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeEOXSy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:18:54 -0400
Received: from ozlabs.org ([203.11.71.1]:58907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeEOXSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:18:53 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 16 May 2018 09:18:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Signed-off-by missing for commits in the drm tree
Message-ID: <20180516091848.22a6988b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bFh6ueWBuSdOuYq7hDCWKtr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bFh6ueWBuSdOuYq7hDCWKtr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  f412e8307d0a ("drm/amd/display: Couple bug fixes in stats module")
  e09b6473c605 ("drm/amd/display: Rename encoder_info_packet to dc_info_pac=
ket")
  87943159f409 ("drm/amd/display: Only program MSA_TIMING_PARAM if it chang=
ed")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/bFh6ueWBuSdOuYq7hDCWKtr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr7atgACgkQAVBC80lX
0GxIRAf9EMHFJVwyhRlDVfnz3fujrlRXN8AWgTuezuzVN0fKX4IcmmdiA/gKVlaV
HXNkml+8MjaHKBAHh8VuPxG+7vm3gyET76296EolYtVbnUMmEl3Tt1uax97GsYTH
xR6ZYtUnOdNY4M5FW2Xt0WB/1jx2hidxrgJNP4VYueUXyzaJpf/2ivHfAvctCcDn
WQ26CojDr0pOi+77c52AR/74YTvBuO2AwjYVbgHRfGv4jouWHG31P79HM/868uU/
S8HFJLAX3glVyFf6926DpgcZ3fyBqAstBI+Jqx66pkfemmaBhwE1KZAAGT5GZih4
ZllD5x6aUjrHHCFvyAkUrEj4IzAslA==
=iqEL
-----END PGP SIGNATURE-----

--Sig_/bFh6ueWBuSdOuYq7hDCWKtr--
