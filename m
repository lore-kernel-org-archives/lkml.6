Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE642157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HU9DibU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE642157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHXI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:58:43 -0400
Received: from ozlabs.org ([203.11.71.1]:37257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeHXI6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:58:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41xV9d6203z9s3C;
        Fri, 24 Aug 2018 15:25:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535088342;
        bh=xlMgHAwBVrDWcJMoL8Q4YDTqcjtKORk/LupLWuDoG5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HU9DibU4HtW820znyTzUegfWuncCjkt8J8Y65rSYEBCTLBoZ6QduNjCx5C8tMJ7UZ
         fer3lXhhlGziUKnKtuUiPbLlzkjurR828+hc2X5wK+rrZbP7CJDpOmDpnY1S3f10Wm
         G/DcT19+GZ8bgscvlz7a/e8j4nbaV0MEBr7peloJye894ExjU4TwWsDNsKvcyt5keI
         NNlDJJ/ZqpTtkKGa3A7fbpGdz21PXQdNABwAT7Hx79IcfBt5ITC5y2aQ2llDbKyN1W
         5H4Of0hfD1yeqbl6B0IKT6gHPsDroGSH9y3zRbcDph+kiir8RQQ2cw8tMClOhN67ne
         zMv9hHT1EnSaA==
Date:   Fri, 24 Aug 2018 15:25:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray for 4.19
Message-ID: <20180824152541.3553a8cc@canb.auug.org.au>
In-Reply-To: <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
References: <20180813161357.GB1199@bombadil.infradead.org>
        <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eTQPGCSlA1hGnl5O.I6Lyi0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eTQPGCSlA1hGnl5O.I6Lyi0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, 21 Aug 2018 19:09:31 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> For some unfathomable reason, you have based it on the libnvdimm tree.
> I don't understand at all wjhy you did that.

That was partly my fault for giving not very good advice when the
(quite complex) merge conflict turned up in the linux-next tree.  I
will try to give better advice in the future.

--=20
Cheers,
Stephen Rothwell

--Sig_/eTQPGCSlA1hGnl5O.I6Lyi0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt/ltUACgkQAVBC80lX
0Gy/tgf/XrHWEdPxK3PFOvQTMG8aUVpqmkA+ggelCwrXVXK3QoAWV1fSUc70RzRd
GDFbkjdI31YaJij+BuTJkOQt3p/aQ/kr0QCBJTh4ZHS3qEfkHQXbJTUH1Q3jnxuH
8ze7k4z3wfcTMMZCNRwdxVht0/dRxUO1roJBqcwnxS2Hjnu+kuqXTOYG/BI9EZii
cmyK9JM9Cl1a8rK9yQ7y7xWGrh6+tWrjwX9ED/0cFPioDpDxplrx21pN7wdA2OvY
FTALotroiMCfJyNF4claRsxAH8FxW1jz9Dy+zOapuFfOQGJUVh6Btlnr9/MyL32c
DO9ImcA8kAXIq5kflYhjAt+gEchmPg==
=oNGr
-----END PGP SIGNATURE-----

--Sig_/eTQPGCSlA1hGnl5O.I6Lyi0--
