Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA1BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CBF21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4Y6v74F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CBF21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeHHI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeHHI05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:26:57 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6008221708;
        Wed,  8 Aug 2018 06:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533708530;
        bh=1FcfT7MnSaqKgStE+Xf9qQ8DnOFqxYkW5hhEfLhHDs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4Y6v74FiNKgE0sw4W6L+UivYokdeZ4p5pdGP2kYI+g+429eFpLSGFx3SVCcZsDdx
         WOva1izU7vhldyk3twzNgGN/fnfRACmCDUKInTyu5mb9KR3J1t4Cc7dsm2wAJ3Du3e
         BYwHaEsI/YAn6HkndJy6bUhA2MQdWwFi3/Rp4xrI=
Date:   Wed, 8 Aug 2018 09:08:48 +0300
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
Subject: Re: [PATCH v6 8/9] net/mlx5: Do not call pcie_print_link_status()
Message-ID: <20180808060848.GQ13378@mtr-leonro.mtl.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-8-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20180806232600.25694-8-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 06:25:42PM -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>  1 file changed, 4 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbaojwAAoJEORje4g2clin/HIP/2W8reNA2ST0qw9ktcqoAtM5
XQKIgyD8DVxLkj0MjeQ+bzCpWwHzhNzXWMp+roOdvwhZSFav1uW+KyFidPn+r/0Q
6OR57qkoWv0Z/+35kFu5XWcSXg0g+3AzdukC42x6icE9zJKHzFIOYP5Q4AxUwNG0
ucAaouLXgioVQEyl64H7LgTzQNaUXPNb4zX8SaEtPBBeE1q0bo1LqBLLfUxRlGb8
LcgkPpKcDoLM5MKZVWmPGPR2S0imdDgt7K/1d8QvW7obq02dkwCLUG6DRw2qjLdC
K9heg0zilZlS2/fpzxIgrBTmdrSVxTU3ThEYF6h5PHcJTAZ3QNo8BYOmpG0Htic3
/QT317O6cM/gEZbySsBxGMJHa/li/5+Btv7e1B1lsoARsIuZsuEYy0giK5c1rqx0
pgD2miV4TnJdOmqvImtsrLQQF43PE9oemIYvhRIuItEDPWBEU6eElnQoGiH23RXE
l4X1NVruTJzEpEkirzpkdQ1GdsL82AXeil1QO0iD/f4+4j04mDbzRoVeYFLO/OM1
qRTZhfvydrbQIzP4zw9yWVqxbqHiRoEMjyY0vfD0lvnhq+8shcWFeFQLzBGOXDSn
sqFSL7sFxAG3VcnWYwEiBvacuuEr4vSMCgbm9rvhBwXzNFp5XT3v02eYvgQ9P6Lr
ph6iCl9z86ww3oO/AGmo
=I8Ry
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
