Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeBAPbo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbeBAPbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:31:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A20A2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 1 Feb 2018 15:31:36 +0000
From: James Hogan <jhogan@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v7 00/14] JZ4770 and GCW0 patchset
Message-ID: <20180201153135.GI7637@saruman>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 04:47:50PM +0100, Paul Cercueil wrote:
> Hi Ralf,
>=20
> Here is the V7 of my JZ4770 and GCW0 patch series.
>=20
> What changed from V6:
> - In patch 10/14 I reverted a change that prevented the system
>   name/model from being correctly initialized
> - The patch dealing with the MMC DMA hardware issue has been dropped,
>   since we couldn't reproduce the corruption issue. I can always send a
>   separate patch if we find a way to reliably trigger the bug.
> - All the rest is untouched.

I've applied to my 4.16 branch.

Thanks
James

>=20
> Greetings,
> -Paul
>=20
>=20

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzMs8ACgkQbAtpk944
dnqRVQ/9GBxyEYAzjZOTEUMe/66jfEdfioZSyrPrNR6d80N3tTDQsjCeu411WbRA
W6BcM6sHCG/PXTb0retna/JBMCAQW0Q3+PZ1RWjjZy7JAZ+hm1G42aJfyr7lXLBv
y9DduaI7/GKH3hRudv+eS/FN4DtpZSZRVb8UB7/++V3jREleHUTFeMLxXk4rt0qn
+oqQDz+gpq7SAVH3zd+fe/5pv6uuSID0SD0CGaoUOHHdeWdwr6OjJrcr4pvLjaeo
8o0Hgd7Zr9Wp0Pr8JyUR/z2D86AJ3WW6ZuYUM+Jsb+tUfvNSPLoNf6ArGFytdHaf
PQqgF6o98aJlOcIYfTfFaKaCnX1QMRUrkRca7Aed+mIb+SMqDIamwhFsgOJaxPq1
HFH2d9DQQpsQQjB/sCcslZGufW16QgbA7Ls+yF7HOEZQuqYhazxC7ZTQ7h21pmpq
ylr4kNWaDE2bFtXyrbD7TILz20jPKmXvLX8j2GlltHZsk21hqgfZht4Yd9e6m5Hx
7N4zF6PihKoz6/Dmq0igmiBWMfuQreCXPUz9hKqNURfpsgMZ0O9HRJwfa/K1Ld4/
opgLhjxp8xLBdpoCw1NqWgKYMMO1t4XIRcWXnHpxT9KaGspMSmWj3I4u78uL3IOP
FLKQ62RHkC83Bu1ddTFbgnTMujsplUEuOww8EvrtvL1+qvZogBs=
=DPLy
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
