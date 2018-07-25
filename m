Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7F3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0591320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0591320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeGYXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:04:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:50492 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbeGYXEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:04:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 14:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,402,1526367600"; 
   d="asc'?scan'208";a="248934205"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2018 14:50:26 -0700
Message-ID: <c3c236249fc8fc270e7100ed30c15a4269ab3eae.camel@intel.com>
Subject: Re: [PATCH v1 1/4] igb: Remove unnecessary include of
 <linux/pci-aspm.h>
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        ath9k-devel@qca.qualcomm.com, linuxwifi@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Wed, 25 Jul 2018 14:52:42 -0700
In-Reply-To: <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
         <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+VSfdhnE7sUHGmR3FE95"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+VSfdhnE7sUHGmR3FE95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-07-25 at 14:52 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> The igb driver doesn't need anything provided by pci-aspm.h, so
> remove
> the unnecessary include of it.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

I am fine with you picking up this change.

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    1 -
>  1 file changed, 1 deletion(-)


--=-+VSfdhnE7sUHGmR3FE95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAltY8SoACgkQ5W/vlVpL
7c5QqBAAn455TsS28QqR/CrkGJoIUp0zfp/vAMA3B9AJjIdFSdsA96CWo/87QBkI
2NdDy6ngDXPe9DdtDsnrEUKjs45O109izsYAeW885BaxGYYLkhyf/W44FGwuhgpE
ZZLMHlM5GbcxliTjkPRgEN2/5M2XZPG3w5GvvHlbqwzgbF/u3qbt/jPgcDPT0fFP
+eBRzSnMvGiUj1EujvtfFze3BeIQl3pPgAE+mPAgScCequz0VBeBO60kuG+LcmeU
uGDudpDucZnGlQWzUYXLdpPtsijUuQvjGDAfR4RhF36pNZYwcu6qkH+Gg+grKpHO
a3aD8qGF6lobKkKC4sCxxnDjUfbJ4AQN4XNlwso4UIdVR2dh2KjZjRhuj211IR4Y
Q5VxboEgsW4+rKeOZzy8GAxc5Xd32Omg1DKgl7ALWDlnQPjd7enmYLSn138LHDHf
vSu3H6CiKrUcdVp2PxdQz4FNpO5XqfEx28Gi7mtkTwWMXyjo6blERyBTeyeE2yBa
wXwk/FcC/jAxXxaPRZYccPjhU2p0ZWwuyUtlqQ73HieP4SYQG9EsgbmEve2VBHGN
31gDX5vzSIui+astEAxzwnFyDUINVNS9Dabbyhc9crn1aKcz2SML3h6Kh7fqThhl
Cs1s5NwcECY2VLPRYTw8QTVqCrcztxxhrT5r4I/7Yz6D5NExMG4=
=yzWc
-----END PGP SIGNATURE-----

--=-+VSfdhnE7sUHGmR3FE95--

