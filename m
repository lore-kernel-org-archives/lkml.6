Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861EFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B5F21772
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mKCiy/Bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B5F21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeHUHg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 03:36:56 -0400
Received: from ozlabs.org ([203.11.71.1]:36143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUHgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 03:36:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41vcqT15BFz9s4V;
        Tue, 21 Aug 2018 14:18:29 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534825109;
        bh=PhNwNuFy+hrb71LVZTa77xB1KhwQU+n89/uCALBOhQI=;
        h=Date:From:To:Cc:Subject:From;
        b=mKCiy/Bh7OfDGq63VrZcPDl0yi/NVcNYtN4UaAO86cmylorK/ptW8UM5n2mz7veP7
         eF3ABWSktGmULlZj6ZK/isen+e0RTChUyUx8jNroROnFGgRX06GSQNA7090KMlHbOx
         8hr0PTrcr6dOYad20RANsvZ1tKS+4HRsGzMb+WMBAxMXPH2ZUzBYPQOljlQ2xCRjBM
         1Z3JOXdrwt/eaofGguKNcJQpB63QfGvsdCTOwmBhSm7JqskB0cRMraKA5pqKzhsmo9
         CLdW0SaTqPCcWG1ILIX3/1i1TTud3zCJhEPRKGhwxU+l2ikVIO6v9aIuT3lXim2ckP
         9FAAbTCxBXI0A==
Date:   Tue, 21 Aug 2018 14:18:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20180821141828.1cb8d79b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G_xG7BPp_kumybNHs9iYw3_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G_xG7BPp_kumybNHs9iYw3_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  eacb610d8fc4 ("cifs: create a define for how many iovs we need for an SMB=
2_open()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/G_xG7BPp_kumybNHs9iYw3_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt7kpQACgkQAVBC80lX
0Gz7Owf/WLUa5Wx6wUUHAkqvvNUOZQYRceWB2G/E+IRq8fD0hQ7tNKhY4IbmEVCZ
lAnh8YnIjJd8woqu2EECDqHDm9FMhQzvtQ3ddHBqDq7Vf4qKJ6xVe6OJNPTx7E5f
NmWfqBTGhmVDjGTX6cKLsYvo04Nytr2pWX0I/inSPuiqNBNLMDVPnAD0LmNzAo1X
/N8OLTSIUHEP/MpjkTxftJW3WjD0VR0kZxwjcYz1UTLCkI46rXZ8++LIRvnGyJWg
9j1L9dsR1/U6BE4cxbeiT2iP9tcO9zQGTiJsifjbsY71LbTeG76Defx7O+CLObrH
mx+aCd1PatLu3fKMot3TBZz4NAQUMA==
=vzg2
-----END PGP SIGNATURE-----

--Sig_/G_xG7BPp_kumybNHs9iYw3_--
