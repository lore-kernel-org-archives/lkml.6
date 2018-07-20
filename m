Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FA520833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SA18PfJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FA520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbeGTPde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:33:34 -0400
Received: from 8bytes.org ([81.169.241.247]:34314 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbeGTPdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:33:33 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9662025A; Fri, 20 Jul 2018 16:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532097896; bh=ALMZL6kxXyvuxRB1JqGJjncnUGLH+HSKuqzeML3qRs8=;
        h=Date:From:To:Cc:Subject:From;
        b=SA18PfJWg2CJzkkG/My+NHBJ/zvDcSKVe43aunEmXKw1nlNrjptM8oRBc65wPAOU7
         pbJxlsW7XEecT+OhoJcN5cOF8ymSIaVpj0cV8JEoN2epeVuNQi5dlL7V6Pja1gQl+x
         mfQ/L9ylD04GdJ8a3ONZnYEPH2qL13ivlBC90PQp5RVsjFNXT/XVAdv27Tp1mFGfje
         bYvEJV8knWxk8ykgC46g7eVS8sLpxpChOslcfbBKr9i5QTHI8zLsettyr3I69jf5mM
         fWFYmKKJ71oI5ycLg93iHnXP4vmnw359fTaJlur1OSRyU7WyJvDEhsWmUe4FDmW+sV
         HnlQvxvUc3G4A==
Date:   Fri, 20 Jul 2018 16:44:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v4.18-rc5
Message-ID: <20180720144451.n25pzfucez6rfmyd@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lnh6mbxoijw4e3o6"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lnh6mbxoijw4e3o6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.18-rc5

for you to fetch changes up to 2db1581e1f432ac6b4efe152c57fdfb4de85c154:

  Revert "iommu/vt-d: Clean up pasid quirk for pre-production devices" (2018-07-20 13:55:56 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.18-rc5:

Only one revert:

	* Revert an Intel VT-d patch that caused issues with the i915 GPU
	  driver

----------------------------------------------------------------
Lu Baolu (1):
      Revert "iommu/vt-d: Clean up pasid quirk for pre-production devices"

 drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

--lnh6mbxoijw4e3o6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJbUfVjAAoJECvwRC2XARrjBbsP/iTyqKYOYV6j4TPdLyvReM5V
XbuwFovvm1B95yv87+VHhUDu3VfYvYVpB/bTus8PAClyZAVQPnNwmiZ3WiM6032F
BcZATK3/i7vFNFwjNgIaqffq338R4E7FBYRjJtoS2P/BV8AyO1rSjgBlNpqTjxAc
YtmLRAzJCEb/b9A2CRj86r+V0gWwCgRLqOzU1X04S741n39mNURvgKa1D9fRX1xR
0oERS9N5F6NyxiZHYss/803TWYGfVat1+5imYMSICMC9rlFw7EW6lYnxRJ31Pl2c
W8BIHJKNtt9vvb1qy3wJNoO/aLx6lQno+EM2rAf3mHnPoM2fNCSHrB1Xq6MK9/y9
lSeENgml+zlXtJPD3NnuQzKpK+wqmNCY67Bi6G0p4un1qcAmbRNCMXrI+WeepvU0
RVbbXXL7hghi74BBH1n9VcCOwr1VvAFY4VupmoQZf6BQdtXf90O30lQHoYCEdcSp
TOq7AmtCh5IybPJDl/L89E/g/yd84+9VSnkbV/Mg/9Fw6cWwbphIzrC3yB338mz0
5snFyJ4dAbjvZmUE9OHlgYelDVB4xSNDybsYCoPnpc7KdgUPOtU8PfArv/Uujcne
QUdo2Pmr26XLpS+Khl4edgwX25wIiQFIqSbVST7gs7Xlk4CHswoLsvaE9yyqQnKq
yiMLGHBbEl0BA1qOLqF+
=QMVG
-----END PGP SIGNATURE-----

--lnh6mbxoijw4e3o6--
