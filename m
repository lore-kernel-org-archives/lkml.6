Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3F72147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gAOmtWfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfBGFvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:51:38 -0500
Received: from ozlabs.org ([203.11.71.1]:43441 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfBGFvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:51:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w6rR1ZXwz9s7h;
        Thu,  7 Feb 2019 16:51:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549518695;
        bh=FaDbHwc9wvPfmp1mLfEBKaW3I+kxhy1hYCXJ5bNFUuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gAOmtWfzUXOEOfNcPBRJ31KH3891meGKgHzJb44GUvCNpCunkKWsPboqDYDOTNssf
         li7zcVsSl5PTQoKIv0XaQAh6rxOfZURrHVf/8tOlMLSWGwU0xptdj17B81EI+kYE0V
         /tO5RNIEBUkz3aD1/DkA0Y5Lo3OqIAcAbTve5mXWJ71O8PSjhkxKv9e+j8HrTHlE6U
         YVeIh0XLtCXYexQpFV2Kwh6mury35nn7mFPI2qf95mUMpa2/cJTbmnHSsF4pQOevBB
         6s9SplDIwop7PdYeTs7x/wP4LKaerfYj9DRiIAMKdt4mSjWG2T3b3UY1iDYaUrXj43
         qwMNdDCjxSDJg==
Date:   Thu, 7 Feb 2019 16:51:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the fixes
 tree
Message-ID: <20190207165134.57c853dd@canb.auug.org.au>
In-Reply-To: <20190207154747.03209c75@canb.auug.org.au>
References: <20190207154747.03209c75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zhjP8pP+wY8MDPJD_.E6Trc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zhjP8pP+wY8MDPJD_.E6Trc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 Feb 2019 15:47:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>=20
>   drivers/scsi/osd/osd_initiator.c
>=20
> between commit:
>=20
>   24648908acac ("scsi: osd: osd_initiator: mark expected switch fall-thro=
ughs")

I will remove that from my fixes tree for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/zhjP8pP+wY8MDPJD_.E6Trc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbx2YACgkQAVBC80lX
0GxA1wgAl/Qtbkkm35Dx6RvtTmePkDkFHN7zv6zTN2P2vxsM3K5hxZx+iU5Xs0uc
Jyy8MW9jt+TNrFeT0qasK+wL4toEkk/FrJJJeh0PnysPmETWRB7UUmeR3VuFni7N
zziFNsrbmjJK1okPMQbHAv29wjR66pSPKxsd205CZa06O56RvZtWxd4E9EwVLaMq
Dq8EIsK8QMw3sZcI2Hyc6HXMdl7fF+h2nUWXk7Om0mi5ECNQ2Z5PQ8Hpq5YTjMZH
kIsQQup+GnpfyGsGdk02h0q0UVQYykTeyGAgO/Byg6a1/vbQveYi0HLcDSH+532f
g3Fk3stnhA+bWaUpmXtSELIqnUgVxA==
=AW2Q
-----END PGP SIGNATURE-----

--Sig_/zhjP8pP+wY8MDPJD_.E6Trc--
