Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E55C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BEF2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Wagt6AOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBTFia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:38:30 -0500
Received: from ozlabs.org ([203.11.71.1]:44501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfBTFia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:38:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4445xG5L1Hz9s3l;
        Wed, 20 Feb 2019 16:38:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550641107;
        bh=MpZODxUKNz/O+5twQR9cXpPOY0gsLWlWaW3hxqwyc7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wagt6AOmnY4i2ZFJrdLQ/tWI8jevlMX8UWrFBNKSS6UM2pgk5x8LnuqXIRwvc91Jq
         oq9AzocN66W2NIdhrPPJpRsXR4MfrU4Vl9FJGz/n/E2QpTDAgGyLSMPhzkSN3MwSZ6
         m6OKqSsfzIYsQ4Aq+oXRMrXKRB+3C1q9P4lraOAqy2n5ALtVJbwMy22hQZaUQ5lnU4
         3rGRh11JVVRv24YIbLEUWpZqYhsKg728VhaPgxd4SabJCa7m8Awva9C0TLRyMl6EM1
         qdtlmkCE0NNwlbZwekAIRDkJFWcnpJ2vJQ/2+yVa0joC630LEH2wOFjWYG/uazEkY7
         yIJTk64bJbtlw==
Date:   Wed, 20 Feb 2019 16:38:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220163820.774431ca@canb.auug.org.au>
In-Reply-To: <20190220044055.GD21884@vkoul-mobl>
References: <20190220093136.73779781@canb.auug.org.au>
        <20190220044055.GD21884@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kgVUH+B2SSgFUjFKH/vJ3cF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kgVUH+B2SSgFUjFKH/vJ3cF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

On Wed, 20 Feb 2019 10:10:55 +0530 Vinod Koul <vkoul@kernel.org> wrote:
>
> Dave would you like to drop this and me sending updated patch or
> something else..

Dave doesn't rebase/reset net-next, so we will just have to use this as
a learning experience :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/kgVUH+B2SSgFUjFKH/vJ3cF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxs58wACgkQAVBC80lX
0Gzz3wf+Kv6THMe+E7Wk4ruhrTkG62ktSsCYuDMMgiq5n64nlfb478g3Z/IPbwbg
zU1q/p5tEYK2PE4RJXwbAKKOyAm/On2bCzKgtfgooZgLN5a0ZuHGdtBprtNZbZVE
uTPISA4hkbb3v1Vw9hC4EeLMTPjcZMXhlQwcRIjyM7Ely1G+d85RWr9tLgAqnc+Q
kRVqm5WTVHFrugeu+VgKp/WG5EzDZF414cCj/NjZu5q8XBSvpTfgsSHycSV01tdh
OPMGoaPPXT3x3yCkHZa0wh5GlQwFG8MN/2KO37cOV/23eVB0FVvHaV9b9k4Xj/w7
1PghHIFfy2IAKhlL68CNjadEdY6x9A==
=pyTG
-----END PGP SIGNATURE-----

--Sig_/kgVUH+B2SSgFUjFKH/vJ3cF--
