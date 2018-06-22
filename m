Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FA524907
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FA524907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeFVVa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:30:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:36115 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeFVVax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:30:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 14:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="asc'?scan'208";a="60269534"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2018 14:30:43 -0700
Message-ID: <dc3e8b7272240b2650f5ed55a6e2954a765a96de.camel@intel.com>
Subject: Re: [PATCH] net: drivers/net: Convert random_ether_addr to
 eth_random_addr
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Joe Perches <joe@perches.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>
Cc:     Kalle Valo <kvalo@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org, linux-omap@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
Date:   Fri, 22 Jun 2018 14:30:43 -0700
In-Reply-To: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
References: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-D9yGWhKjkfSXPDF363Vy"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D9yGWhKjkfSXPDF363Vy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:51 -0700, Joe Perches wrote:
> random_ether_addr is a #define for eth_random_addr which is
> generally preferred in kernel code by ~3:1
>=20
> Convert the uses of random_ether_addr to enable removing the #define
>=20
> Miscellanea:
>=20
> o Convert &vfmac[0] to equivalent vfmac and avoid unnecessary line
> wrap
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For i40e change

> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c          | 5 ++---
>  drivers/net/ethernet/cortina/gemini.c                    | 2 +-
>  drivers/net/ethernet/hisilicon/hip04_eth.c               | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c              | 2 +-
>  drivers/net/ethernet/microchip/lan743x_main.c            | 2 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 2 +-
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c          | 2 +-
>  drivers/net/ethernet/sfc/ef10_sriov.c                    | 2 +-
>  drivers/net/ethernet/ti/cpsw.c                           | 2 +-
>  drivers/net/ethernet/ti/netcp_core.c                     | 4 ++--
>  drivers/net/ntb_netdev.c                                 | 2 +-
>  drivers/net/usb/lan78xx.c                                | 2 +-
>  drivers/net/wireless/ath/ath9k/hw.c                      | 2 +-
>  net/batman-adv/bridge_loop_avoidance.c                   | 2 +-
>  14 files changed, 16 insertions(+), 17 deletions(-)

--=-D9yGWhKjkfSXPDF363Vy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlstaoMACgkQ5W/vlVpL
7c5zcA//cQWZG35VbKuQPLIA9U/A2P5yF6jB+gGXUMsOhElBsgMAWL+3uu2FxrM7
3D46GWwjvxvEmh1t/Bf4hIIXTaQD1JlitxNfiYM/oFp9QqM/gl17VVWu1bLefUuS
/oLv9RmQy4sPsvjtuRjis3LzujNtuQFL/ynhr1NlVnU66ZJPXZDxBd2pXLgTC6/U
u9a/gJX04MVXlbsM/CyB6eXl+G8S0HnDdRC8tps5XWcb0uFwicmMBnCa27euBPtO
9fh5Dm55Ks39Ngu8GsdJP0Fxj1VudmlvfIeuzph3GHzEpHjYvAKo+zWTyGCffWka
CelgVYf59Cy1HVsp4dJoQsl5jFANanMn9dc7skTo+dISaye9YoLQIS5ZVG0GzLF9
cI2hCj4hoM7LW4PfJRl+Jf7HahhJENeZZgR+0m9fXQYLxCAjfMFKuuxgNaEB+9h5
MTz3K2OajdyAb/Fr5kU/4RcQckxBM23AhcjRlDea3AjJNYILJ3Dx3qlnTWl2who3
OS+JGw+jG3deGaryues5yVqFNYRsh+vbXtCLMMD9eKjd07AfVnBq62TWYyWAVbMW
dqQJfEjavwX8VMJCqXypEDMEGgz1duRl/dtcCVhuZ2eNLS3Y01Xa2SdduWh9X1YV
zoI0/WCjo9N1LmvRhLHBcnChcVw3Jd7MKupTZSjyT/vKWNAGZ8Y=
=qAR1
-----END PGP SIGNATURE-----

--=-D9yGWhKjkfSXPDF363Vy--

