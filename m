Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F69F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBHQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:49:46 -0500
Received: from 8bytes.org ([81.169.241.247]:39034 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBHQtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:49:46 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3487E1AF; Fri,  8 Feb 2019 17:49:45 +0100 (CET)
Date:   Fri, 8 Feb 2019 17:49:43 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.0-rc5
Message-ID: <20190208164938.GA10077@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9825bd94e3a2baae1f4874767ae3a7d4c049720e:

  iommu/amd: Fix IOMMU page flush when detach device from a domain (2019-01-24 15:24:49 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.0-rc5

for you to fetch changes up to 8950dcd83ae7d62bdc2a60507949acebd85399f2:

  iommu/vt-d: Leave scalable mode default off (2019-01-30 17:23:58 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v5.0-rc5:

	* Intel decided to leave the newly added Scalable Mode Feature
	  default-disabled for now. The patch here accomplishes that.

----------------------------------------------------------------
Lu Baolu (1):
      iommu/vt-d: Leave scalable mode default off

 Documentation/admin-guide/kernel-parameters.txt | 7 +++----
 drivers/iommu/intel-iommu.c                     | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

Please pull.

Thanks,

	Joerg

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJcXbMiAAoJECvwRC2XARrj0GsQAJvAQWCBrKYSpKB8iHtawflT
WngDxifq489v/4bVbYtPOqJ8izi+cmim5dzRHi20e175V7EFaPCQaglr3yHOrSzN
+FYLwFeT23Q4dpXe7hlc/S5V4MA/ssU2l8lkTO5j1bwrFOtRF++9urI/0Heo3l8Z
1+Sm15y6rp2t2jPRmc50HF2IbDncfD56Wyl0PUrJxR50NPpJo85ld+fZjIfdN0d3
qw2bXOV3bapOjaNVHdlibbc7kt5gmJcWfabO02ewhyzVKxAdcvti9jmW6e7AOMTE
7pMcGPe+Ih3n7lKR8MX03o/NJKosvQEhqCRHqDxLcYtQZCBREe54/XfFSN/G6tDN
9uuCvPjq0C33DQC2Yu1NdTZMjIwJ4JEzPoBIA1bIT1dh+d9b8rhIawsIBuq8qnyv
7R2qiJReuFiP7uGUboClW7ao1f2jr5y/8fFuwYe4bCryGS9DhhxLyZnvw8jkO1Yv
BYGt9npjS4R160Fw9+NShDhtY1hwLg37FMw7JHlbX5KmEMSYw0zyophzaOKFoZ0O
/ZIbgW4LspgMiYEYuv4gpBWlaQvNMUPJqzWPXqslZGsJHu5h2nCPzXWSeiqnT+yL
SHt3GGGUekWZ+Glqs2OnwckGZ4L32+H5Gft/da26qrznBSF6CFEh4IlxFretQ5DD
ID6a0VUNG6uRJk+DjW4h
=esHw
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
