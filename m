Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E10DC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69B52085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CzrmmW1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJJER3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:17:29 -0400
Received: from ozlabs.org ([203.11.71.1]:48843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeJJER3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:17:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42V8hs0Q38z9s7W;
        Wed, 10 Oct 2018 07:58:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539118719;
        bh=gYiDMATNQduu4DUfOkT53SkwPh5q9aggjirfHexmjX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CzrmmW1FwVY3209Pni7SO0WzdNDDCjmvWJXIy4KehOoKdB3npwhwWL+eymWgumDMl
         nd0zDv8A5ZmPYtkcD1bVVLKI1Rc6y3uE2PiSOKD6FL/P5HZ7AVkRuNGAkN486pg3xR
         5JaS9VVLSS8lOmIDJuM0A8vAh0kqKM0y8tdXlLoa4migR7NYGtW1x5tuS+uVftxeK9
         UVA9yWy4hMP5pQTVWPcOIy+aNmopvhw/mY0ksKFPAFxzyiD5qXGPaqeyQ9Tzd5Ky/P
         WWB2d2aN/EE6rPHLYftUEaP1u4dACGyuBIpMdLGPuqAV7bgGeLQE38KLyGg7DtCD96
         iwzYJjvwXmaKQ==
Date:   Wed, 10 Oct 2018 07:58:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181010075824.3419425d@canb.auug.org.au>
In-Reply-To: <7cb98153-14df-96e4-edee-518775f49ec5@mojatatu.com>
References: <20181009122113.05fbf12a@canb.auug.org.au>
        <7cb98153-14df-96e4-edee-518775f49ec5@mojatatu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/76W1iVra9Z0Fz2UIDIrT5Ke"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/76W1iVra9Z0Fz2UIDIrT5Ke
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

On Tue, 9 Oct 2018 06:02:25 -0400 Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> Attached should fix it. Al, please double check.

OK, I will use that resolution from today.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/76W1iVra9Z0Fz2UIDIrT5Ke
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu9FnAACgkQAVBC80lX
0GzoUwf7BNhXCSzzW7wIsvI2IlstjqhAUKL6qzdA+MzeNRamVcqByfs2ZCHxLMC+
5CYme5c3Xnoya5zWDemt76NKwRkFv9mXvxthTTZjmUc+YD7w9ET9bNwzGq7t6ws/
ks22K73fvZDmh4riP97NLvqoVpe8iZwthmC5SlidSS9oBg2zfYxIkNS70DF6ECeo
yQK++AXyPahYvsR6PsC2W1ZxoaPfhtsQmEIo2UuDlxthBOBFiToCWmovcCup7q6E
W3dpwPQIZ/a9Jk6n5hzjI1gMxlyzmTrk2DEpUcT5YTkiiNyoCpo5lzX+/w139rbI
yfBf66x1P5tEuqYGjGSFX8ptTsZpmQ==
=kJPE
-----END PGP SIGNATURE-----

--Sig_/76W1iVra9Z0Fz2UIDIrT5Ke--
