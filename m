Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF28624248
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QqVHdPfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF28624248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeGDV5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:57:19 -0400
Received: from ozlabs.org ([203.11.71.1]:41057 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeGDV5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:57:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LZbJ5Qdwz9s2R;
        Thu,  5 Jul 2018 07:57:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530741436;
        bh=miDfs7xnnVx06czC23wNlXfXR8pAse6xguUoo9EhpdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QqVHdPfukQ8r10yc5pvs5BsaTMCsk8bXTfC+pumssRR7Ah5U3aSJQh/Xg/+ga10CQ
         nVCa4A0FGEego5H0Ix7Ls/XZe5uZlRkR77nFiWaWEghs0IPHNdNvVFKhq84UjTxvRi
         ZOtjToXe7ipjmliP1KbqWoWZ3xclpUwMMAnP7UT2IlXc1bDwVpwDlRhWdovdF+8xk2
         1bDQb29BVJAVsHHr+cJWc7SX2tpKzG7hF94azG0NHnc2Q6DjtfJGKsmoVUCbM5iOTI
         RNfIVtKuShJPW3PAXFhksyLxgHkVPYqiegYTiZniTN0u9paBZobRKJ5+9LqrPlQuHc
         ALhfvVhGheh3A==
Date:   Thu, 5 Jul 2018 07:57:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the gfs2 tree
Message-ID: <20180705075716.7b4cccf4@canb.auug.org.au>
In-Reply-To: <20180705075544.70f2eacf@canb.auug.org.au>
References: <20180705075544.70f2eacf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IidsWYaC.=ao_vXr9TE3mJB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IidsWYaC.=ao_vXr9TE3mJB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 5 Jul 2018 07:55:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Commits
>=20
>   0627518adcc8 ("GFS2: rgrp free blocks used incorrectly")
>   b30cbec54def ("gfs2: Don't reject a supposedly full bitmap if we have b=
locks reserved")
>=20
> are missing a Signed-off-by from their committer.
>=20
> Not updated in the rebase.

Just cc'ing the committer.
--=20
Cheers,
Stephen Rothwell

--Sig_/IidsWYaC.=ao_vXr9TE3mJB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9QrwACgkQAVBC80lX
0Gypogf9EO3DEddPVvoECK8XR5LYypYfJw4X1aqxT0YSqij69kg0LoBAEF5xCOfH
DUheQT63V1Nf4Osiun4RRsUEbXbe6rH394yaABxXZdO0hgixQnQlXDIe+izRn4Xc
RYZlUC1UIGffABMD6lqoRIyJpSR+3BcDUMk7yHlXOukzRALv3hFEn++emcx37ZyS
1FpPUG1sAI2Jb9yZ/QvNLIYJyFZwcgqvnZZvBJaF0M+KuEG5tdPylznPRTqU8Okn
v2U1chXUTpMXBtLrqKIfqS7szuIKjR/5+IpCrIuDaDnNnGa9L/ynSLyaKqoEgL+k
q4iC0CwdLql39QXfzuXmLC6PCwpGyg==
=UWFE
-----END PGP SIGNATURE-----

--Sig_/IidsWYaC.=ao_vXr9TE3mJB--
