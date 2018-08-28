Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B125C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE742087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE742087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeH1Rhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:37:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeH1Rhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:37:32 -0400
Received: from localhost (unknown [104.153.224.167])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 39EDAEC7;
        Tue, 28 Aug 2018 13:45:47 +0000 (UTC)
Date:   Tue, 28 Aug 2018 15:45:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.153
Message-ID: <20180828134540.GA9535@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.4.153 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 +-
 arch/x86/include/asm/mmu_context.h |    3 +--
 arch/x86/mm/pageattr.c             |    2 +-
 fs/overlayfs/overlayfs.h           |    1 +
 fs/overlayfs/readdir.c             |   37 +++++++++++++++++++++++++++++++++++++
 fs/overlayfs/super.c               |   20 ++++++++++++++++++++
 6 files changed, 61 insertions(+), 4 deletions(-)

Andi Kleen (1):
      x86/mm/pat: Fix L1TF stable backport for CPA

Eric Biggers (1):
      x86/mm: Fix use-after-free of ldt_struct

Greg Kroah-Hartman (1):
      Linux 4.4.153

Vivek Goyal (3):
      ovl: Ensure upper filesystem supports d_type
      ovl: Do d_type check only if work dir creation was successful
      ovl: warn instead of error if d_type is not supported


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluFUgQACgkQONu9yGCS
aT781A//VJPB+pKyV9L++eHiH2qY0TEreMW+qeT1tJwWMJPZmCXEqkF+ZEPWO/5a
owznELIuTcSn/VYpIWUVSRvV+l7wLPu3VVLJz6gbq4kfGqYCW50It/5zCzY3VwS1
AoiyxBtF8C+nIpdZxx9rlycl+wo0OrFsWSnMX1B8ubHHWCeAF9Dy3NK4D4fQnUAa
NO0sD1jzWeAj+RIeJUcqgahJuuIlmThNcg70F6lJ+xsNr4wrsASav2bK4dPDAxL8
86kww+aUlpVwmBkZ0mPJlxnZamTYj+XBhtxN9KATXBChRHomf8McTqw/wjM3i75q
mnhD+WbpOiHNGYY4hJyair7cRYA1JWXXapJlkAPgQ/Scjyir0R3udFOo8dFlLDkh
aU7xMBjTlyX6uXqIFH1BjoWvMP8EsOOiPHa7Hj4njUY7oOQXaLFBTy6nBju7gHnC
Mn3MMki0ifqeSo7G9WQMNeVg9fTRFlf2Auu/NG4viInBqy5WFE32Tnmjw7Qd6BZF
JEb3QKnL9AKtJKuFeErXEasUrYVkMl7V01dEsq3Nietr7DhZtr0cbGGB2qBlTIUr
fEK4mRd/P+TML36fST978Dfg5BQ553lcA3VPfuR6Sbk89ZpS5Ab/TLIlbO4FS6+C
4lOtST5U280nGAiEm5ueXeX3Zr303vEoW7ZCj3VFji/EMPvtLvY=
=92+C
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
