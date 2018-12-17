Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4670BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166AB20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l/XHd6lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeLQWPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:15:05 -0500
Received: from ozlabs.org ([203.11.71.1]:56169 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeLQWPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:15:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Jb7749vbz9s4s;
        Tue, 18 Dec 2018 09:14:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545084900;
        bh=Sv3tx/LAtMd1blVFPCyAYIx5NukSrW0M4OjUp0wG5Gs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l/XHd6lqpfxBmOyPfMj3isoUVH8JmKFz3arD79henYfakB/cmsqu6eCLXEbY3keYl
         z3MHO0Pbfovui75+kNRoYHaP+s9LYkjr6D3wNmpTE8kvKy9BvTBm4ZKAq+BPun42I7
         FawmJOCiR4f53Ge6Yk3Xdze0gMixtgTZjZk5hzs19AMkMUG4tcUXM5/uOlut/G4B/9
         7T1o7/u5nBQt71AVMZBt/XYpWt24/aJvD2hY741slIx6VprJor3OVbvEExnRsOuWkz
         hRZmb6zNURTS3IsFyC6fBlSDqL1Jf3AL2ae1n9dfzYBcqVFWAVuNovCxToyZzGFpgX
         kQnlOla21LDEg==
Date:   Tue, 18 Dec 2018 09:14:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Or Gerlitz <gerlitz.or@gmail.com>
Cc:     Saeed Mahameed <saeedm@dev.mellanox.co.il>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181218091459.1c2b31d5@canb.auug.org.au>
In-Reply-To: <CAJ3xEMjvoNZLaCWk8KydUTKH-fmqnF1Vgbu42u0ame_s-Cj3UQ@mail.gmail.com>
References: <20181217112546.4e400eb3@canb.auug.org.au>
        <CALzJLG_g3QcYLM+ZXwfpu5E71nUOrG=KA4X2uR-WGeYAOYcsLg@mail.gmail.com>
        <CAJ3xEMjvoNZLaCWk8KydUTKH-fmqnF1Vgbu42u0ame_s-Cj3UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4sfpE0zTCdJZETizmBw6oZG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4sfpE0zTCdJZETizmBw6oZG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 18 Dec 2018 00:01:57 +0200 Or Gerlitz <gerlitz.or@gmail.com> wrote:
>
> Just a note,
>=20
> e88afe759a49  ("net/mlx5e: Err if asked to mirror a goto chain tc eswitch=
 rule")
>
> is from net  and not net-next

Yeah, my mistake ...

--=20
Cheers,
Stephen Rothwell

--Sig_/4sfpE0zTCdJZETizmBw6oZG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYH+MACgkQAVBC80lX
0Gxo2ggAn1D5fstIV+K7cjr6UmM2hIKZFwoLndpyHSduUphIGXvsJQO2qcwXezu4
YikmRFZ9twIMBoydOexIj+zS2y8Hc7qcQ5ELeGWaIT28r4eADAW9ayJs0XLM84qb
/Pt07c1BrA6uWpgT/WRwKJicr5sajWE4sqPplxlKJgU/aFBi+3ZQCbKVTvinvTi4
AwJ4RfyjDtBwOWOTmQTqoV3JeX3cXL5mA9MpmGsoN+xGNPnwwgUyhfFo5WrYdUup
A41KRt1mGGTU166kbOYdc5X7bCdHyNqcOzcMcvpcGaRrZX6JNe60tlI+I4SqMWM9
NY5SJGrafiTUR4bzkKBL6PYCsomN/w==
=HjTR
-----END PGP SIGNATURE-----

--Sig_/4sfpE0zTCdJZETizmBw6oZG--
