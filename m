Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE1DC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEAE2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DLHGUz1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfBHLBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:01:43 -0500
Received: from ozlabs.org ([203.11.71.1]:59341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHLBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:01:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wsgl3mM7z9sLw;
        Fri,  8 Feb 2019 22:01:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549623700;
        bh=GRl6mZ7OoVtnN+MxWhZgwoyhRyfCX0aTeDdTvImfu/A=;
        h=Date:From:To:Cc:Subject:From;
        b=DLHGUz1zfCA4iau4Q0MCCAfablvAtMPZadShp0w5MBaKTUstAOpTrDXNZylBrQkUw
         1Lk3uPEj9V8TBSs9vqelIzrGrhUeTeaacfMjbTG70AYfQA/Z1NjHmus9xWtoO1ufB6
         qK+JdEWBjoMPyeWGhA3eFUq+6mi5PRtyBAprtjms3Ge3Jq3ageW0ICpoWcInp5OyPR
         6uqfdBqHm6MDChw1+56Ah7owqRPK+HHCUpBkxfTDp5hSDaIQq8vMDbqFMs1HGS4PmE
         dB3k3cZkCyHu03Z93yjuLAduiwfcsDuPVc/woZrPZeCKYOao2McUaIIOGqIksVS/uX
         D7igrYrzxEp3w==
Date:   Fri, 8 Feb 2019 22:01:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20190208220137.3b72799a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C3feybT0Xi3BFuawYg3fEx6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C3feybT0Xi3BFuawYg3fEx6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  053ff09f1a8f ("drm/rockchip: rgb: update SPDX license identifier")

Fixes tag

  Fixes: 1f0f01515172 ("Add support for Rockchip Soc RGB output interface")

has these problem(s):

  - Subject does not match target commit subject

--=20
Cheers,
Stephen Rothwell

--Sig_/C3feybT0Xi3BFuawYg3fEx6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxdYZEACgkQAVBC80lX
0Gw0QAf8C046C8xPcADPgFxNqDSejsvRmKF/t9scVN+qKCPHg+kXidE9dVulT8bV
tC5HCFGinJE98OJ+3V5SUN6Y5Dc39iSfTUbRjgOH7p7/Z1WIMNwquwPVez6oJVUk
M2zRAOJdPYGfPEttQOa1KhRK3p2fsoPLKYHmtUPnucAJFaHizhZZNg1iB+zIUDF/
xx4Mf85c5Q+zosgT3aGdfeTdrwfnLC2wUIzzBnrSgTFp4c3ubXmVEIMDvdeY8N3s
1XAKRgOSxvAOuTjaNHYZfK0F2I2hL6i1ApuDGvxOHtS3lx29aNbFGFpajhx+9PjV
+kfslUgn5/HeT4m4Hz7H05R67fnI2g==
=M+UJ
-----END PGP SIGNATURE-----

--Sig_/C3feybT0Xi3BFuawYg3fEx6--
