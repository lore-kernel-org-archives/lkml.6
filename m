Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF865C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF262184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M3rwtuYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBAFvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:51:37 -0500
Received: from ozlabs.org ([203.11.71.1]:59417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBAFvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:51:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rR7948KCz9sDr;
        Fri,  1 Feb 2019 16:51:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549000294;
        bh=Mp6u+Y6qA2XWZ2OvaPm0cRe0sKjwLt41Abq4VSmKmuo=;
        h=Date:From:To:Cc:Subject:From;
        b=M3rwtuYdcMvnzzXTQ6EUirpeyPgRPlp49d5L2Wq5uCd9eaXpr+GjZ6JejBxcSc6fW
         utcOs1I3mmuQKjI5k8E7tYZK7y9cQwQgun7ndLENlgXNQpq5LZYWEP/67hZMiN4tr2
         YQAs6s6XWLZS2+AW5fw5noE8Bd34tRm9ntv9FuvuWWAxZkbX/HOChasG8KfPLsdrpl
         j700hxvcu1W2WobbAy2E4nb7UOe3RNZxZq8D6sUHLrVSOkJrgFhyDN0pRn5M6aZINB
         TJ80xcQBu/c4gL4GIVGYBeW59ir1rtTiXTWZ/Vn6bBpj9SdXrrbhakYSWaIUBlnWnI
         TspQrzXExYXYg==
Date:   Fri, 1 Feb 2019 16:51:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci-current
 tree
Message-ID: <20190201165130.1d9c9850@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+X_QduJiQuiCX+69A_u.8Um"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+X_QduJiQuiCX+69A_u.8Um
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commits

  f14bcc0add3a ("Revert "PCI: armada8k: Add support for gpio controlled res=
et signal"")
  432dd7064aa1 ("ARM: cns3xxx: Use actual size reads for PCIe")
  65dbb423cf28 ("ARM: cns3xxx: Fix writing to wrong PCI config registers af=
ter alignment")
  a4ace4fa2007 ("PCI: imx: Fix checking pd_pcie_phy device link addition")
  a6093ad7fc49 ("PCI: imx: Fix probe failure without power domain")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/+X_QduJiQuiCX+69A_u.8Um
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxT3mIACgkQAVBC80lX
0GzNZAf/YdQlcA40w+mUjg3UwGwS3ez6czuFckWuqlvEvr7YLKGsOtA1sxmbgFvJ
MdAaKXrAensDCDRTjqkXs2gExprhdu4Fhv97mF4QqCupW817hM+mMvMXMApiqMgr
Ihq4/qFF2wb1gsxukeZuHcCJ8bZiIfdrT18MkOsmWTQ5AHXatDgcqfO9jsd9VTj0
l5twhsxNJht+ou+0534KHy8x7Oz1xW8YjQgKYig71B/80a3b01wVa9vbUG1a5KQl
6SGllmoIyUrlZoVrn2mbe0Rd6WMhb+puso5rliRs/6GdVKIYgI9rYYtI2ekzpi4H
Wzd1ZVLaBUL8vXdsWmg1/+JjHVsawA==
=1rQ9
-----END PGP SIGNATURE-----

--Sig_/+X_QduJiQuiCX+69A_u.8Um--
