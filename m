Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B27ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F42208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Et+Pu+ON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F42208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbeGPTxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:53:12 -0400
Received: from ozlabs.org ([203.11.71.1]:52849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbeGPTxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:53:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TtdJ2bLjz9s1R;
        Tue, 17 Jul 2018 05:24:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531769060;
        bh=7ymA+9tpWQKyyQvMdl6WHSBmcDRwPskjeYiCpdXFv3U=;
        h=Date:From:To:Cc:Subject:From;
        b=Et+Pu+ONuCOtor4FwFhnuG3zx4SWQlnB7eLkVVMrAplzvGuVzL/F6PNECDv0+fVDj
         w5FtRLWbGZHY/NeaD9CatSICI4SCaKNE3HpUVNDCHMtRtfHWSpNWkhLbjuuwEc+ygD
         zfpZJvgGVt0qlLdpj/xA4kJumBeDN/lhdmqeD4xKt7vu7nb2l+93LXk+EJMTrzWrZl
         aQAoZD9zJs9qxB/iI3B6MB7F6eu6BnvgINyMOIelybJpPRezTli3ILv/UvcT5ZixQv
         rlGfrrpSZY9Dm6ivJK0NAKO4K2GQxqg06Twjzk86AHQIxTB7KhxdGDaTds/3n5HGWv
         upA5hnZ88qnaQ==
Date:   Tue, 17 Jul 2018 05:24:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the h8300 tree
Message-ID: <20180717052419.11610795@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+GR_hUZnM=8DEUoEo7.sKGa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+GR_hUZnM=8DEUoEo7.sKGa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

Commit

  39f077046d46 ("h8300: switch to NO_BOOTMEM")

is missing a Signed-off-by from its committer.

Commits

  d6bde68ad18e ("h8300: Add missing output register.")
  5aa2f1573e0c ("h8300: gcc-8.1 fix")

are missing a Signed-off-by from their author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/+GR_hUZnM=8DEUoEo7.sKGa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltM8OMACgkQAVBC80lX
0GwelggAopKfFijj7Ic2JesEeru4GJbcuLeNpHo/UL0AcArrP8IrXYheTsV0fkjA
e/gV9e5cx9VM0KxveN0xMjr9Afb0KZWXs1gKKHSwbuK8MuxLYq4h6iZz3Bw33xmg
z1bcfPDrP8L58gpvgMTs05Po6lDUOWfW6AiNlJbvrUgbtSo/kR+g/uYV0juhwn27
qpMopuCxShJQqxMxmJbb4EXCL9xXBPQS6ePQ8b3QjqLOK+1cUjZcvggTabgPnpD0
RW10HlYGc3iaswwTLMFBCVnSwIbGtIzW9qyRq+xnvZL/0KmWXCHoPyfI58w4Dpc8
NNdPuiwQj71DoYqh9lg1ooVYGJhxFA==
=k+l1
-----END PGP SIGNATURE-----

--Sig_/+GR_hUZnM=8DEUoEo7.sKGa--
