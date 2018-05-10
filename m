Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756582AbeEJDJ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 23:09:26 -0400
Received: from ozlabs.org ([203.11.71.1]:48515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756373AbeEJDJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 23:09:24 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 10 May 2018 13:09:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20180510130920.75313152@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Nc9O6YBumJlvAKs6egxH60o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nc9O6YBumJlvAKs6egxH60o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information

Introduced by commit

  dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma=
-pcm")

--=20
Cheers,
Stephen Rothwell

--Sig_/Nc9O6YBumJlvAKs6egxH60o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzt+AACgkQAVBC80lX
0GzahQf+P5Zm3SfRPLeou+/wvUK4B2k/bAYwtU00gOyHmZBZHGHjwB3FO2NMoflP
y8B+nFMXyBqK47g6QF+SIEth8ECAS/I+oSKpbedaLYqpC1ktfr7SMuBRzZidURFf
6sWLigEYvuohVIw3saW4eMNHuRymlxY8ACJVnETmdYyqAdn7nRqvSlTDo9rTYjb9
132JcVUt3VI7jl77R6gUKf9T3e0xpC4MmEc11ak0OQZkBcHfLB8mcmcO0aWsbMz/
64aHSchBFB/aB/FbDpHASClEOehPrXPTx/lIl/kdEfgYGbauxxFLqqiJv2lKbzJY
tbkp2DncXZDeeYaPAPUxqoABqwLNvQ==
=Uycg
-----END PGP SIGNATURE-----

--Sig_/Nc9O6YBumJlvAKs6egxH60o--
