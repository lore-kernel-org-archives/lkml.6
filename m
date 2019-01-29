Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE0921873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LYzi6wrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfA2Uxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:53:41 -0500
Received: from ozlabs.org ([203.11.71.1]:42007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfA2Uxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:53:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pzHQ3fBkz9sBb;
        Wed, 30 Jan 2019 07:53:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548795218;
        bh=BOc2GyYobvUeTvLha8rU2IKW2vbvFSc1qmbw/fw1ox4=;
        h=Date:From:To:Cc:Subject:From;
        b=LYzi6wrGVgQ9xKlV7w7MlnsC0b6hgJ/z9X0ZprcrD6GUlfegFEa3M5paEm5EHk/5g
         QrBMWFckKOLhTF4e8I0i+b0h3BmaRkZE4+Ppn1UGm3Qc6kNi4rhBohFw+fvfZFseir
         TaUL8neavWP7wG7iQtaO1m1IpTqIv9Fe3e28DJ7bZKbCpY3E6Xmf6kt/Pgu84uL1yj
         vJ+acMD9AlxRADLnvOR/593n5XP92Rs7EQxT6wxR+9xfi1EDnPFcHnVMwa3aUQiCUg
         FlmDZ52x+EDBzwgAY8V7sKc4fVwhjmjVuR6Fs/i8POOXCytiFAHrapq8UvJq+XH7OX
         jczhVGTovAOxQ==
Date:   Wed, 30 Jan 2019 07:53:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the scsi-fixes tree
Message-ID: <20190130075336.3164fcc8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//LouQrkFFexUt7KaZyWjIIu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//LouQrkFFexUt7KaZyWjIIu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b63195698dea ("scsi: zfcp: fix sysfs block queue limit output for max_seg=
ment_size")

Fixes tag

  Fixes: 50c2e9107f ("scsi: introduce a max_segment_size host_template para=
meters")

has these problem(s):

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_//LouQrkFFexUt7KaZyWjIIu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQvVAACgkQAVBC80lX
0GyyGwgAglHqjd/1TNdKN2ZPkGgSoJ1lVE/alfGW8tG9JOu6aqHpTnhn5JUeS8dr
MoVtCKWcKlm+MrL7zkzii78u21XENSOycM/1k7O/iU41d1Q5p+qKhRSQF8vtnrIS
0bItDwTd+LQ7Vg2yK859hd/n6+sHrux9/HxfxlA1l27LKP3K05TSIzHAd7R/OAFv
SazREi1mFhORCMIbFetAWoS6JujHy6Zhzv96YLFQ+X84Yvn+mBEfKWUI1iDBQRcG
nT8RWrP25Ozk6bCYR7Xpzu7pNw+P40WU9aiQ+h/NaJtpUWXednADCJ07AgMUor2C
fM+BLOO5yzmDG/qyjtUuP1aVuuwoug==
=ylgP
-----END PGP SIGNATURE-----

--Sig_//LouQrkFFexUt7KaZyWjIIu--
