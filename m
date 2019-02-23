Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93485206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfBWMq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 07:46:26 -0500
Received: from ozlabs.org ([203.11.71.1]:55187 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWMq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 07:46:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4467Hg2YxNz9s9L;
        Sat, 23 Feb 2019 23:46:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aik@ozlabs.ru, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-6 tag
Date:   Sat, 23 Feb 2019 23:46:23 +1100
Message-ID: <87ftsellk0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull another powerpc fix for 5.0:

The following changes since commit a58007621be33e9f7c7bed5d5ff8ecb914e1044a:

  powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present() (2019-02-17 15:24:45 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-6

for you to fetch changes up to 8f5b27347e88b171c755562f0090ce40e514fc00:

  powerpc/powernv/sriov: Register IOMMU groups for VFs (2019-02-19 11:51:18 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.0 #6

One fix for an oops when using SRIOV, introduced by the recent changes to
support compound IOMMU groups.

Thanks to:
  Alexey Kardashevskiy.

- ------------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/powernv/sriov: Register IOMMU groups for VFs


 arch/powerpc/platforms/powernv/pci-ioda.c | 2 ++
 arch/powerpc/platforms/powernv/pci.c      | 2 ++
 2 files changed, 4 insertions(+)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJccT+TAAoJEFHr6jzI4aWAlYcP/R9XKlvg96FuYEKhJaV3hj1k
QuN3mkaiEia+naAmQrzFgccToUtiMxtQ2Xcg/WryQyOnLKdO1cGuVOrxXSPvTYAE
ESHH7Odd8htt/zzKi/JvHA02puB4u3CmSJu33q6GgDh8LZLyDSjkiQW0tEDB2Oxb
JItN8Q1Swa+On40y2YIQdiKXhhXgHwsH/Mvc5dkNw7N9dCj6kQ908sKFVJ4C7eZI
E2BHnPMOO5hxMHUPI+4CV0J6tKlPoKmJJf8beO9UsrJnMoXO14becJQyqm25jYNg
TPGU3FijIuHolpnBHOJ8EU6c4D8tufC+RDcMprP1o0du8XVekoT3u63LW9xoX8Ff
h3NRDBPeH+D6WtJFl67QTrsVeXaEE23Y2zeYPAoWhBXNzXTJsaiI5dh9N+rYhO/t
t4QLmh2uTVbjHS7KWRVj5m40AlnIJEPGhX8ja8iqRlK2QVbScWmhdbJQRhMa92oe
6/U10sTV9u8Qk6Tf6jRWJdzQJQsHNDx3q1vChmLudQFpJdwc8WzdN2bThgu50rA2
8I1faYBGs2ol3lmjBciRx1KPf5xQUD4NB9K4nmEjG+wlPtLuD1yIl2CGIqapXZoh
brUCNoisrrs7jm6AafauLyid18jZe+uocLiU09OKzpxWZNXulpBwSRYFkjJAr3b0
Q9oTtKpubUI0dhIgOaJp
=lNXB
-----END PGP SIGNATURE-----
