Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B77C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB79020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfA3PG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:06:28 -0500
Received: from 8bytes.org ([81.169.241.247]:35880 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731473AbfA3PG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:06:26 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 365842F5; Wed, 30 Jan 2019 16:06:25 +0100 (CET)
Date:   Wed, 30 Jan 2019 16:06:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.0-rc4
Message-ID: <20190130150619.p36c4rzds3lhl4xp@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aadaewmv5to66yg7"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aadaewmv5to66yg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e8e683ae9a736407a20135df7809090a446db707:

  iommu/of: Fix probe-deferral (2019-01-11 12:28:24 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.0-rc4

for you to fetch changes up to 9825bd94e3a2baae1f4874767ae3a7d4c049720e:

  iommu/amd: Fix IOMMU page flush when detach device from a domain (2019-01-24 15:24:49 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.0-rc4

A few more fixes this time:

	- Two patches to fix the error path of the map_sg implementation
	  of the AMD IOMMU driver.

	- Also a missing IOTLB flush is fixed in the AMD IOMMU driver.

	- Memory leak fix for the Intel IOMMU driver.

	- Fix a regression in the Mediatek IOMMU driver which caused
	  device initialization to fail (seen as broken HDMI output).

----------------------------------------------------------------
Gerald Schaefer (1):
      iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Jerry Snitselaar (2):
      iommu/amd: Call free_iova_fast with pfn in map_sg
      iommu/amd: Unmap all mapped pages in error path of map_sg

Joerg Roedel (1):
      iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

 drivers/iommu/amd_iommu.c    | 19 +++++++++++++------
 drivers/iommu/intel-iommu.c  |  2 +-
 drivers/iommu/mtk_iommu_v1.c |  4 ++++
 3 files changed, 18 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg

--aadaewmv5to66yg7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJcUb1rAAoJECvwRC2XARrjlPAP/3h/QtSqtYk2Wa85tdNjbuoM
qAjZWJ+gEDP3g4VHpGvcZ50/0yQwQT1IBC7Nc3OgU5zm8WXOjxDkaPlQho5wNxux
sk/BwwUGYRT9P5z0W5xpygv49qqK3M+OxHIkyqO/on32O7NfkVn1aUhwKPeU1st/
PNo1qGokccUS4JharyPGw993TyDkzenAW+Mqs7Js9Btf1/Fb2dFam6/jQ1ptEHLs
XDG8kbQBUQ7TvmbiTg+GT4e5ZCuvMtGDCsLrvO4CTXWsE4T7WRnrjxBC6pQte0h1
HywjqrRC3OEuzPjknEW4fcpkwDLj0FaVftngiYI+HRyGzZhD5nffarY7ecRExbfK
Qzhc6pcwg+R5yjxsU9ihd18JQQUHzAjMk6Lh9ieTr9u1eexkIstDl5QFyB+XQHul
530ITnnLLMrLO2XZQMJBiSpQAxMDA0jtU52jTNLhp19LsPwrEngLtLEjI1UpbO/v
aonfq9B1wwlDJuN2iwUwWOMlJXC8UptyC6pZPtPCKxaBiCFVI/0WQmq05U3q9Np5
nLnBlefONSEuUyrOs6WopBYbUxzmMt41PFewRklh+Sz0k+So3N3VG5scXfdQGacO
2woCYkne1OibZQ+LPvH6R/NnrTUaWafcXT2uW0nvK92zq7wXb52GzJwoAT1wfmzM
v/16ovbf4lUgxwfJdqs+
=/kNy
-----END PGP SIGNATURE-----

--aadaewmv5to66yg7--
