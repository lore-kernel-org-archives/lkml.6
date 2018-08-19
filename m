Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83CFC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6779421473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 08:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AKJqgBZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6779421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeHSL7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 07:59:45 -0400
Received: from ozlabs.org ([203.11.71.1]:59283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbeHSL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 07:59:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41tVwT49PWz9s7X;
        Sun, 19 Aug 2018 18:48:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534668537;
        bh=roYfde9x81GqKotSASZ+R9pOzpSSXF/vXFbzQrFdoBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AKJqgBZUAhq7X+52dCu2HXyQn5N/9W8pHsgNTfT7DpmyGZ97VVKvxYpawed9l0nKl
         0zF+2v2QwGs9b3goXkS3Qoc3FNqcaaS86pkU41cGkv+7C81mXakEXcdJ3n/CYQ/Az6
         sQY8Xi5p4LDuy/73nwcX8Mc5xMkS330oL2YUWEb3vjztUf/00ggXogGFW6axxvewP3
         ASOpEA70FcSF4Jma0k7IlGqUTwJRLSK8/FbUKAwmKap/AHPqgC+rMQcjm8kl6hBG3h
         QalFvWZORPOOnuzSxM+MXLExPEriYt4c3cwqKKc4duLycFMNiDQf2/O9uPVLIC2WfW
         x8uoRNAsAUsTw==
Date:   Sun, 19 Aug 2018 18:48:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257 <youling257@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20180819184856.6b3a3f1e@canb.auug.org.au>
In-Reply-To: <737bf0b7-ccec-28e9-1675-555eafb42095@redhat.com>
References: <20180819003523.398f06e4@canb.auug.org.au>
        <737bf0b7-ccec-28e9-1675-555eafb42095@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VNbSwX3oJ/0wexAmVE05_9."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VNbSwX3oJ/0wexAmVE05_9.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, 19 Aug 2018 10:21:40 +0200 Hans de Goede <hdegoede@redhat.com> wrot=
e:
>
> On 18-08-18 16:35, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commit
> >=20
> >    cda5915d15d3 ("platform/x86: touchscreen_dmi: Add info for the Cube =
KNote i1101 tablet") =20
>=20
> For reasons which I do not know youling does not wish to
> use his real name.
>=20
> So as with the "platform/x86: touchscreen_dmi: Add
> info for the ONDA V891W Dual OS tablet" patch,
> I've given my S-o-b for this, where the intent of my
> S-o-b is to certify point c. of the certificate
> of origin, quoting from:
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
veloper-s-certificate-of-origin-1-1
>=20
> "c. The contribution was provided directly to me by some other person who=
 certified (a), (b) or (c) and I have not modified it."

Thats fine, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/VNbSwX3oJ/0wexAmVE05_9.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt5LvgACgkQAVBC80lX
0Gx5vwgAg9kD+iwpNnQIJ6w4bnYWMR6HRCbjkYDQbNjPPAmRsyrAHPHAOgcOedrA
n0+VJkMG1PfrsF4A+68hosYgR/3viZ6+AwSRQRhIeZVa9Tv7HWhFvD6EVkywQOGf
/9ri6G6upIM6VMXbEkkmXx4LGVJwc+mDCSpU+3/q47AumKLKvsaFcRb660tGpne7
to/FMqsAvfP/k/TL8+xy910VS67WfTYUm8vKkVjoSv9R0hSwFZ4YB8kOllJTp5EO
gXlJPJ3lTbwbUZSMI+vE6z3eTom1IumLsdP+AanuyOjs3p1pmXE1kh3fsaiwGRPw
7kZer0QR4hA3rnRGqIvVkoyU4gDJcw==
=dd3a
-----END PGP SIGNATURE-----

--Sig_/VNbSwX3oJ/0wexAmVE05_9.--
