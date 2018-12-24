Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9923C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B3621915
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nE8h9lAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbeLXLpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:45:51 -0500
Received: from ozlabs.org ([203.11.71.1]:58727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXLpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:45:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Ncqv40d7z9sC7;
        Mon, 24 Dec 2018 22:45:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545651947;
        bh=SfWJ7nXu/Vq8X7BjxztBnXiF9Y7IjTdEBlw7SPo8gFU=;
        h=Date:From:To:Cc:Subject:From;
        b=nE8h9lAtaI5N7/jl3Pz2/5thS2KqmRtycTyCDpOKTQlVTFjaTfvxjAqwOoHHUEkWD
         C4eW12bgq8NqoN83KILtBtUfio1B6l56IekJRvNsUbkpbQDsUd5PZsm/bokujouAZv
         xzgmt+qNlEbOzQtoNrbP9epmTvy1Yopyq5bmYXerDFi6nDWJ6ZLcvpoW9SwOSO7nIz
         h6KL2ywJIMWiAmhYS/xDsJFuT1QD4HxQTy4Px5DaszLVQTBSkP6t7Sp/re6czsthdI
         8vhl0MKUxM7HOkMWKeOPDL8tBrJ+uPUJo1iaz1RoJ3OD121uC6BQ6UIDrSMwszwQDY
         jVy+IlBqRlAKQ==
Date:   Mon, 24 Dec 2018 22:45:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20181224224542.375a5515@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YAkHyVpYo.uWpmtHq_esmly"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YAkHyVpYo.uWpmtHq_esmly
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  87410161a381 ("cifs: check kzalloc return")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/YAkHyVpYo.uWpmtHq_esmly
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwgxuYACgkQAVBC80lX
0GydYAf+IYM+uOQYUkDUV04mh4x/icpXzawdr4aWgoNOIHe0ROAqARFRQ32WYlHs
+m+O6DVVs79BQEO3SigW/Ps08dQOeOI6gxwgP+28pgQ3BaxXN4JDrqhAG2+Tublc
cX97XyZmQdaBEWEKkjvfUd9CNjSKF2h2Fwcq2o7E5mlwcmRvnZjk7ggjSbaPALyp
5zyw0UwBmOlRVcryONXONF07nhWSPet0pvHETLybNCkm2QH1I/vBzg19UarVbCO7
r9okgO6dOZNIq2n9oa44yhT6rC0ZM18hobNDh5tim05crb9Hdwh/NW5aBFQZicPw
BjMnxPBGSzx4dH1vGlpVD4tjAlgvbQ==
=iHsk
-----END PGP SIGNATURE-----

--Sig_/YAkHyVpYo.uWpmtHq_esmly--
