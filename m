Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Xv7DF/CnGVtREQAAmS7hNA
	; Thu, 07 Jun 2018 21:47:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E65F66089E; Thu,  7 Jun 2018 21:47:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BhgTjRqT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69D7A605A2;
	Thu,  7 Jun 2018 21:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69D7A605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeFGVro (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:47:44 -0400
Received: from ozlabs.org ([203.11.71.1]:58929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751773AbeFGVrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:47:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 411zfg2BNWz9s3q;
        Fri,  8 Jun 2018 07:47:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528408060;
        bh=r0RJVMRo6m/dJ0PDzpaVcKBAA7atCLAcSo9LQEvK0bo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BhgTjRqTYwsiDo/vbcaSFPeegHMltdnlemLY10aK6fCvOPk+3o3wlRaw04eTksuZu
         RsNCAW7qo77HyuEVt46qTvcjGnO6f0imGMgQfniTIIEPWv/bLRNmdQHwdmY2AnfD9T
         MWI63M9s8tB3jKs+uBUIfKlIOLCTmoRdRl7/aapwHyYyJd9idW2QQ64lZtjvxcDPBX
         A9/Ml9YGMOhB6ePxMlIPXucqZHLAiB6F7xvBS5ogoYw9IjNwVAE6De+ZF7d4l3QOed
         0ceEfj0l7Mdbrl7yPxgi4T/Ta1LY3Qq4haIsnWry5VlS8kk/GkxCtrSXWqYyZl/JoB
         h0HgwrVncQb5A==
Date: Fri, 8 Jun 2018 07:47:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Leon Romanovsky <leon@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Please add mlx5-next tree
Message-ID: <20180608074726.5b3883e2@canb.auug.org.au>
In-Reply-To: <20180606192500.GZ2958@mtr-leonro.mtl.com>
References: <20180606192500.GZ2958@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UN3x1Q=Yj6cpBanhrYXGxtn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UN3x1Q=Yj6cpBanhrYXGxtn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Wed, 6 Jun 2018 22:25:00 +0300 Leon Romanovsky <leon@kernel.org> wrote:
>
> Can you please add the branch "mlx5-next" from the following tree to the
> linux-next integration tree?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/
>=20
> The mlx5-next branch is used to send shared pull requests to both netdev
> and RDMA subsystems and it is worth to have linux-next coverage on it
> before.

I try hard not to add new trees during the merge window, sorry.  If I
forget to add it after -rc1 has been released, please remind me.

--=20
Cheers,
Stephen Rothwell

--Sig_/UN3x1Q=Yj6cpBanhrYXGxtn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZp+4ACgkQAVBC80lX
0GwegAgAgZxkXXOi0xwk4FojHb+ikjjx8be8DI0H5eGoem9Y09r3Y2W8IgY569QI
FYLuaW8BCo7+tSlNSXYjUG1yv32qrKadsFd+JytDtfIkqYDxIxXvy4cKKPaU2zL/
YN898P+unVkRBA9vYgJl7g0ueGSZloV5g6c7ljVGRsOCgvgSI9hLj4D5hOJs5T2s
zH1r9QFt2CRLVYtdS3SkcGO1e016Hmx1Zn9yzRArYOofqcwN+hfj9cVu9aZrucY3
0R1RXjf7XH4iPJpaiTbdw9aBEaeQdd28X8vk7p9McnWTdM3q3npKPUf+OoEURJ7C
WguSLs6vLbrj+vJs/cfk+PXT1LUU7g==
=urIq
-----END PGP SIGNATURE-----

--Sig_/UN3x1Q=Yj6cpBanhrYXGxtn--
