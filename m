Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeDMXw0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 19:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeDMXwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 19:52:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F3521777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Sat, 14 Apr 2018 00:52:18 +0100
From: James Hogan <jhogan@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] MIPS: io: add a barrier after register read in
 readX()
Message-ID: <20180413235217.GA19138@saruman>
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
 <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
 <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:33:42PM -0400, Sinan Kaya wrote:
> On 4/12/2018 10:30 PM, Sinan Kaya wrote:
> > +	/* prevent prefetching of coherent DMA dma prematurely */	\
>=20
> I tried to write DMA data but my keyboard is not cooperating. I'll hold o=
nto
> posting another version until I hear back from you for wmb().

No problem, I've applied both for 4.17 and tweaked the comment.

Thanks
James

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrRQrEACgkQbAtpk944
dnqY4RAAq6jl/vHVaZ0FYWlFRCUfB4mtkGvuABwRvP7PdI8FSX2k1vkjqyNoump0
xisJa/BloRCYaPmOxzLEwdMjdvTq7fFatAp0gk+8RZy1TuniDUsqdZUFx3CyMsdr
h9AJ7mqQ/T0owWkmq2QFXiXTa4BcCua72E/coQwkcabJw7+YlI820lbacrWW+j3Z
1hYFNjmq6Wtb0UgA/rUB8T0D95WHNT7B89flPYQkORJBtPzrMSPTebbpmrfw5hOj
d7bp/6HlP+AFz+Y+zRwXBe30j23Zrlh7UU11bmAyZK8yf9M2zR02mUz02Rn4wOhK
OBHpAahyfVqFiwFe2c0bRt9/SKg/CGV4jOa9xHRbxeGiVXQk6B0t7j2lcbUfrSHH
1qOYtkaFF/S0l4YmlLlfyWqA8HV2JdAxZf2awfE9HYrjFwx2TdCrRJrGyKTq4ksI
VsvPjUZat7Zm9ugki48XawxdRJ3gyR7PmaL0BASd8B+C50jcD6nlDoZpFvP+s6lu
oHRA/1bPxPD7V67RSqUEyBTLyFqJy5f1aD+TZKmlmCPzH41sbSYDKO68LmHwxTX0
bVAXIaHemuVGQzsQ+H/1wasAvOQ6G7mcy6tXUi1lwHQIVmy02Lq7wb6FnfbmMFUa
aFsgsF2VGy824J2PFuWSq/32H61Z5j22XeHRLJ3yikQybh4xBvQ=
=Ic/U
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
