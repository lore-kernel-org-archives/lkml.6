Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeBZWi4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:38:56 -0500
Received: from ozlabs.org ([103.22.144.67]:46275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbeBZWiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:38:55 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 27 Feb 2018 09:38:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20180227093816.29519e8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m4b+xJghlZ3CkHs3LdweTTf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m4b+xJghlZ3CkHs3LdweTTf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Commit

  2a84d1aef423 ("rcu: Inline rcu_preempt_do_callback() into its sole caller=
")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/m4b+xJghlZ3CkHs3LdweTTf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqUjFgACgkQAVBC80lX
0GyU6wf/b2h5QMm26Q00/gx5tu+qLrmJzPTSXeS9e/e2Um7ul/FCkTeq07FiSRpy
kayRwjrRj9cmPpgAEDlH2+CUQtXrTOF+aDLDQkOzQi0BFdqpnWrBFFw14DbfoOKb
eMOTOpNWWKQ0onPmhgJmkcYXF3eT65vE8GtIvkxECMAW6q0rBUyv11i1TfH1OJIG
bXFmjBDzyKGbFoebWvvAv0l+LPQnGsCtnvT+uniiGTK2ih+61DNZvXqc+cBXFvtn
veqTT/12pPJqktg4Aa+p+r/jD9P6FbWFQPE5/805VStXfJPyF4wpB+YtGD10FBhq
ySiagWIsvG9ysqBJ9HfINJ5gQ6ZjtA==
=bvJj
-----END PGP SIGNATURE-----

--Sig_/m4b+xJghlZ3CkHs3LdweTTf--
