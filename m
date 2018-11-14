Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A61C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE14422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qxrYOVys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE14422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeKOFhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:37:55 -0500
Received: from ozlabs.org ([203.11.71.1]:44833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOFhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:37:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42wF5s5wH6z9s3x;
        Thu, 15 Nov 2018 06:33:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542224001;
        bh=C1a4fwZ99xOBWfP0k/U7Myn8W45RFcQ5Ovl15/2XzKI=;
        h=Date:From:To:Cc:Subject:From;
        b=qxrYOVysdUDGDkFwIBxmVU9LnUdYUwx3jB4LeUHCaFgyJNbojqF6FIM+4+VL4s4fl
         kWOuD8X8C2vZEmekHHivaC/igNUXovArDKr7/jzYiA6G9Zs4Wb5eAMmB2fFz5WZbYl
         2MHDzzyF8IQGD8Kf72eWvCtB9GjhldIQpPj6bwIhagh6kjB2Jx/w6q5O0XPLQ/bttj
         1QYCtxSPQnOCTPoeZ1AJdIVsoCCqnwIMdt6eLVPR8FvzBqhG5abs1vfQjgHz8OWnQw
         9OPjdnAO7rGj7Q+eiF9vGKvqznz1pca4KJ/kZH3B3MWl0LEEqWRNIwklNUzJzgVm4W
         EnloGET8b4lew==
Date:   Thu, 15 Nov 2018 06:33:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johan Hovold <johan@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the gnss-fixes
 tree
Message-ID: <20181115063321.401ebe38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gv6Pl5HsywQ9ayVb+thYplC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gv6Pl5HsywQ9ayVb+thYplC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johan,

Commits

  9ac9252b4bcd ("gnss: sirf: fix synchronous write timeout")
  b1a003961711 ("gnss: serial: fix synchronous write timeout")

are missing a Signed-off-by from their author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/gv6Pl5HsywQ9ayVb+thYplC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvseIEACgkQAVBC80lX
0Gwl6wf/QVQsh3cXtm5YCEJFrF9hl0NYnQiSAVyMUxHDzbXeBRQFQVp2TSffdeEo
OpoMBsJ/M8ea3WMZIm9P4keX1+2UCkjUR9XyiK0LOuDl+qDF0Rovh2q512e7keX3
27tf5FVBAcJgfvhPE4AEivTEGpK7o2lDYpyzYkSLioUUgiRImXLmft0awJ2kKE5M
kQ2oZ9FmqHLIPJ1TMxO7w1j15JeJTyvfchHD5cWSt+TdpIYrizrP8ijHR8YRdzlp
PymtQIOIDNatUUdQ9IZTlDSUkxQ1u5oljmeoha3iw6rdEVlDLHWUM9/iTtlNioI0
/3hvXvs7zk45VY4uvEekLQlW8xieCA==
=Rxq0
-----END PGP SIGNATURE-----

--Sig_/gv6Pl5HsywQ9ayVb+thYplC--
