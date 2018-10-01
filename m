Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9542BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F812089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UObLbnvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F812089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeJBAwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:52:10 -0400
Received: from ozlabs.org ([203.11.71.1]:35859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBAwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:52:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42P9Pb2FPzz9s3x;
        Tue,  2 Oct 2018 04:13:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538417587;
        bh=efXrSr/Lx9UBLzE0tVE3Qx6nBfdI99oUYqyMoLD88Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UObLbnvIR1dNibv6xx11JElsp3OlUwrewrla/aifV2YFPhqbuuIGi43NTbGXzCRL+
         fBJswtVYCt4CEJiFOYy8wf2QcskyhIyV26MnyR0hQhzeqPJ6Ct8c2XB0pZxN3hbH0N
         TtoAEvZHsB+HPwzDa1ASIegfhSEOlCbdOTlqdIVX/y2t2+JkzGHyjtQTUeeRB4IZzj
         joVBunDuXLQVU7CrrIiZrJogrL+Jh6M7/lk+x+L1PpbmHR8JCrSyKVHADSu6jKL4cZ
         w+OdSE9BJPk3mWDUVv646lqCFv9A/c+ks0u1QIJA9RAFZBZPBv0H4U14L318KPYLwy
         UY2CHgtOAk4dA==
Date:   Tue, 2 Oct 2018 04:12:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     dwalker@fifo99.com
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: commits in the cisco tree
Message-ID: <20181002041231.01ce209b@canb.auug.org.au>
In-Reply-To: <20181001144257.GA13523@fifo99.com>
References: <20180930112419.6f880e46@canb.auug.org.au>
        <20181001144257.GA13523@fifo99.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jl1j3_uG+4GvEw7VEYYHbVU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jl1j3_uG+4GvEw7VEYYHbVU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, 1 Oct 2018 07:42:57 -0700 dwalker@fifo99.com wrote:
>
> Is this just an alert , or are you not merging for these reasons ?

Just an alert.

--=20
Cheers,
Stephen Rothwell

--Sig_/jl1j3_uG+4GvEw7VEYYHbVU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluyY48ACgkQAVBC80lX
0Gz4Sgf9G+j8mhtM5y9n9zCX/CujBV1hVbLHg7WcmK81EbNIRr+IHpc8YVcU9pwi
kNzhaaOHbM8gNl00/4p3HrIFqQ4mgfgUY96bUF0QfQRanU2VcA+jH3M8bJYHyg1w
sHhiVpFM6sfypjLuNfJH0Np+SlTe5e3wj6hIr8J8H+mkYCvh3GigBBBhKEFmrwQX
mFjDUJxjt1tP6pAzg1McL0rKfPcslJFngF+HqFnh2U7ySPsLuz710r4+4u2I3t2V
6P8hbtZNYVeGBMUt1IsRB8AS6xQI0FZtua9SfAIrptZy3pr163ILy8OWm6Rc7Onk
b81Oh89e24QLLJ+6y+vsbhmUSWxRwQ==
=NtTp
-----END PGP SIGNATURE-----

--Sig_/jl1j3_uG+4GvEw7VEYYHbVU--
