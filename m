Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeCVFzW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:55:22 -0400
Received: from ozlabs.org ([103.22.144.67]:41753 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbeCVFzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:55:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 16:54:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Trapp <darren.trapp@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20180322165438.3b928745@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A8i/COzi_VNakG1=/PYJ6af"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A8i/COzi_VNakG1=/PYJ6af
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/qla2xxx/qla_os.c

between commit:

  2b5b96473efc ("scsi: qla2xxx: Fix FC-NVMe LUN discovery")

from Linus' tree and commit:

  33b28357dd00 ("scsi: qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan")

from the scsi-mkp tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/A8i/COzi_VNakG1=/PYJ6af
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqzRR4ACgkQAVBC80lX
0Gz21gf/flwrouQUC4pfKoRZd2Qmm7dkvbOi9XzTfO9cfd3P6gta3OAwx6KxCPLM
es2M6wK8sn6VNxGwduIHiWifnopJmB2YZ4z0WOrBOyO8kFRDil2SgNFN2vv22NY5
eUDH4CM5k7SK6fowpm5FU3JwFEy8JDvHU+HD4imfvmrWB+s/PZQectmDcX3lmmJq
//0J0dmZ9JpOVqOZnfXgbsbelKBIw+FB4bvNRJ3GLmScFrZaqj16AcuWl+8aqAtS
VIUNaeQ4pm22q8LOBO6ivJfxQt59E/Af9J3lquWwVXcNfdIMHj/EQFbeND0B265D
ELvPtUC1Syn2Ee+8Cn6kl8WclCTvKg==
=sI+d
-----END PGP SIGNATURE-----

--Sig_/A8i/COzi_VNakG1=/PYJ6af--
