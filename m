Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBAEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808EB214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HlsZ2vf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeLQVtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:49:21 -0500
Received: from ozlabs.org ([203.11.71.1]:59267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbeLQVtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:49:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JZYW0fVCz9s6w;
        Tue, 18 Dec 2018 08:49:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545083359;
        bh=SNKP15KEDz9QOBQoOZGinPievkqNlnDgCDOVMJ7W2ys=;
        h=Date:From:To:Cc:Subject:From;
        b=HlsZ2vf5pp9w8kx2ULigz80EnRbvAtmn7mC0ouMQJ4U8Bz+3J2dP2APskgj+I1lBf
         BQz32AvzL7H7iaxgW0FXbBnAz6PwpBPMibM5op3nkLqnLDQXykBqhMQJc8LcRY+9At
         zyETLw3NTL6FXxw8eXyRf2gtq/o0zViMVOCZgeYSl9YyBKGR9Ox/ShEtCRVTVmL9TE
         CBTeFwQ3sqKPoLQbQ/FvXrRXSmi0/MISc/5nxsZ4jcnU9orVg0AWcXlaOpE3JOswXf
         Yg4moW47XJNiRi2taYYy8WJkq7iEw5zTVdamQ+5OCIZBh7PmkXy5bQhfp87lRvlkT1
         i0c4yEN3m2PxQ==
Date:   Tue, 18 Dec 2018 08:49:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the kgdb-dt tree
Message-ID: <20181218084918.755551b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eALjmxwk.k9Zd7a0ljy_cR9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eALjmxwk.k9Zd7a0ljy_cR9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Commits

  aee700022ad5 ("kdb: Don't back trace on a cpu that didn't round up")
  e046994f7695 ("kgdb: Don't round up a CPU that failed rounding up before")
  2649a5d9dccd ("kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call=
_function()")
  990bbea1e0d1 ("kgdb: Remove irq flags from roundup")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eALjmxwk.k9Zd7a0ljy_cR9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYGd4ACgkQAVBC80lX
0GzinQf/fnPGJaZVqWGTtzqlQjECW40E10DmivNuvw+VZlZSCxR7l93wt4b6SHmk
c8pOjHvevx6OKKlOQ+DQJCB9KuuXgjKmxqXdr2p+SLho0DRGxK9QF2rQmqaYHxiN
AyOY35EchA69QY+26owU/76rKsOjm/fji9yPu6oA6R2Azud83MQQyIEU7RgSUZX6
tYn5r3zeCHMUEzu4MF8WfpMv07j0V40PcL656Lx1aIYfX2MZYvLagALyYF6WUf2X
tYjeM/LZT4eQbsAnqA9HkxBXGxsuapSh1ul43jxgOxglCNwM87F13q2/g8YI3jyx
VTpfkPhHXyppq5JXEiAvI9TURmRNDw==
=NkdK
-----END PGP SIGNATURE-----

--Sig_/eALjmxwk.k9Zd7a0ljy_cR9--
