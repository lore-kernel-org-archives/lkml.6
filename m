Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC75C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDB20833
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Jwb6pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEDB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIDRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeIDRQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:16:12 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E41B20659;
        Tue,  4 Sep 2018 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536065471;
        bh=R3ZbR++nwiLMydVawPl1o9SOYVXtEDFMaVhJa/f1sno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7Jwb6pi3ooD822shGQVUnfvhHBVlXZ7ceK9QH4pklbquCXbTZV/jBrd2zfTP7anO
         qxf1hYCiDmkX8V/BXuIoMfHi5wOUSDwXTdSw9arOa6M3nch8D3GZ8M5+KNBdl29O0d
         QAjqiolsymKyRCXgsWgbQyJRBxaOzOTp6Y3kkkT4=
Date:   Tue, 4 Sep 2018 15:51:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH 7/9] net/mlx4: Do not call pcie_print_link_status()
Message-ID: <20180904125108.GE2796@mtr-leonro.mtl.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-8-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="utUizcr4eQAkV3Ky"
Content-Disposition: inline
In-Reply-To: <20180903180242.14504-8-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utUizcr4eQAkV3Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 03, 2018 at 01:02:34PM -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c | 7 -------
>  1 file changed, 7 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--utUizcr4eQAkV3Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbjn+8AAoJEORje4g2clinjGkP/jCPp9UzQgvYbqPCf4Gse/bM
v4sDzUw1p4vsseeu+tUvImwsGaOKBdXLBXh0yyx0DEePtXAnA+Y9l2ZECBAnqRze
x88FJOZiut8n/OZCXuh34d9UgUuK4nZel9l+R5V6OE1Bw7Hvd5CDN+DELpawQxQS
RW1CI9A0gyzNZuVaquR8ZIPPH03HJPAvY8xSWum1u7D+mQC1s3PvBAHo/1U+f9tO
zWYo3ohY5TEC0ug0IENE1Y10PhAMkF8W4W+y9DO2/FYbycbP73rOpmO8k+sWZ9QS
l02bTVuCEnSzTamZ4s3Rz0uURBCdrq6mjluKRiVbDqArJ2l5APsXjptsjDfP9Dox
BblZ+oc4LfEOzpb2dYHWhSbFJWzIn9p+DkS9Y4ur/5HXAQsHmE4CkY03U0UE6H0k
Xn6lOJD6QkZ3hZu6M+y4iU+eZGOX4cH+K93AvLMtReXrQHJIxKd8Iyk14jpNc4JO
AnDhiDjSURIISQwEBWVx8EselbI7S4o2DzWic4lDJhPjFjYhtDcsH9D65eB1IIVR
4c+OGQ+lYHgUVxshx+XM+VlTjxev72ZE9vS+tOzZdCND01c2uUDQeCDZTJW6VFnn
u9B+NQ77G035Yn186RhLQkbIJHBGRF8nvX4KTEjRErry5BD+yqrgKz115P8y6F3X
PhbXQE6O7fllfTO/Vqe/
=LxEI
-----END PGP SIGNATURE-----

--utUizcr4eQAkV3Ky--
