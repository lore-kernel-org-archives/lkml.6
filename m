Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8550720821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R2CYGgc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8550720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLJJ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:26:38 -0500
Received: from ozlabs.org ([203.11.71.1]:60643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeLJJ0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:26:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CyPl4xVlz9s2P;
        Mon, 10 Dec 2018 20:26:35 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544433995;
        bh=/y3mX33W28Up20SyCq4OdbTbCTJQhpHUaiKOOtIFGZI=;
        h=Date:From:To:Cc:Subject:From;
        b=R2CYGgc+I4ihNS7o4XwNaMalenxFKu6fFMZtXFpLyXIiT16tN3lHc5gwZ51CSrKOt
         WvGsNjFrCyzkyxfQhorzBxoTT0JqvsKkpEAf0boGvqBCPlh8NSksEnHQXHUnXQbVB8
         v6E5L1VIY5JTOkklg6jSnWGSb0FBf8jtweZByEbn8Icimwpf3DQ2R1Qsv6u2gemMAG
         4PVCESrCrcnOoPxYFBllguH08MvK/ZrCa7lWBj58M+BzxJeBlrIKgI495Blg8iONzd
         4kP9zjb5nH2kv8rPNMXnmZWLzF/HOcOtAmNoRQqli5h4GkHdTcRaBflP415bwZ9W2r
         oSNNTi+uwkKyA==
Date:   Mon, 10 Dec 2018 20:26:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fscrypt tree
Message-ID: <20181210202634.757d79de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0A40plGECQFulxovEUkSBCo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0A40plGECQFulxovEUkSBCo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  24985cf0be81 ("ext4: use IS_ENCRYPTED() to check encryption status")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/0A40plGECQFulxovEUkSBCo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwOMUoACgkQAVBC80lX
0GyGlwf+KMfR3IbdYouGEZG10JczrxodqTCoVWar+WBK1JPAIIDwCfsDyhx2qLa5
gIcu/TuT4TqFwpJhCtyTjWR/awbeum7BCU7jrtFd3ZIm0l5n7FYJaL7yOSLE+1n3
GVpUILgGYaEufK5Fo/lYFLn6Nj268/QWh4aD/jBro2CEd8KGAU7QqU3JY8suloaU
dNzq1uo7c8uSdFENn7s6N/UNshvtwxL2nyx6x09Ag6yMrtMhix9QozmUrfVJeR4c
C2AgGy1osBYYLUt6rFL958fdsTjt4JhqtchddLtAblPLUwoQWh56zICHRbhK83Jh
o9MIOS+8zHFVVB2uF1BNXSwfjcLEYg==
=UnMD
-----END PGP SIGNATURE-----

--Sig_/0A40plGECQFulxovEUkSBCo--
