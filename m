Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EDEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3533208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hJUgB+/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3533208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeH1FSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:18:04 -0400
Received: from ozlabs.org ([203.11.71.1]:43057 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeH1FSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:18:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zrkX2rhlz9s4c;
        Tue, 28 Aug 2018 11:28:52 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535419732;
        bh=RqhuizG/rLU479U8cAVOVlq+DRJS7JRsVWhlbBTHGf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJUgB+/y4VvpnYjpc/hhM+V2sYHRC35Su0+C22BjmlHegn2tRVjNhN9xvA6OPh44j
         0/OS9c2MXqlJFs8NJvUUfUq2r/BkBWZJ1tIyDCjC1d/l1EPT94B9d4M+EPBZrUdBFf
         h0C1Tk6MGK6CoDnQCDI+lBJwdUiu7sxsykJ7X78lAs0IitEQg76jB/6vV1vMWdsCgY
         V35Mk47WNIHnKZXUMqQ+y5a0fQSDm8oi5o/K6Ih1pgTKd+31fOLQ1d5YgFCotzFD0g
         6z8Ma2QZ/YYBqk+XObjijVZ6aT7oMyVgHMIE0EoDsgRAeNXD47oJi2PMy8yQ2GFgVb
         Elum9T/PBO5nA==
Date:   Tue, 28 Aug 2018 11:28:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: new maintainer/tree for the libata tree?
Message-ID: <20180828112851.19c64e80@canb.auug.org.au>
In-Reply-To: <27ef8afc-c490-5984-5a18-1ee5ce51d556@kernel.dk>
References: <20180828071944.02b13db4@canb.auug.org.au>
        <27ef8afc-c490-5984-5a18-1ee5ce51d556@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/J=rQTNs86y9q4rzG9IVLo+m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J=rQTNs86y9q4rzG9IVLo+m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Mon, 27 Aug 2018 19:15:23 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/27/18 3:20 PM, Stephen Rothwell wrote:
> >=20
> > I noticed the maintaership change - so what shuld I sues for linux-next,
> > now?
> >=20
> > I currently have
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git#for-next =20
>=20
> I'll merge into my for-next branch on the block tree, I'm don't plan on
> doing separate trees for this, just separate branches. And everything I
> queue up for the next version will end up in my for-next branch.

So I'll just drop the libata tree from linux-next, then?
--=20
Cheers,
Stephen Rothwell

--Sig_/J=rQTNs86y9q4rzG9IVLo+m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluEpVMACgkQAVBC80lX
0GyaMgf+O2HVe4Zn+3qBjt9v+/qEAoyHhDnAnLE0KamAV7+LOKYsppMJbI78+Idy
qSJHRjOuq8bIuWF+WChYpg8JbOCFWqfVPBETpRAEkNwntIS8rwdEUwP+bZ12ILYf
LVrIHcYK2umJuOQirF5RwqbaG4sQ6v8X5PLFoTkWfSImsmLPbBmWfokSEaFYQJG4
LYHzLiDBQ8gf0cOggF0HtJWHMOQw8dQvxH49uy0Zt3AOmo/Wnq2oL2IBtQGCLAzw
B9Sv/OACc91/JX5QcO3d6rmPYvbsqS6KGQzZCRe4poqblv+X/X9Xuum9iZYDA17u
YvTl3k3uZVx10PbY7Vmrn7yhOr88iw==
=ADt1
-----END PGP SIGNATURE-----

--Sig_/J=rQTNs86y9q4rzG9IVLo+m--
