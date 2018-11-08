Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF4C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727521104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="guU2xxIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5727521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeKIHve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:51:34 -0500
Received: from ozlabs.org ([203.11.71.1]:38561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731884AbeKIHve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:51:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42rcxz2g8zz9s8r;
        Fri,  9 Nov 2018 09:13:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541715239;
        bh=aX5C6HKqPRlaWReiWNgq1mm4fNSPkOCItnkxyILSeP4=;
        h=Date:From:To:Cc:Subject:From;
        b=guU2xxIajpIDCJxXX3TDN2RB5lVOcz74FHl0F/5A80B2bI59kMseBQezuPqXA3JDA
         eILwwv73304Yz+YvfMHnSL023mHVubwk3Mc1f5ViU0b9sINrOvAmOGKAM3ZYRODawi
         APQ4X9c3XOP0uCvJqQmff24GIBR6Vf8xQB6mzZ/AhipAk5d+E1JU86+66NfZ+DluUa
         Ri7g1CX6onQ4gaHxYCdfnBpcvqxyw8mLWT7CKjbNlAcumQOKn3+sEcxkO2VaCjWKXc
         MzbAHuXcCOxFZAk1ocCroYTir1g3T4ZCZ4B62LrrWc2w9NovsyXC5QPSJBluWih0bb
         WnqwmX4Bh/ZXw==
Date:   Fri, 9 Nov 2018 09:13:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rdma tree
Message-ID: <20181109091353.00e022f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Pid=n+5Z5sVIJlYcSH1KY0u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pid=n+5Z5sVIJlYcSH1KY0u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5736c7c499f1 ("RDMA/rxe: Distinguish between down links and disabled link=
s")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pid=n+5Z5sVIJlYcSH1KY0u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvktSEACgkQAVBC80lX
0GzVkwf/YWwSaf+8TP+fdm14RH0T37cMV/fvse/3AiVPU5ffaimTR3IPz+3UEEop
xbch5uVZuyqZy5+KJavJAhLvEati8lLS+h4Pj6lTV0YGRwSIHUh1pI5Bxwyj8Ycr
z6Uv7xC60uSyjx6zB+0EOyEVZ5GVsDuBHz3hY8RoGKVY6qOG4IM8dZdaOeL9b4Sj
NjLmAMXkNleUAFFki5wihC2wUrAvX2vniJKquXnGTkPSaK2u0fr8CMyp9NbCQbwr
c8WjKYGgP/yiD1A5ogavaf5rr4oDwBoWwQhcZdeZm1yv54kzUsZVQIzhdTp/Ckvv
Wl0nwopu4YRow6Vw2ZpBLBN9vJbiWg==
=GjKo
-----END PGP SIGNATURE-----

--Sig_/Pid=n+5Z5sVIJlYcSH1KY0u--
