Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E23FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4872080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E8DPwYAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBEUdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:33:35 -0500
Received: from ozlabs.org ([203.11.71.1]:51525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:33:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vGW0222Vz9sDL;
        Wed,  6 Feb 2019 07:33:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549398812;
        bh=ONKyC+qEyNrvPFt9JqK/RO/K2cnfEULAHopnDOBF7AY=;
        h=Date:From:To:Cc:Subject:From;
        b=E8DPwYAVurlE9jxHcFn5pgAobFLioV28lYrCIQvrx/032Vm6sGQK+Q6RzT8+d/geK
         e9T9/rkOZAf4AvafswhigC783Mgi2mU43bu5VM/DQaZr04sYnA8u1HmJFRqd8KP5m8
         DsXGPx0mPW0B6XHCh3y6oPnK245rG/5zqb84QUSZ9IuBuhKSpDq7uUHuvyDCZWwfhZ
         6vdMNjeKZa73dK8d2Owk+8WjES1RmoNGzsuqutXieu5Ry9Q/+mt2RkkkAjVaL6p8sJ
         g9J+72jr7Ss0cvPIOBvc2sPWh5o9VoENDD+sqP9SKeyf0tSBqRrT5jiy1SnU9cybH4
         XBhvnnjNHwxfg==
Date:   Wed, 6 Feb 2019 07:33:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the userns tree
Message-ID: <20190206073330.6e266351@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.XmtDfTHFPVJPln7pP_BSQQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.XmtDfTHFPVJPln7pP_BSQQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

In commit

  a692933a8769 ("signal: Always attempt to allocate siginfo for SIGSTOP")

Fixes tag

  Fixes: 6dfc88977e42 ("[PATCH] shared thread signals")

has these problem(s):

  - Target SHA1 does not exist

--=20
Cheers,
Stephen Rothwell

--Sig_/.XmtDfTHFPVJPln7pP_BSQQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxZ8xoACgkQAVBC80lX
0GyQKAf+LCmWkYnBIlYmuKadHA0p5/oo/jWmRSneiFqT0LBp8G6MWJo/0eluWf3z
iabt+r9zKztDHsmNKfE2R+av7efxE5O8Yk2Ji577KphxFFrArnz2dKL7CxzwvwgA
XvxSLRNfas7qkYEIbXJFatzgHNKF6E5XEMQomFjT1kbZ8lZg1xf+uGvu7Xkg6ppV
/M8HSC3sHd4a4Ztr3Esb5UhSkdvHTjboWj8z9V6M20a6Na6PP7VmcSwHeoQa7Cuo
8wPU5/QYzwgZv6MuxIOt1r0O79aeSBhHv8rJZlg98HAMCXttNeHMSBzAp59m2atA
vColgmyvpz7G+DIeC95eW9hj6I79pA==
=+8Oj
-----END PGP SIGNATURE-----

--Sig_/.XmtDfTHFPVJPln7pP_BSQQ--
