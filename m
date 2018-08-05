Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8145C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76045219A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76045219A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeHEXpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:45:38 -0400
Received: from pide.tip.net.au ([203.10.76.2]:38233 "EHLO pide.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbeHEXph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:45:37 -0400
Received: from canb.auug.org.au (124-171-82-245.dyn.iinet.net.au [124.171.82.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pide.tip.net.au (Postfix) with ESMTPSA id 41kDh63T9Sz9CVl;
        Mon,  6 Aug 2018 07:39:32 +1000 (AEST)
Date:   Mon, 6 Aug 2018 07:37:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20180806073705.27b861bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D5wJEV1V=GcgNH.3P=XMxzz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D5wJEV1V=GcgNH.3P=XMxzz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Commit

  bce17edfe6af ("fixup: ".  " in PLIC docs")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/D5wJEV1V=GcgNH.3P=XMxzz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltnbgEACgkQAVBC80lX
0GxDyQf/YIYv4JHRrEunH7UIcdPqdJhMK+FWmyydoZnt9AAe2OU3dliG4lLJsuo9
PHQ1dwfC7ossI8J4U+a3dJUGBo5ycvN6crW5VaFyjBHFjy23TYz1JrbzO6cnSv7g
Ilgx7cb9ZN1HAHvotThrieaCdLRAz/ZGPONl0WuzmumNipZmOiKsKY8j5l58Inkq
8fQV/eKIJpw2la9Y+wFLV+yPqN54CVGP6fLssITlLF1lk1BcYBsQkjZTOezcm3aQ
GLmMhdquWBrhf4/dMHL3CfMhQE2cJ+J/fFDGAK+MaCd1xIn6eEIf9gmyYGnTvoJb
oLxxKddan+83k7I8LfitPlQOFNJKhQ==
=DnCM
-----END PGP SIGNATURE-----

--Sig_/D5wJEV1V=GcgNH.3P=XMxzz--
