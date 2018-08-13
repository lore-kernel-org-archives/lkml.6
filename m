Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D7C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C721736
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tTFt15K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99C721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeHNARr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:17:47 -0400
Received: from ozlabs.org ([203.11.71.1]:58805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbeHNARq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:17:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41q89h5KlWz9rxx;
        Tue, 14 Aug 2018 07:33:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534196024;
        bh=TOzcFkvHYyir7A60H3TNPGuWFS93WJ2fCbJikDp0Ft0=;
        h=Date:From:To:Cc:Subject:From;
        b=tTFt15K1KhtBzSNWMcnClYNjQw7nRwEHcS2gSaNZ97F7QXFn0FqtBYEwE7iKZsj9V
         F6edYateM9Ad0wKXh7/JEROMAYNkNYwWgSekvnKOvd+RFRTYvF2htrwsoawiI3udq5
         XpOFBdWN66P+B4wk8cDPHqqG3qiWoXLni54CamLm/dWCrILD45R3Urfe9Z1Ymsg8QM
         G3m/+e5TfXJEmKCYuXQ1iDz/uBmVxYklD09o0qTlaKt9IAdNTx1CGwn0j/i2C043Kz
         gytwr0mZnfLago8uL8orDdu0IC1otRPnjhnHS03rhejn7p+AriyHhfGcQNGEde7plP
         w6SqtyC5vw9UA==
Date:   Tue, 14 Aug 2018 07:33:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20180814073337.15250fe1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.lGtxtyPEfxaqThHp77/Z2t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.lGtxtyPEfxaqThHp77/Z2t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

Commit

  bd714f5f14e0 ("Coccinelle: doubletest: reduce side effect false positives=
")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.lGtxtyPEfxaqThHp77/Z2t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltx+TEACgkQAVBC80lX
0GwYoAf+NoIJUlnNHKPkTK7BiaiMd4HqHUYo57J7EoX9ReH1Lh43a7AzslL2u599
rY5FmWP4HuyxEF7Tt/UWesh3TkR8qSbGDI3OyjdMM5RP2F06K7ru1TN0UWYV3ub5
4ewzQIjUQM8go1yUORAEqL5WO2hF0MPzcPCMswcw0iDuBEhLNE7QJRpsrvYB4GSD
pxzuLvl2LKG7BKRS4Ww5vVU0LzLfCMo7knlFLfIxJtUpXamjQKMSuImO2aMgrjc8
W3kF1ZhRUzbhbnJbJb2av9D6CKXpPQytKjSK/F1a6v5OJYpNBfvEh+ySup+jbrBY
GeWVNMgx2nKQbpyxT0fkL6o1XMvOLA==
=YGT+
-----END PGP SIGNATURE-----

--Sig_/.lGtxtyPEfxaqThHp77/Z2t--
