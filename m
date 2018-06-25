Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677F4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2350725434
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RwdiftdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2350725434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeFYEXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 00:23:00 -0400
Received: from ozlabs.org ([203.11.71.1]:45627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeFYEW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 00:22:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Dbcx3qGyz9s2L;
        Mon, 25 Jun 2018 14:22:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529900577;
        bh=jqLMzgefqUW+WiX+peihzHg65PB3RM+s4mVeWVcC5fo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RwdiftdGwI27IrCeOsdp992QQjksfRxqSWFnrAmtVQAUCT8yiItzWgpUE7iyIcCMw
         R/SY+WvvbY3puDCYXGrGS21P7IJdimbchUy3K6qVlm9FkDLwO5RvK5pHroeia3E7+r
         BhSe3lGUwxX7rEthb/urDsa77pbJzmk+O0Q5551SPa4i2P26MHE54d0lfpIgKSy7g4
         6lJmMJ85cGxcaiYpMFxesHUiIovzJgvAdqtQfM223bwLWAKRdd5+q2FI0hLVJDBJyT
         2cbaQna8mgueQVqN0t0ZQFDxM+SqHZ96Q730WCf01pLv2ts7Mq9y05oaQxX7GM9W9y
         Bn0ddIGY688Mg==
Date:   Mon, 25 Jun 2018 14:22:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Stone <daniels@collabora.com>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <20180625142257.65e1c675@canb.auug.org.au>
In-Reply-To: <20180625142207.5feecdcf@canb.auug.org.au>
References: <20180625142207.5feecdcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tBRPzf0yIzxJU5gGKP9GF83"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tBRPzf0yIzxJU5gGKP9GF83
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Jun 2018 14:22:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Paul,
     ^^^^
Hmm, not Paul at all :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/tBRPzf0yIzxJU5gGKP9GF83
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlswbiEACgkQAVBC80lX
0GxqwwgAiqLVqY63VIN+uqQNb3kMcBdQDNQV//v3L8A8D0LRe7xU2HJ34zt50/dD
XqNEFSjumeW6PewxQ8S/IGb5M0xMDoMtBtTwA9nUxaG9ao1yx4mmJq9F8G9A3c9E
WS/MV5EpkEuIz+uUc5OiSRqeCvNpATCGm85OJPgJjkH2abSMLQqk4AZwpuS4eGEU
pLZYa2KMv7t27Sd0y4AMhekkLppqFzEqp4ZO/XPos7VKdsVdkaKzjo2vwKg+Oyfu
/KwyJYPXVoF8aGzcNzCXvEiOJKsLSRGwNrB5SuUZ7T/R4hI5N8piHIBW9N50YmdA
AxKFvl8/soPSpcjA137fn9emxelEqw==
=pUie
-----END PGP SIGNATURE-----

--Sig_/tBRPzf0yIzxJU5gGKP9GF83--
