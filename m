Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3811C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBC920989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="On+UFIgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfA1U1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:27:18 -0500
Received: from ozlabs.org ([203.11.71.1]:33429 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfA1U1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:27:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pLlR4Kr5z9s9h;
        Tue, 29 Jan 2019 07:27:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548707236;
        bh=wyfPhhnF7cR7yazAPMjqoPAHv6gU2is2lRsOxB8aFPY=;
        h=Date:From:To:Cc:Subject:From;
        b=On+UFIgG63lCf4CI0kUuhX/IGVV+0YSi2SZa6ekQVtcGuh2GMwBxF4PW5c0lZIWzx
         zdFhfOlOuKPOrrazqAf5hfO4Ajm6f8DxttJC15aSOI5Gu2oJH/VyO4urUqk7m6gv0v
         lY2gloujeweKmCLy+PXWZTsuIZcHDammpMIH0ksdeWlOmdTJOvD6hAvcZuqTq2puF9
         c5Qo9RU2z8KLh1KVqQckGMOuZ3xDBCG/EIqfdX8XFqGLH+bScxBch1rmFAKVcMJLt7
         ByusUYpVQ3GGV3GXdADkZ3a+oKLhkDAiLvHO4riEkKyiVQshoFeRl+9vVqcGZ4zM5V
         vsm461H46F7gw==
Date:   Tue, 29 Jan 2019 07:27:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190129072714.6a5f4a95@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VAP5OkJHrwINr4TkJTvehOP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VAP5OkJHrwINr4TkJTvehOP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  720734a0b66f ("ASoC: soc-core: use for_each_link_codecs() for dai_link co=
decs V2")

Fixes tag

  Fixes: 50acc7e49 ("ASoC: core: Fix multi-CODEC setups")

has these problem(s):

  - Target SHA1 does not exist

Maybe commit 3f6a125230d8bfcbfe0c06ff0b8eaccbc727acd7?

Fixes tag

  Fixes: 10dff9b0d ("ASoC: soc-core: use for_each_link_codecs() for dai_lin=
k codecs")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  141474c6ac7f ("ASoC: Fixup build error for mt6358")

Fixes tag

  Fixes: commit 6a8d4198ca8 ("ASoC: mediatek: mt6358: add codec driver")

has these problem(s):

  - leading word 'commit' unexpected
  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/VAP5OkJHrwINr4TkJTvehOP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxPZaIACgkQAVBC80lX
0GwCaAf/RMLiCOcx7j6Yq2GttU3Jq7HypxQvKN8Ywj0sMnBUBLySrSiLn4fUttlo
OaZ6pAUpHuPM/A1W5/LIyv3+25PU8/W4S40ifjeWjlzbc+y8Bclqgq2o5eSUQvSf
NbiRtf6riLYYllO6cAZ0qiOLlKiG4PywEV9TUj8P1kAgW+Bd0y00GNbip6Mgc6Wa
rUQLgP9hpT1KMq/6BIBlRAesZHcATVyuUwDOfCRu+2Hcvg7LJ3GbXhaBPULBVMUW
ywPk8Cvujo9dSLxktVXE8o0HNsYatlfCl1wIHauMrwDoYih3mg9TaIrgCIqPA7xG
OHG1ijjrbyUh0BxIeqI09DlEhCu+0A==
=B4pV
-----END PGP SIGNATURE-----

--Sig_/VAP5OkJHrwINr4TkJTvehOP--
