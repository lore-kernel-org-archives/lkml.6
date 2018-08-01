Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E993AC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A297D208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hx/hHf6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A297D208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbeHAX1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:27:18 -0400
Received: from ozlabs.org ([203.11.71.1]:42509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388610AbeHAXZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gmqt0r77z9s3q;
        Thu,  2 Aug 2018 07:37:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533159466;
        bh=L40+x/SDkMLUztM8Z0dWCY6crGtZeyyr8O3wRP2qqtA=;
        h=Date:From:To:Cc:Subject:From;
        b=Hx/hHf6aWYTznHRLgJdTb7IlTxxExLXUeA6cn5H38KzG3RKWoIvcjSVYy6CEh84+t
         0yhxdwqQ1jDKKv9R7DApgekeRTytEDIfbVOy2iZ3ZqH664qFGYjDQRFpO1V7J+FSiP
         g4PxE7DmzEqtCrgW3yOKTIY+3ac+7sYVOde911Ixmgb3P40GF4ke2gOd5QQ0DMM8Bw
         DNU3u5zhU9ceUcMyQyRO/rKgz/ue+BYiGitRfRUPM7xHS6QeNtW0VktpQNjJ6Vs7+s
         a+ekX0w59Br/KvE+t4MO5uYyLBLI7f7Xcx+D0n3QGCJuRMRywLnNZFQyndhgi53GB3
         r873980VcCTEg==
Date:   Thu, 2 Aug 2018 07:37:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20180802073738.3f722d97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fP0=OBTeynjnLUfFERJpo73"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fP0=OBTeynjnLUfFERJpo73
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ted,

Commit

  b48917a8e229 ("ext4: reset error code in ext4_find_entry in fallback")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/fP0=OBTeynjnLUfFERJpo73
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiKCIACgkQAVBC80lX
0GxrLAgAiPhg8YZ8XgjZGzLKKAH5Timr5UkewQP/3XgQgx+1j32r8afmTEckfGKW
ErdSJLQHQ9VENEAMS6noHs317ZOuFNb7gj4hWYxfVzHDte5rtp+uwCaSKsDRk02K
waq2i9Ctu9EQQqP0dBaBMMgFT6AejWk50i9By+ELmbld+poudRh5exSEBUMUnIAk
uVdv8Jh+cnR3jeXk5syjHSuGEB0XsVaZl+3uhSYV/vL3urJupDyun9w+PEkMamOJ
QiRlL426cN17NUHIRupDSl6elToW3EyU1L6V1BG9r4ggw3ULFBSzdeZ1pqNFSQcF
F3W2CbMsWMvtxx6QmJ9bfJuP48+ETQ==
=xuLx
-----END PGP SIGNATURE-----

--Sig_/fP0=OBTeynjnLUfFERJpo73--
