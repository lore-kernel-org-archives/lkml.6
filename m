Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DC321719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0MbfIO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DC321719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHHI2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeHHI2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:28:30 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF32F21708;
        Wed,  8 Aug 2018 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533708622;
        bh=k9rZPSMeraVkUS8NVTKpgMbrAq8lZvV672TJ06V3FD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0MbfIO4X9bh2IJNPqf3h0b1JVlqxIckAyCWEiksH8cTO8I+8TbYZh09A/AAqTDXb
         vAJBsFmWJuk8YVZNdngyLqW/mohHq5dRJTkR8koEjoeTrasaVgALbr1EIpHQj4TUI5
         SWycqf8f1JA/Bark1CbCHWZeTUj6bDG5mVA0VI4w=
Date:   Wed, 8 Aug 2018 09:10:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v6 7/9] net/mlx4: Do not call pcie_print_link_status()
Message-ID: <20180808061021.GR13378@mtr-leonro.mtl.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-7-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20180806232600.25694-7-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 06:25:41PM -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c | 7 -------
>  1 file changed, 7 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbaolMAAoJEORje4g2clinfugP/iITkTHH34v7JIFBRMNf5eJO
x/u7soOhVxwjlcx2sh80ibyFi36V/t9gzGK0UWRMFRLbpEsSUUZJESKiePQbqVeH
f3EuwTrgi4pO80WyDev6/OlitwGJ1K73qdFKB5ZiwwZ4weXhvKwR1rscIac84AFf
qFQ7f7nZOXmvgQS99tjgOV/K5DOMe+2ZApknkDFf0rjShVIzHmlaxIpv7LFbLJuM
ubA3BzN+tlSu6olsE/OGGcqOm4LYaa0IAZW9Xy1zDal1QcWCF5jHGRvzYMCbsPT9
ma6SMEhwdLXSQwX0Q5NtZIaKA50uGLvPrEvIt2s+AEAsDen6STm/itMt8Eo6eLz4
nwMEmIQYPEbS+y5pOrsFnFDx+EcSkMX0Hr2qOKvhVLfJ5+HoKQG0I0dhiaYC7yAB
Qth+068qGKos5r2Yx4z4xht+cF4Zgo1w5P9QXxpJRtMyRZZ/cH9ofaihxm8YzjtE
lSVHjfmwbfPkM17A9r7NQXk6NagBxQ4ZBnl4ryxUxJG5FaXJrbpbgNuO0qIA5Z4m
gy72uCrcmisYp67BjVgJqYU4O2lBMz6sWa0ZgSqyNB8f636Zps2jvwTpMOjBxdt5
huhp40WQOcOUl/rLAOIMgeFw+ElVe5Y9/ucSnAvOZ3//PLhETY6cmMCiSIeGbDrK
FyMgiAXS6gfUn1oITAKu
=KHMZ
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
