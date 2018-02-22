Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeBVIhq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:37:46 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:59727 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeBVIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:37:44 -0500
Date: Thu, 22 Feb 2018 08:32:42 +0000
From: James Hogan <james.hogan@mips.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: <linux-metag@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 13/13] i2c: img-scb: Drop METAG dependency
Message-ID: <20180222083242.GP29460@jhogan-linux.mipstec.com>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-14-jhogan@kernel.org>
 <20180222081018.tc3jcuwl6yfrxroh@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A6Z7MKnLVMfR85kG"
Content-Disposition: inline
In-Reply-To: <20180222081018.tc3jcuwl6yfrxroh@katana>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519288649-298554-5177-41482-1
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190296
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--A6Z7MKnLVMfR85kG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 09:10:18AM +0100, Wolfram Sang wrote:
> On Wed, Feb 21, 2018 at 11:38:25PM +0000, James Hogan wrote:
> > Now that arch/metag/ has been removed, remove the METAG dependency from
> > the IMG SCB I2C device driver. The hardware is also present on MIPS SoCs
> > so the driver still has value.
> >=20
> > Signed-off-by: James Hogan <jhogan@kernel.org>
>=20
> I'd think it should go with the rest of this series? For that:
>=20
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
>=20
> Let me know if I should rather pick this up individually.

Yes, I'll take this with the others.

Thanks
James

--A6Z7MKnLVMfR85kG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqOgCoACgkQbAtpk944
dnoEfRAAvetw227IMWNxH/EkIZ00ZxT+gco6oAtkTRFAx3HBKbDqWeDlNjqPEMCz
nCsx9+EyZva7k7D+htaXJIpVLIpL5mqYi8VbHvRhSDUBd/XcuXCLitoWfRjAswXu
yt3s1QYB1Ec3yzMMNF7/V5oWnnyUcNB/IQmqZAzMA7PKtp5O5H8+6OyrjrayYCE3
MoNeg6fuWDhT3MrqDFhiB1WZG95E+GP7R31R8qq532JPQljysAG0Oz6Ej3pYGiN8
2y4wCb42IYxmVEYFBQrWAKukZz1POuGhcPmoHAhbWj3+FE+wMx2mJAXQnZa4RC42
fTrlmBwVyPDOrjV1foY+9KTuv/PJuVDlIMMxP9YTqNS4Kk4I6qRpi7BfPevUcM7G
+zYYd7VCvHYUOKfNwB2iqInLDAeTR2J80UAxM5pGRf+MN2kluPh5wOpbqA/pD5mn
TIbwXJP7AKFjbCRSdHYkqpU+LtkbAvKDE/PjoiMWgjw7Edx+5j5gv9uAtqZ2uO5J
zecN6mLH4HpYXGGNSKGuVhDQXx4B8JkJCgOxyxD/R29rquHZ/NfuVNgIKkro0zzB
9JNRLRDictWmW+hs3HLmxN0COH4KBROIrds8O3iI5adOWba6Bdlm9Mmsc13+oAdl
GbA2RJNOozB5HCkk4f3Rx26NFoXw/blgUA4Iq7X2DiDiBIbTY8o=
=dchJ
-----END PGP SIGNATURE-----

--A6Z7MKnLVMfR85kG--
