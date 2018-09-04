Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C221DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0DA20833
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFOuoZuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0DA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeIDRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727390AbeIDRQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:16:29 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E908D20659;
        Tue,  4 Sep 2018 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536065488;
        bh=bSE+9Ce10Wz6Y8pe9Lkc8Pxz6U13ou+lbhalqQr73ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFOuoZujCssnNOZF+2pdWl+QqXcOaBKkxsLnZtamK32KYQHhNMKEFqjDqVGKETVEj
         qsgeyliNnLMcwnEMAH3RAdymjuukWlOFO8043DGCp2xiQc69OBeZ6aa0FkWKfWT81A
         CO/Hj364XjjPIeaPCDb34+Mr0Z7QqASSl5PfJb4E=
Date:   Tue, 4 Sep 2018 15:51:25 +0300
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
Subject: Re: [PATCH 8/9] net/mlx5: Do not call pcie_print_link_status()
Message-ID: <20180904125125.GF2796@mtr-leonro.mtl.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-9-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zKD0QXBepZ0ysD7Q"
Content-Disposition: inline
In-Reply-To: <20180903180242.14504-9-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zKD0QXBepZ0ysD7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 03, 2018 at 01:02:35PM -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>  1 file changed, 4 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--zKD0QXBepZ0ysD7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbjn/NAAoJEORje4g2clinvdIP/1XmGCCJjlghx2pUotnL9h17
mR3f+K0cueebvFKq6dvEnK7HwzxU0FZ7dLxgkBcNzEGmT2wHU2sqAjOPGQDJAm8j
i08jEixwBvkt18wJgBaIszwThxDVCqeMIygsdeVKJ1cz5KyWjJ2S3k2S7k3OVP1W
zJgJx5pYiGgaMDuM/NAgWNn+Vq0Ra/rrVtYVxxcfpZ5P0Pvw0FC+nFqrtpkyra3f
VROx2cxjIco9QaukhPan65dV6GTVQkVmOjxj7S+4gGuTAFcpWknpKE33QujPprEP
YIwvql4uaJ1UDitfj6iiKHPH+1BK4uEQycvX5I0XeZQVkY04NcmcQEYi2WJSFmGu
vqf1W974lKR08cEwsmJSo4FRZSpBtWO51bcuGI9/DsU4KxbjrlX5OvxmsEiStBh4
fLeaSLRolCfUZD0aEa2/GcYxxmnVcDujt8UeQbUqGY+BkdZZaUTVi/vh2JaSaMis
SIbR6UN1E0BKutTPmBiG1XWNyr6SDF9rkVZInvTbEfofT/aFsbCxVeSD6QdbysJJ
cr0ylqouKVWat5m5FgAL86QYyno9NNDfOKgjRI/Q6FdgglHh2G2mYc7jUlgNuvCj
B7jOdxO12I46ql2DNbnmdyHjlJH/aRgrnGpdTxH6lhtl81Z/GlENm+HIX0PuVmN7
7DzWa4DghmRtb3Dq/L5A
=qx2/
-----END PGP SIGNATURE-----

--zKD0QXBepZ0ysD7Q--
