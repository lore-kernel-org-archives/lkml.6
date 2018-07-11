Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40CBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC952146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ll0yiEtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC952146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390507AbeGKVsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:48:02 -0400
Received: from ozlabs.org ([203.11.71.1]:51377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbeGKVsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:48:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Qsw46ZmQz9s01;
        Thu, 12 Jul 2018 07:41:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531345301;
        bh=AM41clgj/mcPp7E1IIhvr7Eq92YXM+X6Gi0tuuVptUk=;
        h=Date:From:To:Cc:Subject:From;
        b=Ll0yiEtWOlvxCmBQJy1UvADHnBfw2W8B6mHZ+BCq7v4An9GodUmGy1V8FncwACZ0D
         UR1HCUIVDTXVyy5iYVAHIB3fHPD4S7RILRP2Rl/JYu6+nN2/X2XAZDCvZe44CRYhUi
         G5e+kAM1xwWkSCrQS22STjphT3gKLTcECh0nFeDEcvt2MYpzpLoZNrwv/F3wsd8KSs
         AxtSw7uToOAj17eXvXsqHuQULz0uXcnruMoPEDK/iZAmIl1/fzXSK45YJo9+BQvkrT
         07d7wW1K3iwd+lT3k/QoyOtIi3YZCBgHoDsTB1ArtVxC4jZC/wM/jAn10/3xlImhsE
         CTEr29+y3bMEw==
Date:   Thu, 12 Jul 2018 07:41:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20180712074140.12dd9ca7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3Yx4vHU4FIQj3EpNPIFY9yV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3Yx4vHU4FIQj3EpNPIFY9yV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Commit

  3a27f1ac04df ("ARM: dts: imx6ul: add GPIO clocks")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3Yx4vHU4FIQj3EpNPIFY9yV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltGeZQACgkQAVBC80lX
0GzTHAf/buSsQGGltidJiyWwHVD77maCRHwBvwDg5enSty0rrUT95R5cph2GxdTq
rBT8j1P2PMgEo7IIa7cAjJI91xuLxEQQV3qw01kEN+i8IOGcg7KRUIiZJTbUPVoY
ZpxjIXg5C6TN744XNkcnkaF91D7YRv1IJz6HM4f2LieD/N2rHFOyy9QHbXyHrOXg
i8PXTxrO55xfZGqQBfV3vE5nnBySi0WDcIMC6w0dNgsDeJ15L3MBtaLUJEr8UqXA
Vb6Ymj0+0XAaiqF8k+l0zLiVyu0r5RL2juQPNdI//RaZWzrC6VExOXurVyvjI5cy
7AHQDksSo2D+VaMs9SiAOjzO5Agm0Q==
=iAxX
-----END PGP SIGNATURE-----

--Sig_/3Yx4vHU4FIQj3EpNPIFY9yV--
