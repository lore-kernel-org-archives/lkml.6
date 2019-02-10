Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40214C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A0C2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UqYMaPYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBJUhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:37:05 -0500
Received: from ozlabs.org ([203.11.71.1]:58039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfBJUhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:37:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yLLg4DMtz9sBZ;
        Mon, 11 Feb 2019 07:36:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549831021;
        bh=w/bsPRRbqa+ElwQl1ettJX1q1WzpjBW9/MiSirUHbC4=;
        h=Date:From:To:Cc:Subject:From;
        b=UqYMaPYicwH8K6iLfK/VbmxiBtDIjPqnD9O9+prSu1u4Aa+pyHYQv47HBbA1noDy3
         ZZvYMDQrsrVVPl9xBVI2FlmH4sNeMYn87kPr48OCWSMCDHli8slLp5eaU91lvz1Qug
         sm65WbRH56XYGh6qTZylMXsROX07Et07gDOI98msn0DpxWUgpuKUh9pii8vb9tblph
         LnCnN5NJuJ12jnXRb0dJZ3etJjutvoggdZqx11h9ZzcoMGwFeW0GLY0KOsQkBsxwCa
         HZjlySHpm1gz0kXwx1D0UkxDgUpbIWHgY1c6soHpjQJYmJk4hKFadGuBR5LmaQshyu
         6psLlvhvVShiA==
Date:   Mon, 11 Feb 2019 07:36:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190211073657.7f9cd5ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cm2GOr_pcomVfrNTZWho/dW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cm2GOr_pcomVfrNTZWho/dW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f6783319737f ("sched/fair: Fix insertion in rq->leaf_cfs_rq_list")

Fixes tag

  Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")

has these problem(s):

  - Subject does not match target commit subject

--=20
Cheers,
Stephen Rothwell

--Sig_/cm2GOr_pcomVfrNTZWho/dW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxgi2kACgkQAVBC80lX
0GxwYgf/dJUpDStgEnfD4253+gOLoY3yx7LeY5XeH2KbBcmbdrIQFaJpimWMEMuR
o7Cg9SedWCi1erjEGPCqgBwNuSw/q8am76NTGFKX40BNAaiPDJrNxrFmQZgR/4jb
f1kwIKZsyy4V16K2QUo8lHG2NMDqcU1s/Py+EMVs7YKuxojXnScvhB3yRwudVfZU
TmEOTeLDEMNj9JicTXurdZ3ofMcxAhE+5PzBO/UALNG6qeFRMgYezpWRM1KaM4nc
S5c+Xy7Qzg1cXSyg7uhCwNXaKZaBdzGF12MT0AXdpwhN86DeeKCpfNPJgEaZpud2
4Lxl5ADXbOXjzkg9Inl1Dw76ysomiQ==
=ToQm
-----END PGP SIGNATURE-----

--Sig_/cm2GOr_pcomVfrNTZWho/dW--
