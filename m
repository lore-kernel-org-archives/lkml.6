Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69011C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4312073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eyhD2mnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfBEUUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:20:44 -0500
Received: from ozlabs.org ([203.11.71.1]:59959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbfBEUUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:20:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vGD760Ygz9s4Z;
        Wed,  6 Feb 2019 07:20:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549398040;
        bh=fO6y3ZJ1GSbCYBDHggwawhJ84DqAlBkb0lOkILdBHRw=;
        h=Date:From:To:Cc:Subject:From;
        b=eyhD2mnxIwy4XP8BJ6eb8xVQhJXGIpOEXDeF5jXW/GPps/9xGvad2rG2/9Qm140gF
         XHx0YsMKN9AOZmHiSdkD1VMx97zUaJ6qc87ZBEEzw7wnUpvsobfjbq6Lr2Xy1Zh4Np
         79aBY70mSph6ybVCrZMRqsdWAhqXdPCsLz/kUw21F/9ZOa51w0frZqo6I6HE+OQUxW
         dSUEYEbXLsJnkMqg8qd4vDtAvyGfUPhGR2SObHl3Pke+TytedSByE6a8JdzFU78Fuo
         v/zyLJnlTx3bYDsJZkc7FmMrbBVF/wkN6jcT6wDESaI0tzb+pLp/3coXkMwrrtvQsx
         U9mmXO1K76Klg==
Date:   Wed, 6 Feb 2019 07:20:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the scsi-fixes tree
Message-ID: <20190206072033.3d04f96b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dH6dPBFmqgDel7/Lh7aRdwi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dH6dPBFmqgDel7/Lh7aRdwi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

In commit

  bb61b843ffd4 ("scsi: cxlflash: Prevent deadlock when adapter probe fails")

Fixes tag

  Fixes: c21e0bbfc485("cxlflash: Base support for IBM CXL Flash Adapter")

has these problem(s):

  - missing space between the SHA1 and the subject

--=20
Cheers,
Stephen Rothwell

--Sig_/dH6dPBFmqgDel7/Lh7aRdwi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxZ8BIACgkQAVBC80lX
0Gw6fwgApPTy3mb0g7GavnOVHIAhJlfJRF+iZnt7ogkJxJj6B01gTTb4H/oPlC9g
6Uq9AVhdm7k5Os8eoCsOS0yGy0ExIiv05exjfLFl/hy8o7+lus0MKlkdUoqRuILB
Kgh3/AuKTY2zHY5k01TVT4j6ZUwqZ6E6FB6QgL/t+7sxiciiCiJ3m9bmRfIhjIMg
Ykxf+xyrUjFMbGFvNJR+wnMyoGpqMSibxeSLw8pXo10s582tYLoTJmkClCJfVido
YBIDBTE22grMJqgqqVTUKlkzb1r7emh6oXZq/TCaCus0J9dqte+18HW7tLo+yMpu
C6py+ETPnuxIeAq7BhuhoVA1t0v9tA==
=/bEn
-----END PGP SIGNATURE-----

--Sig_/dH6dPBFmqgDel7/Lh7aRdwi--
