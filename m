Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDYPfo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755107AbeDYPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:35:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5D021717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=leon@kernel.org
Date: Wed, 25 Apr 2018 18:35:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alex Vesker <valex@mellanox.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Feras Daoud <ferasda@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: fix ipoib_start_xmit()'s return type
Message-ID: <20180425153532.GM24820@mtr-leonro.local>
References: <20180424131549.2859-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
In-Reply-To: <20180424131549.2859-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 24, 2018 at 03:15:47PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlrgoEQACgkQ5GN7iDZy
WKfggg/8DGJIl7K00Hfuds0eJ/eySzKl4A/0UJYwtFnLB+DugSnjk2grpmgpZXQi
HJO/j/OARdVe1FfLQqxXqel1ALn8lnT1f5h5jzSySiDlJmtxMvCwKCkZuKnQEf8e
8xJ+xF6IaeWPUo54AB2nNgj9TedVgqfwoXUIj8hGER+YSaty7IyUswJpqdURIMON
q9Pv+FY82Ila2hQDb8/ZVwlHGr7PRvofcCLbP9q+R5XzPZx/WxPPaxhtuifjLTeO
a2x5NpVp80wOf3FxMC0BimL+pWJU9NPJPubU1Lk1peFsOSHMnwGGXYzm3/uqBobQ
fv0Dh93W0twseGA+tpi/xVQXHoejtp/4pcRmOaIA9MWcrmTMnOcXbiYAzEc97b2k
++lJW/qRixhCfink3+PTjmCQLPFJzDYYJ/BgknEHf1irNy0gmZgzmnvDA43cMWhc
CWjCsuwgitTSV6++9V3rL9APGL3JINVf24ZSrM8eMLLKWJzuHqUfdYDf4ifxTaus
PqTa45iGv4IuaTXJy2HSSKZHpa4GAg5TctauOzIAZONIkba08xdv0Hkui6wsyblz
cP6GsMyZnyCf9iMrR9dzBbQXAocYoN1wUEuaKoIUiD+kPIHoh7t5bIxWUqj/O/yk
LjaiC6aDVKQKqqhHqsKvjCG7MUnTDLMxlyv+u0F+TgNU73simIA=
=f+da
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
