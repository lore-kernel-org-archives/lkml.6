Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E28C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78272082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a+/xj5iM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78272082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeJaHMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:12:09 -0400
Received: from ozlabs.org ([203.11.71.1]:48863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeJaHMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:12:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42l5RP4vrmz9sBj;
        Wed, 31 Oct 2018 09:16:49 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540937809;
        bh=hobQd0tJ0nE+jk/tNYqr/4gecT6FwRkIjSFEFUfMKs0=;
        h=Date:From:To:Cc:Subject:From;
        b=a+/xj5iMCVIt9LTPS6GUyHRLOsXEfoU1Bf4HtyrHl19OfPJgMdiunj7AbjSyjaGTi
         ELE3RA5AAlR78yTZX7vpv3CfeJ+3PtONKmFQPgDRpyS0p7FRf25TmHwSa++sd3NgA1
         SMNwzm53DSZLgGAGRTcf5abDt3NHSDEQvXzGGJ1V5I/RC1hNyeWgy76eSLUxTva//s
         u5jMvbRvogdpwoCIdCN0nCZzesugi3UwkU4j3FMm14P5BUOpjeTruiSABRhbUnxn9T
         2GrvEzMi6Y182hozAPcH3AaAciA4pYXROPDHuPOe+BFhLEnsDFPz27rK55uD95VSYQ
         zdwMy4cgJlJtg==
Date:   Wed, 31 Oct 2018 09:16:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tpmdd tree
Message-ID: <20181031091642.6ca5943b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8CfVbeCpjDUR08IAju7CjnS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8CfVbeCpjDUR08IAju7CjnS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Commit

  e22bf023c141 ("tpm: tpm_ibmvtpm: fix kdoc warnings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8CfVbeCpjDUR08IAju7CjnS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvY2EoACgkQAVBC80lX
0GxRWwf/be5yxQEl/iIMEHioE1S8jE85hSNxpWBjXD+oxN6edbYPtwCH3kyrfvCO
XET/Q10IRGl4FjuYPcIgP2iTF4iHU4dZjem/lA0rnlI16H+YZnmKPGRhqwC9CR/3
7lQIo8q3/LV5kjxJ6YGEhhvgUB/r1AcRUN08wtrs2gRXM/sYqrH6ch45kCS9CYtS
RdBerqgIAu5AK1yn/1FMBuqJvboVwj7zes0MHVnCs8mP8KDGy0YkuRkvWDDFsjR0
JqW55LRwbmTs9W3TjicWwmL5hPAcTNh7F5fI4JG4F0P1yljypnBiGOUMuqhKxA9q
tkpgP1dsyhEUMSaYots2nUsw4r/BgQ==
=wegT
-----END PGP SIGNATURE-----

--Sig_/8CfVbeCpjDUR08IAju7CjnS--
