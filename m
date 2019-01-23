Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47792C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138732133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O0cA3M5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfAWOoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:44:14 -0500
Received: from ozlabs.org ([203.11.71.1]:49019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfAWOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:44:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43l7Mv1rWkz9s4s;
        Thu, 24 Jan 2019 01:44:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548254651;
        bh=tKaTJUlZpGVfOslsL2mqF83Hevfu4NFQirde93eTYHY=;
        h=Date:From:To:Cc:Subject:From;
        b=O0cA3M5ZM/IgaLWc2d1GNq+g+w0MSL9zOoR8Hjc5bsFwVgdkGGxtDltpd2j/DSmw9
         zqH0vZ8Iy440LaqTSunmf09i7ciHDhHg5GYP35F5s+kLtUB5CSxpQZ4Ehj0m/7Klvy
         /+zwmrnxE33NPv+zb8qWOj6eTrLlj4Gy8chRM6mBZQa9l4TbvyTrAzrQQseGP/VfwI
         VjQvuFbu3a8pkIe610KPLK2YlYuBDTk6Lhmll+dFVmw3ymzDajevBJKMadV1CVyFdg
         Fa9YJKVSGtQ4fFeCGwfJbj4JaG0Inwc4kjjonzdh68aTLqr2kYZUqbXOneb1pfIr/Y
         uorkaEoiA0d5Q==
Date:   Thu, 24 Jan 2019 01:44:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: Signed-off-by missing for commit in the opp tree
Message-ID: <20190124014410.5f932c52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X6e3yL38YDIfEbvVH_9I+/M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X6e3yL38YDIfEbvVH_9I+/M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

Commit

  9389d5c08571 ("opp: no need to check return value of debugfs_create funct=
ions")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/X6e3yL38YDIfEbvVH_9I+/M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxIfboACgkQAVBC80lX
0GzLhggAli0bqpNpz9SuR8winZI7RyuoJEKO1k+ImGEE7+o3COJ2toj2KGT4sCTX
xJRjMnUoCUVy7IonGtIgLnkKymS1U9cIotS5KVKhuztqBr3g7hHc5qTn6Ydpxc2F
y3L8BJ+rIxnsWvTnZQwwC6cvHdMTv/BTxVy1BQmhGiRLEKG8fVZ9uJ0kfPRvAgd/
1IBKi9W49JaAhzepDwZRCpOCnL0lgXkEQSsk+a73Rp1ssGESB2Y+bQ50CEYhFgI0
SsRdUU3A4QH4RITt1nCm0vg2N2adbljRwKo8GFJQWogcVtV++UokyYLXCSoFW2w2
73IrzExPOvwpHtMq/8pl4vEWDos5+g==
=YIJc
-----END PGP SIGNATURE-----

--Sig_/X6e3yL38YDIfEbvVH_9I+/M--
