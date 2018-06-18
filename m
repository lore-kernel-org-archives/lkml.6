Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61386C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0956520693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qO7mc4kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0956520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964875AbeFRWyd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:54:33 -0400
Received: from ozlabs.org ([203.11.71.1]:58633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755329AbeFRWyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:54:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418mck3nypz9s3C;
        Tue, 19 Jun 2018 08:54:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529362470;
        bh=iha6Kt7qSpyiehy+i76zXIuOCTB5MDZ9P/2YGyU6lms=;
        h=Date:From:To:Cc:Subject:From;
        b=qO7mc4kGHi61KC0xAFR6UaQedq1hp8GvJxhhCHA+7d1Gv/0pzUU79ODaqdwVyMyus
         fhl1fGB6WcwVD3etyZJhdGQLcTzNtTt7GxGHvN0f0LQqSvKgZjpHE9SLxEFyWdKUj1
         0dd/TaEZAw8bJcNCc5x6FvlQbq8+nE/JqA0OcUTPBWfcTNIRcaqCQLuLSW5F9O7skE
         eNGbcMGSC0FmhPoXHqnhjkDmHk3LS7FR+S665Zrbvm2Mt8xZ6/onxcfl/kEFFPLHVH
         5Rph7vrVjbLPyGeS8wdGCfwFbuadsDZrEWyA90HojjDCsLMR5iubQRXJxb5Nl4XJ/w
         C7ImlQLSFqXAA==
Date:   Tue, 19 Jun 2018 08:54:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the vfs tree
Message-ID: <20180619085429.419e4ef3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D.lJffreIR4FyuYkinIIu4N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D.lJffreIR4FyuYkinIIu4N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Commit

  a6eae6a1f05a ("teach move_mount(2) to work with OPEN_TREE_CLONE")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/D.lJffreIR4FyuYkinIIu4N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoOCUACgkQAVBC80lX
0Gx2DQf+JyqVy30YHiGlc0ozHfKDCG+G2TWmh5O9vGzeh+X4gVEv/J+vbwC8D2Q8
3L4m/BxtGKSZxytPNgiHJsih+epHU5aNznu3Wd3bpHWGb5mvKdYW+qtsT1uKy906
wwpseZ+ilyhrlKrDA7EW66xtwmmCGMxpmyqsFHpatXV4Gf+zPqCFVSdxR8ofUe22
0Ybkx06yCInK+LeHpcZSMULRaM+0myCOg3k1+YfZa6iNZXg0IJc61elYuB0MU33y
PYJUnJn4yNkGjG/FvnnxjzjHCNzAZGrCCXKXWKx9J3hS+S5Saa8GXZNHRKibum1G
e1ZYWm73EvO/Th0cZbbPFdmw/OUYgA==
=ZsFb
-----END PGP SIGNATURE-----

--Sig_/D.lJffreIR4FyuYkinIIu4N--
