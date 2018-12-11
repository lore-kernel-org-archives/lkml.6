Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D3C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE7B2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nM+RFnw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE7B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLKWxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:53:44 -0500
Received: from ozlabs.org ([203.11.71.1]:48113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeLKWxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:53:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DwGX6RKYz9s3Z;
        Wed, 12 Dec 2018 09:53:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544568820;
        bh=c6y859mSGyqs9PWN+JJoALJh4ZdfB4YU2AwKxJ6fpck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nM+RFnw6mvaptcYLyao2xcl6b/Nqdv8EH1uX14INVAJOBF89mll7j4KlJ8DFIHoLH
         w0OFgTlB2xjI10i6bZVvq9F4FoFySQhoZS1rSZWSOYr6q+gecvDQDDAEIDCelILbko
         QPrWVALkeMG5iED7/2AvrgRwHpOzycmvVVvova75G4EQy4Z2vnEC52IfVLAjhv5ceG
         vIA/7ztD1uMLgzZLs/O4IexZsxbE5EBAX5qNg3XmeVc/XsTeIkNzQ0bWeudflKQuuN
         HD88RiE0QyFlqcpg/km9NBUz4qE0f7BZA+vk8HJ4o2CBR9O0ERuLnISRE+tERJIn7O
         LBqIg9SLASO2Q==
Date:   Wed, 12 Dec 2018 09:53:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181212095340.35bcb8c6@canb.auug.org.au>
In-Reply-To: <20181212093632.774c0603@canb.auug.org.au>
References: <20181211182627.42b79e40@canb.auug.org.au>
        <20181211173851.GA29028@roeck-us.net>
        <20181211180437.GA28010@flashbox>
        <20181212093632.774c0603@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vy/Wia_MQaeOTG3UUXw_Z6R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vy/Wia_MQaeOTG3UUXw_Z6R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Wed, 12 Dec 2018 09:36:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I have added that patch after the v4l-dvb tree for today.  (and cc'd
> the v4l-dvb maintainer - who is also the author of the patch in the
> Fixes tag ...)

Sorry, I just realised that your original patch was sent to Mauro.

--=20
Cheers,
Stephen Rothwell

--Sig_/vy/Wia_MQaeOTG3UUXw_Z6R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQP/QACgkQAVBC80lX
0Gypmgf/TY4VzFliygtN1u5DyUkxm8LGaYpUbPX63myw8gW/BICjzlEejK1SFHQ6
0mk6DicvbWnAPd+Odh+6Trs/P6X65cCIxHbTp+vuIP2If2SZSbFfgzSNNqsrUT1s
XpKQS1PjTZ9DGQazudbjQWvks2LTfpPfEYBJqXbtKfCXAujK5M2u71g6BwEM2tSW
sbfeEqd0NfMKLEh9djICUFcEKYTbuRmj33FCpbbefZE9exzNvOe0snChYRuhG3IJ
7R7POYqu1usKqm0VVP/xmiTrV03X6ElA+Nio3nxSToVTeOXH+mEui1AHSO5cpWdj
OLsR0/LNfGgrxYk3bwV3s3PB5v2q2g==
=EmKz
-----END PGP SIGNATURE-----

--Sig_/vy/Wia_MQaeOTG3UUXw_Z6R--
