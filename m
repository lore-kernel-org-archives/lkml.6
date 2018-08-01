Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A306F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TOsL39cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A306F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbeHAMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:44:15 -0400
Received: from ozlabs.org ([203.11.71.1]:49993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387627AbeHAMoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:44:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gVfr0K5Fz9s0R;
        Wed,  1 Aug 2018 20:59:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533121140;
        bh=UNS3YmC72zCBw8iH/6lcFP1ueW0oj0uSFywFE7GKP1Q=;
        h=Date:From:To:Cc:Subject:From;
        b=TOsL39cwJD4Hg6JU/oC0F5hyLI/NXSZuWauNiacpYpyjPlFVEdk07lyVmlUt6lVK0
         ulvhR/sj3qHhDHBSvoRCIKWigC5BBQRwbT8PhnTtqafDxJw6xDbc3Re464qJE9j3mm
         wtE4dXXG+VKo2k/2M0/1M6Hltr3WvqRMuFKrJM70NVDrTj+10TtkhQP4Qz827hxPZg
         5ArFbqxb5hOZjvpz8a9Vkvgg8+sA1O7B144iF5CYnokCAsWATz5fEqwXKIrXhzun20
         6o6U4T+iDMLTuLO4RqGRaTLrPaAgl/3+G1WfJoQG88eDDGk4u9hdNaLzlh5QK7Oj7c
         ChVb8scEdigEw==
Date:   Wed, 1 Aug 2018 20:58:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20180801205853.625673fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JpVYd+rAL6qq=jwAXf74lML"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JpVYd+rAL6qq=jwAXf74lML
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e0afb3ebfcf5 ("cifs: add compound_send_recv()")
  1bc941970813 ("cifs: make smb_send_rqst take an array of requests")
  095fe7367830 ("cifs: update init_sg, crypt_message to take an array of rq=
st")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/JpVYd+rAL6qq=jwAXf74lML
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlthkm0ACgkQAVBC80lX
0GweXAf/e2WI3wLhm+WzW9E5aWtL6y0s23Mc/d5OHd+OJbF+UhaoGpZWU7OXrcAZ
yy4hn/+qu+Nh8Q0woY0IJNHMqAGCJ7Wxsx8j2s+G/2GmSqUELhR/8OSkVcG/l+Rd
wZF/8aXnXI7RlX9PLHpPSxtQYJ7qKIY62NStuo/NCmOFwsTdY4lDd4gwege/ZKAU
jMmPQIs0Do/p9vXTWYe7/0NvFty3ZDzDwaNIgUDKPQQCNv35o5vDpbEDyz/I8pjj
z/V08tuR3oma9wyAsE0aeQgqPR3GR4qDh2dX1r1Q9V9HL4Z7BbRsSd1Zo39uYePV
dEZR6/ey17LBMyqxwmuJi+yN0QJuCA==
=8cdZ
-----END PGP SIGNATURE-----

--Sig_/JpVYd+rAL6qq=jwAXf74lML--
