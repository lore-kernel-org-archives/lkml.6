Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76FA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iJa+Y8nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfAOWo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:44:27 -0500
Received: from ozlabs.org ([203.11.71.1]:58741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729846AbfAOWo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:44:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fQPj0bh2z9sBQ;
        Wed, 16 Jan 2019 09:44:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547592265;
        bh=vJ0+pOBJLY3PEcQjCrqAe82N/uLT+5UcE+ni7IZeu78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJa+Y8ncBnnZzslg9+dygv8nUGFZW3F+WJilO73Bd7g92waAQ6V+KnXfMZjbwtiE5
         EWuuwpBgOZRWmtJOF/qrwOM5yL5rrXoUcbUoHIiMjwNNypDu+YxcgFWvchQ3UHhoNa
         mq3y+NGiuGB5i+BBTTD7xgFL97YfVRggHUL+al/GHnmsft3igJJVx0dTGx2Xzw8vzU
         Kc/TUbD1aVbtf+/brnJFEdJfYAPbCJInFpJiWekfkNMYfu4N0zRpWsg7EmPuV6DN5P
         zaRcrjFfs7qDJS1dNZIWveJzC9MyLBp4OXAhyS0a8o+4lrkRSrPaP+MQ2CkbO6/Hdg
         vCYUfNfIaE+nw==
Date:   Wed, 16 Jan 2019 09:44:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tags need some work in the pm tree
Message-ID: <20190116094424.143ddd3d@canb.auug.org.au>
In-Reply-To: <0f64417d-be5e-2939-7fc5-ee5ba26c64a6@kernel.org>
References: <20190116075540.78cff44e@canb.auug.org.au>
        <0f64417d-be5e-2939-7fc5-ee5ba26c64a6@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/73wTgXXxonDkNshJsIwyUh_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/73wTgXXxonDkNshJsIwyUh_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sinan,

On Tue, 15 Jan 2019 16:10:07 -0500 Sinan Kaya <okaya@kernel.org> wrote:
>
> Interesting, can you add this to the checkpatch.pl script so that it does=
n't
> happen again?

Probably a good idea ... (cc'ing Paul G :-))

--=20
Cheers,
Stephen Rothwell

--Sig_/73wTgXXxonDkNshJsIwyUh_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+YkgACgkQAVBC80lX
0GyzoAgAo63fV1JtvbQExAhCsgmVoSWGjth/zWcwK1EhL8ivzQQWUk+pHPbbNbCG
PY9aYyBvUiwZcxnr0+NZ7XXchreK4wXfHFZ2shKH/IAgLwaqIbmmd1C2RGLGuUvd
xR5m+8cGhZiyhV7TpbNHTdVsKsZNEhZ7HzXTg+URF2e3nAGo48GpjJVZticgZJQV
e0nBIBsBQrltEvvmGnXACC/m+p7Xz4htTC9inrGIAzpyAnfZkDm4TEbGeA4GvVMh
kTM4GOXYVbCR3+EdqaY2rCTOCUoc8hbhGuwSfyQolxTUZQTEKjka9WthEoElICfx
//hcavKlyOH+Kja4Jbf2bBFTRkKkxQ==
=6lMM
-----END PGP SIGNATURE-----

--Sig_/73wTgXXxonDkNshJsIwyUh_--
