Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343BD20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544428033;
	bh=mz00spIBHmLS6UXligirxC7HBp4NwhhqDFw9HuVnzM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=myznUeBWn6iWJQXB3zZU8An+uus9aLlpkeQyrK9kdBHM1PrcsybV6jK+qgeC1B/C1
	 wwlglODXNgFTAWo7kgTYNPqeBHTkJNT6IGvnzqH3cYvX9ElXTj7VgCp6RkkRHC4vea
	 xtJG2U7RibInygbtfXKmaZX2JtG4yAqpvEvrLhzE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343BD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLJHrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLJHrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:47:11 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B98F2081F;
        Mon, 10 Dec 2018 07:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544428031;
        bh=mz00spIBHmLS6UXligirxC7HBp4NwhhqDFw9HuVnzM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q21bEvGAUHdCQY3nCUTpHAYWQisaD2Du5oim9uDERwqfF9Qx4ezfM51p2Q5jxWNGo
         sLknip9U+Ds1nJPlWL2AU6wbFbj1IRh0IPv9S0QaDnL8iL8XWkOYOiCktYraPPHnVC
         kWZskqCfRLoh+ZaI7+uMquYlF16zjJC8ZL2+bfaY=
Date:   Mon, 10 Dec 2018 09:47:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/mlx5: remove duplicated include from mlx5_ib.h
Message-ID: <20181210074705.GD3933@mtr-leonro.mtl.com>
References: <20181210072759.26128-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20181210072759.26128-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 03:27:59PM +0800, YueHaibing wrote:
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
>  1 file changed, 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcDhn5AAoJEORje4g2clin4ecP/25J+S3sNfiveM55tBd5IRvX
viCV0tOmHz0vdgUAA6oYvJjUxz23ugeM3rUfE9oneUausF4QMjn2OaiJpL1li2rl
yNgHIHTjCaId2+4Zjo9AQpeJg8iyTLdrKK3bER/1s63gadcWRctRgzImc5caKHbq
69chEHpV/ke2jTiVi3gwj4/DY2G/YHhuizmgldfioVwHqablwPps0V8qZezat4GP
acslU0fHHMaYdLAgf3aKMJcn+cgdHoc9jFcYlrax2ejaCpGz1Vjoeqck7jCDoQ1c
JDMthgcID2i1PEkrLsQLKE9PkwE1q1iP5zIwAkte2mMWF6x18Nec7ZEYoLfZApdG
FzWBha4JRx7XaRIBPPbwSaCs7ILT/njzGtnkPdbR+LL7WJaIR5uIKq1FakssXW/E
2tZ1YVphjOGm22CaDG08TggGy8NK4EKvBzabon12/g7+vI2+hzcMA569VfccVrYd
CsuGr/0ikprgyphGLXIHyaBQxEn/Rz1DuQyEZ9r3Vt77/FKR00ifKGq8pei55XSo
fW340gb9No8SBefiK0zF7bFif8Aj4dIJsxFiadMMTR2Zmcfir5LO8DBNHBqg4keb
IWJL4IvUGgqjRL0rsmxF/P5g1Qb/OGb408or3zEFoL2m/LeEoOmmqF7RBDlKczw/
nJeLY6IRj/xb4FqJmUib
=So03
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
