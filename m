Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C37B206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C37B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440574AbeKXDWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:22:31 -0500
Received: from 8bytes.org ([81.169.241.247]:49390 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbeKXDWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:22:31 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 34F302C3; Fri, 23 Nov 2018 17:37:34 +0100 (CET)
Date:   Fri, 23 Nov 2018 17:37:32 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v4.20-rc3
Message-ID: <20181123163727.aa3hdbnne3aadypo@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tk5lct6z7maxlqz2"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tk5lct6z7maxlqz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v4.20-rc3

for you to fetch changes up to 829383e183728dec7ed9150b949cd6de64127809:

  iommu/vt-d: Use memunmap to free memremap (2018-11-22 17:02:21 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.20-rc3

Including:

	- Two fixes for the Intel VT-d driver to fix a NULL-ptr
	  dereference and an unbalance in an allocate/free path
	  (allocated with memremap, freed with iounmap)

	- Fix for a crash in the Renesas IOMMU driver

	- Fix for the Advanced Virtual Interrupt Controler (AVIC) code
	  in the AMD IOMMU driver

----------------------------------------------------------------
Filippo Sironi (1):
      amd/iommu: Fix Guest Virtual APIC Log Tail Address Register

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix crash on early domain free

Lu Baolu (1):
      iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Pan Bian (1):
      iommu/vt-d: Use memunmap to free memremap

 drivers/iommu/amd_iommu_init.c | 3 ++-
 drivers/iommu/intel-iommu.c    | 2 +-
 drivers/iommu/intel-svm.c      | 2 +-
 drivers/iommu/ipmmu-vmsa.c     | 3 +++
 4 files changed, 7 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--tk5lct6z7maxlqz2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJb+CzHAAoJECvwRC2XARrjCzQP/idwEUlR75GqdMbUIeMQX6at
Ew2I2mOJ/7w9syOxqTJUsTrEyPQly1T3iBNqlium5L+EjaVzBziqeT3pSROX7wjV
64zLdjQLVebqH0/gklnhxRmG0TRn/D3lWDvWISRX1dEqLlOWMOvPPjd+231rxA12
dv+eT3o2srYkq3f61LEKWwGKwBq5WdHh9E9u/PRfM2pqZMs1aRPzsr5Xcz4QsLwK
pDUEfL6uoSnMsSKmbp92vSvnUow5+OMkFq5FZ5OeSzw1dQf7eAZz93ZqCyZYLkwq
8b4zeY6u7/1/kjfcRAyUkOEeM39qMd/hL44fADtcV4PoyQjOo7+PeOfrxZMhjoL3
yU07WJUwSiQxfiMoOEUa+qMzzqhgZC5nJmlThF4fmJ2i37lZmbMLVWdAsx0xsSdb
ZiszfbQ97vWu1SGhifmomSke2IiF5XyTflJhFNoG3+JSqUkci56gRgwT8fQftbdK
I6ZVTOorYrLzUOkYuDJE34lGpxANVYEukyWRlmvI/0VqfLJD8dGvNjy+FMM866Cu
0xTYXCErT4SregZgEUIfVXudqZY1ngo8BInDEuYDkdElSgz1jW0KSsGlorDbTUgB
Z2GyB77dK2a4NHlmSee2FLsvGRCLIFCqmCfOywlsnogXxmCbKxxkKgSWgHu5T0dn
gU0JYrYE6NuWXHpHMNs2
=tZ2d
-----END PGP SIGNATURE-----

--tk5lct6z7maxlqz2--
