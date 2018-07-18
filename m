Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B670ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07A32075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KnFlGWsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07A32075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeGRN71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:59:27 -0400
Received: from ozlabs.org ([203.11.71.1]:33665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbeGRN71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:59:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VyTk4TGhz9s3R;
        Wed, 18 Jul 2018 23:21:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531920091;
        bh=IB/oGBa6N6HE7IEJuO/1rvsAx+SN36KHv0zAwkEOAsM=;
        h=Date:From:To:Cc:Subject:From;
        b=KnFlGWshmYrTcQK49MqoIuAcaKD2qHEtpkKb6dM1kCeCL7SdrCTC+RL8m3VsVnHTo
         KDuPyaec7yhYSWya95seoVWQeoivTN3bvoGNwwsBg6K+K44VpbhNFJU6+Pz5aixkjA
         PReh2p63JMzWvehizqu/owiepj6C3wDbFPwSwTelH8TB0dU1kglBNZKeK2xLixtjyp
         QX9B4AT/QfL5el+/By7jhLrWXMqckaycxI/imC6ABDyImzixiOUO9Kl3E1XrLugV4W
         qQ4l5MN5GN/wGCzwVxCVzsQ6j2CGjPkEQc0yfiBVZH91HQjGY8c263y7hIxKFN5olq
         cArG2jF5wlkGA==
Date:   Wed, 18 Jul 2018 23:21:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: Signed-off-by missing for commits in the vfs tree
Message-ID: <20180718232123.06511414@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0Qtrx1P_uO9oac+/ucCOoGE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0Qtrx1P_uO9oac+/ucCOoGE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Commits

  a8dc7ffc48c6 ("vfs: syscall: Add open_tree(2) to reference or clone a mou=
nt")
  13d2b3d505c2 ("teach move_mount(2) to work with OPEN_TREE_CLONE")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/0Qtrx1P_uO9oac+/ucCOoGE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltPPtMACgkQAVBC80lX
0Gx44wf9GyE/+LqrLEiV+G3j7l7I5dQ7gsBRrg4ybDeZ9KCFdGvXIsfQvfCG4MWg
ypT2Eq7B4Y+B/akIFo7M/syyUsHhDrkEuDcbDn03Zc6rl517jQaqDjgrsm2tzddV
IgkT0RW6EqQYcau5xHiSgpFyd/S1p8QRg9mmj1m5Ke8ET/AQVCLVAJ28TNfHUej6
ZRO1VK/X4IWtBsQJg+E4tr5b/70UNwwNnIZ4Sa1MTGZajYvd7PsB4mGLobyvMTjw
lxqddzcmRkmTA6whH6OjfcPR8sdcmwUHFLL+vy9aNMECBIzMf/tCNAJn5vkJf07A
8svJI58NcCtEAB/rbRIuWlh1LZslzg==
=axEE
-----END PGP SIGNATURE-----

--Sig_/0Qtrx1P_uO9oac+/ucCOoGE--
