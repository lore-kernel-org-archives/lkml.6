Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F1DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D020578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bBZ1aiIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfAOASt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:18:49 -0500
Received: from ozlabs.org ([203.11.71.1]:34455 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfAOASt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:18:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43drY16z7Kz9s3l;
        Tue, 15 Jan 2019 11:18:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547511526;
        bh=PS9jbClh7FHPR+SlHpYfSPwO6c71anHDOJj1ZXbfE0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bBZ1aiIydSxpjSngGFXhD6QblM/Pj16hGiy7WCZql1c5Qzqnc3Dl/YLT+DFYGmOJg
         BAuxU8ZhH35W7Yh+DS654K2zS6LF6JFJVom9dB4V4oDlkv5fTS9zdMefjyjkC364oP
         NxTcVGTofEUPKwA5ttBAWaOylq6GpeP3PV4EEA8tk8InfctWEmDrgKeUjqnHY5KeXo
         Bk2LumqOHenXJ1yh0f0jnwP8f462LFLmWhGkYhd4clXleAMSiVQdzlnXP1jPiVbUxr
         ywLCNJ0yQTx7XsXDSUeK/b0sAtCA4cqDy71AATWyZKs+MaOhDcCDkF3/2tdU4cHYg5
         5iYFsZaN5s51Q==
Date:   Tue, 15 Jan 2019 11:18:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the cisco tree with the vfs tree
Message-ID: <20190115111845.0898c0c6@canb.auug.org.au>
In-Reply-To: <20190114225412.GD18707@fifo99.com>
References: <20181002162923.13f3f8b1@canb.auug.org.au>
        <20190115093330.1cbb0625@canb.auug.org.au>
        <20190114225412.GD18707@fifo99.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6P_jAQSp9S71.+zepLBGaec"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6P_jAQSp9S71.+zepLBGaec
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, 14 Jan 2019 14:54:12 -0800 Daniel Walker <dwalker@fifo99.com> wrote:
>
> I did a rebase after your original made this. I'm not sure it's needed any
> longer. However, I was planning to rebase my tree again on top of the lat=
est
> Linus tree. How would you like to proceed ?

I still get the conflict when I merge your tree, but it is not such a
bit conflict that it warrants rebasing your tree to get rid of it.  It
will be sorted out easily enough when Linus merges your tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/6P_jAQSp9S71.+zepLBGaec
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw9JuUACgkQAVBC80lX
0Gxn9AgAm86qcJzT/hgwFBX2On6mCIkL+DqwgDVi0U9K3Pq5nrYAM38B4kKfd4y4
QEQ0diw7JA4gqfUkZkCf9d6/4Yw/tF2IvQVUmZUZX86FKfe9tYt9qwGUTxM1bgQC
b0RPGfVxzlKl2xGsW73iQTzz4ngGTXOW6z2243wbFCZ00DgKUANf113flcEP8h4C
4tYGixkmetnMJCETW5U1YkRstWZzisZnmhOJPNiS3DLjMQYIMDL+jd3gb+6zlxzc
dzGeRZhwcIw0pNf2qSjgsecDzMoegY6rftV5iwV13cFywT9AtduSPQvQFqIg+597
TYu/KiVa4HQnW+JSFJAahOO2Ihdeag==
=QFjX
-----END PGP SIGNATURE-----

--Sig_/6P_jAQSp9S71.+zepLBGaec--
