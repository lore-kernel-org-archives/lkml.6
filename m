Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeDWVuH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:50:07 -0400
Received: from ozlabs.org ([203.11.71.1]:60559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932318AbeDWVuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:50:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 24 Apr 2018 07:48:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20180424074844.36464221@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eS6qZoFExssgQwzkQE868cd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eS6qZoFExssgQwzkQE868cd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Commit

  bbf9d3657c39 ("doc: Ensure whatisRCU.txt actually says what RCU is")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eS6qZoFExssgQwzkQE868cd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlreVLwACgkQAVBC80lX
0Gy2OAgAplJgsbowjUuZIyI1llluS61zyTglm9L1UfGIPZuG34BjdU1RqIC5qhDY
VxyHWIoL+BmGS+QNLengIL90P0cy0MsvAKxaZOAI2sAydAcmyMAWhw+KBld3UUh0
Ak+yDDWXQr2m7dpngXUFa8i1LPi0rdT5FmzPCvaYKVRq4OekO44hqOyJ/0YBzcRX
JMgtbU3pYOf5w7Xf7vrN/cPiNP2qgG9w0loO0rzlGqhPk75nt1hITWk+2bdINc+h
ItnjxPLYKvXo0GMyiKMXAhD3V/7n5a8Er2Hv0l5Bxq6A6Luezcc9u2O7gNROj55d
h9RjrrVHav1tQ3mSm1IoZHIj0imEuw==
=oD9e
-----END PGP SIGNATURE-----

--Sig_/eS6qZoFExssgQwzkQE868cd--
