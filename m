Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C73C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E827C20857
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LaDJFnGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfAaAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:10:52 -0500
Received: from ozlabs.org ([203.11.71.1]:48677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfAaAKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:10:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qgcQ4mgRz9s3q;
        Thu, 31 Jan 2019 11:10:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548893448;
        bh=P37JYaHVVtmcfnN4xRrLRhaJLfGJ41ZmswhMSqxFFoE=;
        h=Date:From:To:Cc:Subject:From;
        b=LaDJFnGB/3ofluCIaIO5/fUJgcUMt+/JqNn/aSZhzGMzxpuZ8Kp8gpSKcyeKifmZX
         uHTVt9mZeYpxZf39UJPWhlsQU0hKFyT3mI62FoWx1fTJjJA0cV2xIJe34xHtrkxtzr
         507z4duxIypfJ9ILWfDkXaKUrHaYlQv+fhxmSChe+g/j1VBejpYLrrEbMX/Fu2gnIx
         iRyHUgjwv3R9ckhtxAsCubCIxfP5vdB2Dvr7ZGaN2l7KoVfgCBRmafxTwe/5pAFYED
         ZKidqNgtZHCAf+P78n2PzJCp/Aj5bBjxYuywA5EnAk1x3YSIJljlGBnuYlkANblUIU
         Q6MLOGo6JPggA==
Date:   Thu, 31 Jan 2019 11:10:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhong jiang <zhongjiang@huawei.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Shuriyc Chu <sureeju@gmail.com>, Joe Perches <joe@perches.com>
Subject: linux-next: Signed-off-by missing for commit in the akpm-current
 tree
Message-ID: <20190131111046.36de09c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UiKbF2mukKUwH.FHPvoP2VG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UiKbF2mukKUwH.FHPvoP2VG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  7a738192604a ("mm/page_owner: align with pageblock_nr_pages")
  ed2205fd9fc0 ("filemap-drop-the-mmap_sem-for-all-blocking-operations-fix")
  d5b0dce6cd86 ("mm-swap-check-if-swap-backing-device-is-congested-or-not-f=
ix-2")
  bce20e289b36 ("vmalloc-add-test-driver-to-analyse-vmalloc-allocator-fix")
  e59a90e1c227 ("fs/file.c: initialize init_files.resize_wait")
  8a97a2585bb6 ("checkpatch: don't interpret stack dumps as commit IDs")

are missing a Signed-off-by from their authors.

I understand that some of these will be merged into other patches ...
--=20
Cheers,
Stephen Rothwell

--Sig_/UiKbF2mukKUwH.FHPvoP2VG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSPQYACgkQAVBC80lX
0Gzy/QgAmyOT4EG1pnrhxl52fSgpDTiCCV7meYYuaVG+HHGYrIE97Z80qDTL9RgG
jlzBVPSzRyZ+6YfVM+PPx7zpt0h2gVixHAnaE08tp7kUv/ZqFPnblQDqtalPLaKY
+6KFNiZJ1FA4/SskLuvmj+yIcZDUfRhb9wdmb4ckTdxFlD4F86Ya6zBCENjqgV40
zIkElxmG8b5aCg/sUyWejqSaFq5POwxJPPuxYtpx71LDgA/GHydBKbX+xbrTguga
kkc9353XkehSSLJ/LE4nqH+wloqCOhd/nlk9D/0FyLaV5RZpxkTXn3okIJ0WwHA9
Pod+UzjBFktMCfxLvjgFv0bARJL3Sg==
=OiLt
-----END PGP SIGNATURE-----

--Sig_/UiKbF2mukKUwH.FHPvoP2VG--
