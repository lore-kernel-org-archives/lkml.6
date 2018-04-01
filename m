Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeDAV3q (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 17:29:46 -0400
Received: from mout.web.de ([212.227.17.11]:53427 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeDAV3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 17:29:44 -0400
Subject: Re: [PATCH net] e1000e: Remove Other from EIAC.
To: Benjamin Poirier <bpoirier@suse.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180131072627.18305-1-bpoirier@suse.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <c05c33b7-92f1-d8d5-76f0-64848dae3693@web.de>
Date: Sun, 1 Apr 2018 23:29:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180131072627.18305-1-bpoirier@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2oEjpd7VoCzZehQkdR7JRdUs4ODUFqfCF"
X-Provags-ID: V03:K0:1kl3tOuyzfvwglRn7R5ECWbqaGCCUutCZ/RNOEari1hkyIBVKR4
 SRt3tTr3tHMWAKLn+L4BA5bDaXf4YbWF0kWUfXldKCnw5r9H/wLciX/z5ll2oUXzB+xoLzP
 5wq5PZipQgmlTt4TqR6yY8sN4eG2Zx1U9D+tbBNmvvWT+aggqZPpEVEDaRgV7oihx/QESrX
 gfHQFdzee9iOBgqH9/+Xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hr6D28yJL90=:xAr6gksedfRZEOV9N7kzCM
 q/t+ZidpYBHYiSYYUWKV197raQN87BBVDBRxY4KQzH56x7usCx7M3tpirfuRasiOCc2hyT9m/
 6pci+VIiC+9t1JDggJy/6jcG9/+XXBbo9mgAJ2SqooNuAJZ1ds+feQrUE6YVoUdVZSx2EcrWp
 FR1JaTcLx+Igq5+dYqZAuymqg2NGZVAa5BQz6eSJFsPAgraCgYNp8DzrXPAO2oJFrxE/0XIOG
 2l1qJsAoPYLdvZciSJwBNfqY7cvz2vUtVjlImvz6NLe/nrBF5X/AndY/gexg/Pg3O0+BEmNyC
 ItMBQrEirUlUZxjuGXoz6Uyjr8X6qrEvWb69+uSFzuhjmF3qp0i/8md8BRS8KfXj24bwz65yk
 mFn/VW6luze+81mzuOM2ZRD66uNMTNNx5C9OSY0YdhVOs0ycs8n5za/XdaTbU/Ld747Bd7ME1
 X0xeY5YJAaBjh2bg4O+Uw/tl9l9JSKH3uOUDTDdVo6I9YCDKAah2tEFmAcXTtZjHqlpotPXNh
 /hkJOeA55GNumw+U1adqUIeSXc8GxWvp/ctyPohTfdpX6IU29FMT3sAH9SkhETPoSXIFQZGw3
 60bJyIhWUGdP2Vmux+5gCaUq0CJuDU9spp0At6nuN7p2ZpLbJc2Y+l5uLgX9yyByHjDyPLG4Y
 SD6MpCjp86N0n5aqAoNSSgAm+OQPB/DiIhc9c9X4k2330LGvPsvlv3847EubKwTAoMbNH55M3
 tZz2OnhsC9jR09ReDaQjBII0PxOllinwpmO1Zs+Y9zlFfR8/PGFHlnOrJPfwCm27dVrOTWDbZ
 J87nobMBakM0B9uG84gKOmTeMvmrw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2oEjpd7VoCzZehQkdR7JRdUs4ODUFqfCF
Content-Type: multipart/mixed; boundary="rnXzrojDxBXIaqqhqgdNSIvkN1q6eb8kX";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Benjamin Poirier <bpoirier@suse.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <c05c33b7-92f1-d8d5-76f0-64848dae3693@web.de>
Subject: Re: [PATCH net] e1000e: Remove Other from EIAC.
References: <20180131072627.18305-1-bpoirier@suse.com>
In-Reply-To: <20180131072627.18305-1-bpoirier@suse.com>

--rnXzrojDxBXIaqqhqgdNSIvkN1q6eb8kX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-01-31 08:26, Benjamin Poirier wrote:
> It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiv=
er
> overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_othe=
r()
> on emulated e1000e devices. In comparison, on real e1000e 82574 hardwar=
e,
> icr=3D0x80000004 (_INT_ASSERTED | _LSC) in the same situation.
>=20
> Some experimentation showed that this flaw in vmware e1000e emulation c=
an
> be worked around by not setting Other in EIAC. This is how it was befor=
e
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
>=20
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")=

> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/e=
thernet/intel/e1000e/netdev.c
> index 9f18d39bdc8f..625a4c9a86a4 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1918,6 +1918,8 @@ static irqreturn_t e1000_msix_other(int __always_=
unused irq, void *data)
>  	bool enable =3D true;
> =20
>  	icr =3D er32(ICR);
> +	ew32(ICR, E1000_ICR_OTHER);
> +
>  	if (icr & E1000_ICR_RXO) {
>  		ew32(ICR, E1000_ICR_RXO);
>  		enable =3D false;
> @@ -2040,7 +2042,6 @@ static void e1000_configure_msix(struct e1000_ada=
pter *adapter)
>  		       hw->hw_addr + E1000_EITR_82574(vector));
>  	else
>  		writel(1, hw->hw_addr + E1000_EITR_82574(vector));
> -	adapter->eiac_mask |=3D E1000_IMS_OTHER;
> =20
>  	/* Cause Tx interrupts on every write back */
>  	ivar |=3D BIT(31);
> @@ -2265,7 +2266,7 @@ static void e1000_irq_enable(struct e1000_adapter=
 *adapter)
> =20
>  	if (adapter->msix_entries) {
>  		ew32(EIAC_82574, adapter->eiac_mask & E1000_EIAC_MASK_82574);
> -		ew32(IMS, adapter->eiac_mask | E1000_IMS_LSC);
> +		ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER | E1000_IMS_LSC);
>  	} else if (hw->mac.type >=3D e1000_pch_lpt) {
>  		ew32(IMS, IMS_ENABLE_MASK | E1000_IMS_ECCER);
>  	} else {
>=20

Shouldn't this be queued for stable as well? I'm missing it in 4.14 LTS
at least.

BTW, it seems QEMU's e1000e model is affected by the same issue. I've
proposed a fix for it [1].

Jan

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg525182.html


--rnXzrojDxBXIaqqhqgdNSIvkN1q6eb8kX--

--2oEjpd7VoCzZehQkdR7JRdUs4ODUFqfCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlrBTzIACgkQitSsb3rl5xRKnQCeMos2vf7xyUIm/C5m49fpKBVB
YTQAoM0/7K2BfawPnBwq9vitdVMLMyRb
=Dppw
-----END PGP SIGNATURE-----

--2oEjpd7VoCzZehQkdR7JRdUs4ODUFqfCF--
