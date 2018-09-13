Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99483F8182C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2FD2151B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJmfhkSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2FD2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeIMVIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbeIMVIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:08:38 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D052150B;
        Thu, 13 Sep 2018 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536854311;
        bh=XnrRd4LUf3xRnL33UL5LfmaOTDy8oTir9+HuSmEYqY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJmfhkSNb/M3aq+EbkdzMof64mbcvkwad9d1iZq+4i9dwP4ZVI4LNAndR44F6197i
         c8yyUy+ttJ9cgpGlX8AZoJgJx+51k0KCDSWPYYTG/3ZdACNP2NtAn/lzI6utzXe8l4
         f2o5sxsq7jFWaKHGJMQatczoT2fyc5ZJjtZH0VLA=
Date:   Thu, 13 Sep 2018 18:58:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] RDMA: Remove duplicated include from ib_addr.h
Message-ID: <20180913155826.GR5257@mtr-leonro.mtl.com>
References: <20180913134752.22780-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <20180913134752.22780-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 13, 2018 at 09:47:52PM +0800, YueHaibing wrote:
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/rdma/ib_addr.h | 1 -
>  1 file changed, 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbmokiAAoJEORje4g2clinKZIP/RF+2U27YSoTaPJtXYg+Gqnn
IbvWW/VZ4fnXmGKgm1k+SXh5rNnBeYVqrXFzHrGj1cJSWqiJ59V0+Rw+HH3mMIbX
NSBgLpX6LiZpy6m9zJosKG2YsbqBEj6khM03+/qXy2N7BagDvdgCV4dpqKcNv9v2
1AwCD51KUFIrPKzKdmrRq1dEoh2hGBLAxozZqpjO+J7P/gPkyVVqDqpgi6h7x61f
URLDV83W95KTXj2z8c9mF9OT5QQTZ8KsD6F8jtGIwjUdYgnkY7C1+5ZuqkpFHJRo
B3oHhVqJgiX4PjxlQnmUWXj3UlolgGLrvy8eXXJjR1dGCQQWmBx/DwTwYBfol8ns
IP1RStw/71mpIunzR0rXg4Yp9plD3jB7i0E2Xo+xY7T8qm1xxELQlGfeNcry3Q2L
XpuwgT6TWDGTIr4Jw5F93XEgAreVk+hdbvHsNlWN4GV9KEaClKko466+rp7/lvzM
cVXYVH8zDiTpi/2uIJvPHkGi3UQZQpm47DQOPI8jvI6bpIPEPas6Ehxw7IaCzt3n
7lcR8fAhXO05J2kVVFLUDASSYTwJtkSe8qdD6xtJYjGuv/0G9H01wj27D7Nv45m9
tRVOD2/E7n6QbMIz2Caw0PwU7V6xxkjcRTP+qgp+MQvTycuv7aun/f6uHrA69Do/
kQz0eQD9+ftGmDhRdwgs
=eKEB
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
