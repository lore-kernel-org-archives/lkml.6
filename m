Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD74C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83672208E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83672208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbeHGUHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:07:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:7944 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389581AbeHGUHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:07:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 10:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="asc'?scan'208";a="73498856"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2018 10:52:22 -0700
Message-ID: <263e783d8aa8b50c27d8919d178066367162488e.camel@intel.com>
Subject: Re: [PATCH v6 5/9] fm10k: Do not call pcie_print_link_status()
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Date:   Tue, 07 Aug 2018 10:52:17 -0700
In-Reply-To: <20180806232600.25694-5-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
         <20180806232600.25694-1-mr.nuke.me@gmail.com>
         <20180806232600.25694-5-mr.nuke.me@gmail.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-J5aSTQDattGGpjY4QXtq"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J5aSTQDattGGpjY4QXtq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-08-06 at 18:25 -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

--=-J5aSTQDattGGpjY4QXtq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAltp3FEACgkQ5W/vlVpL
7c7Vag/9HVyuEGVsk8QblGk3urNCoL2kGmQG2Gm4z/7uv5SZUqkWMBTa1n2y+N+U
w3wIC9/eSLz7GOUUEU6pWobU/ORkiPzl7D6yYVMvNLb3eS7InWvKiAvBkF/+e1Ya
ktzRLiacJFGwkavQfYa6ga5suNEC1YA7uf1yZ7yWxsahdLcFrznY7uhmRe+93wLs
jWpMr3HClUj1dUkfqjc3f/C42yALGCOdi328+OrV0APx3063eu73peNoDvbM+oXA
9S+p1sb2pG7wwWs9VHLPjGm3r6Qgl3fyWVTsTmV1KhJRajMq4Dw6/fjGqb219vZE
L3Y5y4MCLoteCQmBIbHBanLOjXG/JYq7CBR8sPZyBcYlYcWRqNJd3DiQGyHS+a8c
NePyrPa6LLIxLEJfUqk0hNWSYiPshc3YipoZhhVFlp+dGNVZZJJ2UKhSZMsweFAw
aYMVh/gjumHM2EJe9AYKob4aCH94KbA0WJfQ79phvr8Z6VS47Ikv3kojAHvmwJe4
FHI+s8adHTvM4eJZePCuhUBoP9rEZDgchnUpZVAoUxvYUeKdopNAwfizTor1Jg2a
QUdfz6SDVqf9sHBzT4ypvXy7A/9mgi/GhY2FisDAl76a2yemkjuOP1J4W2ivpkrP
z0A0LQ6u17Eko9abpm89jFx1qwJEiE9RNtxDjkrzb6DSASzMizo=
=PPMO
-----END PGP SIGNATURE-----

--=-J5aSTQDattGGpjY4QXtq--

