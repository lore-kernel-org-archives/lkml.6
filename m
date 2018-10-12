Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E1EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24092086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="quC4RCSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24092086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeJLPq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:46:29 -0400
Received: from ozlabs.org ([203.11.71.1]:46241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeJLPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:46:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WgcZ4y5wz9s1x;
        Fri, 12 Oct 2018 19:15:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539332110;
        bh=9sABwEog//wMJeQD7xkSLMS4Pwq/2waQnu+84iLAPXc=;
        h=Date:From:To:Cc:Subject:From;
        b=quC4RCShgndWDBeXZAEbDLsLzEIRJgdnLyWS9mV8v5K1k+iQAvImSUbqBMab06CPJ
         GLeWu5ZhJnOKXzyy8cD7+fNCkvojiHMXKBiLTgbQkH/VIVrVANePS80j/JhqXHkFCy
         PN/VTNreRNkHwUnwCAIaOeCtiPkWwBgGo+Ho0oVcG/WTmBF6+zRZWWKH86CUTR0BQJ
         NHgtdJPgLv1E9CHQJ5EYIJWn3soQbx6HVEOjibi2mU9xkD22/HnsmGQ1KAO4utsZGh
         kgFOgI5Pb9Sl1YhOq8smYpt4+FM/yDHR3RLA3TgJNkFM37ju+rSon9FlvQ+vCn8ksY
         zHRn0PMBfnZdQ==
Date:   Fri, 12 Oct 2018 19:15:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: Signed-off-by missing for commit in the tty tree
Message-ID: <20181012191509.4ad4e5a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.o_89X+80RiejlPgVmd8k_+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.o_89X+80RiejlPgVmd8k_+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Commit

  c9a8e5fce009 ("tty: wipe buffer.")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/.o_89X+80RiejlPgVmd8k_+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvAWA0ACgkQAVBC80lX
0GwVUwf8CAUU2stLCwaehsQ8naRlBmV1py4fAiK19iXGo4BdXie24FgjrLBIAIHL
SBXdIJYbQ7L71/OL6rEAcanw2HvLTR6l32cIGT+GnKZ0Ewnf/smmVt9M/YSd74MX
La/t/Mc3pF/mHn+dhtJ+IpVxFfRyhwDfj4TrgK/bAnZ4tbkt7frMcHysfj3bvrcz
GMEM5ncLEiyFavw8jzNq7XoGSI7x2vawKKIsun7DurdfkFvqknhsctniHcL6S8En
mvgf45uIjaTsGzn26LPaDcT4ZFo80dA1K+X7AqZbzPeN0cKr4Rqc7l6EbE3ujQUq
AETtNgRd5z6zsc/91BXSFLvP6o+aLQ==
=6CUf
-----END PGP SIGNATURE-----

--Sig_/.o_89X+80RiejlPgVmd8k_+--
