Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164233AbeBOWRY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163612AbeBOWRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:17:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB485217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 15 Feb 2018 22:17:18 +0000
From: James Hogan <jhogan@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix logging messages with spurious periods
 after newlines
Message-ID: <20180215221717.GO3986@saruman>
References: <ac33924a3e39541330e8f008f3ad0fbda74845d6.1512543855.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XVTPT6MZt3zd/C+/"
Content-Disposition: inline
In-Reply-To: <ac33924a3e39541330e8f008f3ad0fbda74845d6.1512543855.git.joe@perches.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XVTPT6MZt3zd/C+/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:04:58PM -0800, Joe Perches wrote:
> Using a period after a newline causes bad output.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Applied for 4.17,

Thanks
James

--XVTPT6MZt3zd/C+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqGBu0ACgkQbAtpk944
dnqCSA/+LvMOmchhHoEefzYbReb/HtaViYODVwXjk14uMRnw7dujDivXPvMoE3B0
u4ZoTYYlua73EWgorwI+4AoFbd9+/WL49L7RBOMwA3ZS2OXor79nSG4RPl3q17h3
n5wx6BxR77oaeRrTP5sg9XIr+/olAl+fk3CBt2WUnTW0Nvcl55T5O99uXHyuUpor
bH6Y+AF90BAzN0z+C5T1eTjmlhvwmhYSNRDIZ9t2O1JzPmuU5GbvzTbdpzp9xm8S
ZEzV1576LYPYOUqGtQ45GuYKUX1kETxa3N9VGSzjWkXNXFYCGFDoYAPq9/PSl0Fv
x+EJOYtQB9jRupTprlBTds3GmXP56HcDMgR5O5E9XuJfyphrfEwWT7JKYYAd7bZC
OAUkAadaIERRTMLpi7X7wGBTleiFHJ3PM9BhMwyk+65ATJ2Lyb0MZ/CMDMwBqua8
FLPLMf+vYOY8xgLd2sD88lmDdqpnNyq5+NAF+1sA4b0wI4eM1y9VSMO6g6WhBwiq
knt0v/KmaPIViW9WqnbNSi2gVA0XCXVwvm8/7bLDwTlWMH6blstzCAfFyQKZCYvf
3e05PvsGnu4dJx/MFKwg+o9bTHpg5yMGR7cJTg23QLmwkvVl44zMAoU7441417NA
nITwre7Qr93gKA+9ik9HuGRiWg7TJKeqBL1V+lzJcgjYgmyoDAM=
=8qR7
-----END PGP SIGNATURE-----

--XVTPT6MZt3zd/C+/--
