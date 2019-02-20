Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078F52086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fo/c2+Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfBTBAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:00:03 -0500
Received: from ozlabs.org ([203.11.71.1]:49879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfBTBAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:00:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443zm117nKz9sDb;
        Wed, 20 Feb 2019 12:00:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550624401;
        bh=bPVxP2VNQlfUsvyWMWGnSAm4tSVI2se6rh2vTEZ4FxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fo/c2+Poc9IQtLoPI61r5xhlsANdl6QFrIyFTlNI4Yf/22gOuxg/Yu6XuAzBIjKi1
         fLsarty4p+MY4YhouvmIVOuTBfiQS6/wwBNxnFfwBh7WW6/POOOL+TUle4LONdeE7u
         abCtu60gzQ29Ga+tY7n62lzSsuoL/NMmlEopBv8L+RiAz23SUPNeIES5FSxczFVqNe
         AueNdZhr7QmD47c2rXCQZf1HMgR34JpsBM2ZIj8UXqLZU90yFJq3wEtoDqDY6JtDMI
         uh54HAnQRDWLgHU1zb+JIfxlZHlk3fzcqn+AWmyUTmIEgWV1PBiDMWRpSArbfngRnK
         ELTmjTQO7+VcA==
Date:   Wed, 20 Feb 2019 12:00:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with Linus'
 tree
Message-ID: <20190220120000.741f5c09@canb.auug.org.au>
In-Reply-To: <20190218175120.3881e6e2@canb.auug.org.au>
References: <20190218175120.3881e6e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Mn3Rb0HNC3dI2qIq1lMNUYM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mn3Rb0HNC3dI2qIq1lMNUYM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Feb 2019 17:51:20 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   fs/binfmt_script.c
>=20
> between commit:
>=20
>   cb5b020a8d38 ("Revert "exec: load_script: don't blindly truncate sheban=
g string"")
>=20
> from Linus' tree and commit:
>=20
>   76b21f3b9c4d ("exec: load_script: allow interpreter argument truncation=
")
>=20
> from the akpm-current tree.

Since Linus has applied something similar to his tree, I have dropped
that latter patch from the akpm-current tree from today.
--=20
Cheers,
Stephen Rothwell

--Sig_/Mn3Rb0HNC3dI2qIq1lMNUYM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsppAACgkQAVBC80lX
0GxCXQf+Li+sv2odKDmv4E63aGsUTZ+KEYKh7PaEfh9bQpDnwhYRgLSiJgnBJdzD
CwK27StB7/cnFGMjmfBR7tcdN1akpRpKJdf1XAdZbBwGjriDK4RGRcQva89K4pDQ
PlF/mQBWUj2xQ757CeW4GBzXSDKiIrYp5t39acs6oT5SNJUI6ox9mg8gqg/RIlkV
q48sw4wpQ8ML5eQbScRsQlqnbKoNLvHlBf0mPk4/fbPnxQmNh/xmZbqnjrJvxazF
ZAYYLy2JmClxVMiv7jmKidv7fObGbnV6bKd6TVhcJp55ypX6yuKQmUSctdbruFTd
BqGqe8GUNceKMGaAKDTXgRA4MPitIg==
=Ez+j
-----END PGP SIGNATURE-----

--Sig_/Mn3Rb0HNC3dI2qIq1lMNUYM--
