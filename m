Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1349F20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547737325;
	bh=O3QvxLfHo3EfCLtB+q2Uij5S1mbABkEhbHkPGGkVXWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GgnOnxroYvym6xbTgjpQvntSBa4K3KalgiDiLzXWuxu5yBdY6GlTqDQG3GE3TLoJx
	 xGjhQPoiQJDUbE+qWpvVGHonx+skcyOLyUxDeon/6T89qkIklHB50hnE8pjjUuNH4O
	 XkHSyJArLf4k4FDlD6A3wQjveZ/D6KR7m7PzeSAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfAQPCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfAQPCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:02:03 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB5620851;
        Thu, 17 Jan 2019 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547737322;
        bh=O3QvxLfHo3EfCLtB+q2Uij5S1mbABkEhbHkPGGkVXWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZ/eYJx6lAcooLEKVB+tnizFcirajSDr0Hw/I8CM01CrC17CvT56ynFXvcP4Y9j0x
         hoFnJyYvRsZHCikukB/3MytlBOGcRXmkxW8X7ebca4Q/QJ6nnf5qrqJO4765+xm2/s
         TlhL14GNocb7VCuZbGEmhqXu4C8tTTaamSgpTAis=
Date:   Thu, 17 Jan 2019 17:01:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, tariqt@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: remove unneeded semicolon
Message-ID: <20190117150156.GE15600@mtr-leonro.mtl.com>
References: <20190117130356.13652-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tjOMJDssiV0CZSJH"
Content-Disposition: inline
In-Reply-To: <20190117130356.13652-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjOMJDssiV0CZSJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 17, 2019 at 09:03:56PM +0800, YueHaibing wrote:
> Remove unneeded semicolon.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cmd.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/eq.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--tjOMJDssiV0CZSJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcQJjkAAoJEORje4g2clinJjQQALdXCpK68tJIVbV8fFTiyRR9
PkmOMSwDNmy+2rrvJ3Lxen9U64T053Wmm3JeremEeuRHMHG7WcVLe/9ecpuItcys
T7YDJQBcAwPNuG68xh3hUVieuAHCrhuJv105syV3yaM8IbJadSNOLNvpwp+d+T5l
G3NVECR37u9w8z69vDw5D5egedIKHzqPBS6EV+oxFgv0EJ5Tpz+zAOEd/1KM5oqX
P9zaiOMdemxuX8EFP0Ytys0isMRjWvf2quQyVrVx3WpDHhquaQfpDyAWHHlV4JnQ
Lvwn5yeqoNUxF5Fh5htcEKv4842c6OWg842osamVNet2ROT/CMG/K4xLYPjSzVLN
9HGDjIIKXVopyJHZlouGvfbzhzARriIt4qx4fPMFdwlKeT+lf4PM1iAjjPKPW0OB
0GST+J07FDfIXz84IvjoIuEIbnAxddGxFKTf+jt5hFYMYcUWmrYOibbAYzMsMlNX
9IiNe8VfwylsMH8Js5Oj5iqxmrxerG8fGDka6/ySK2PfAEFQYIvVBw99ZPbDekeW
+ABwyzi+FbeDMUnyhg+HB6cfptcKnJyLn+65/tncUNeALhKbX2wOVnQfXa2uNoOA
4l5v1yFI3Pavo2ds9oRcVXOqPlkevYr7yYTNsjsDt6dmgtunAF31XYABBRQIrwv7
8QCoKbMxEwyu4GYngrKH
=ZWsK
-----END PGP SIGNATURE-----

--tjOMJDssiV0CZSJH--
