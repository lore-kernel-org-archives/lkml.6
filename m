Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67783C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3692C21905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gztRf//W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbeLTVLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:11:03 -0500
Received: from ozlabs.org ([203.11.71.1]:57555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbeLTVLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:11:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43LPYv56JCz9sCV;
        Fri, 21 Dec 2018 08:10:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545340259;
        bh=kjzi7t6x9jerdwJhyAxKRc8psCXaiILJFNpTp+b+m6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gztRf//W8//1qIhbsxVQNod078mqwjlLAvv8WCEG7vvt0A0nCWdoJAEpX5Kv6MCXC
         1si4Mmgu34WIScPS256CWHPnvC6kNmnL9cJguh/nkRVhK1hGVYqr7OfGzr1yXb+Gvs
         KfaEglJYlieUBcG49+PWHskY2i2uOfqbddmv3UnC8TGmEHiUXs8f9k43qAS0wmdeqm
         /ZFFIDrZ7yu26eYkC7RHDUOIZP507uNLdewTIeG5OZbPHSpnhLzQlz7OXio63Mn3Gi
         qsJGHEHj17Z7RGdoesc0j+9bMns527dq+xdcvN+7IJxbo4ZfUM98R1q05d1Nl5ht6r
         GTtu7VgPNynIw==
Date:   Fri, 21 Dec 2018 08:10:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the vfs tree
Message-ID: <20181221081058.5ada2c53@canb.auug.org.au>
In-Reply-To: <20181220210543.GX2217@ZenIV.linux.org.uk>
References: <20181221074522.0b0c986c@canb.auug.org.au>
        <20181220210543.GX2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3sCidSRlU2hsOUA+1pQsWWh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3sCidSRlU2hsOUA+1pQsWWh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Thu, 20 Dec 2018 21:05:44 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > are missing a Signed-off-by from their committers. =20
>=20
> What the...  Oh, I see - that's David adding his reviewed-by and somehow
> losing my S-o-b in process...  *grumble*

Actually, if David has actually added his Reviewed-by, then he has
committed them and so he needs to add a SOB as committer.

> Will be fixed in tomorrow push.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/3sCidSRlU2hsOUA+1pQsWWh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwcBWIACgkQAVBC80lX
0GyjGggAjM75t9jlM/lC8yXOo0KHZAYyjCTs2BaIr2sSv8vxSMSoe5vSfCEmWVvQ
dnIr5Ws5LWr6g8KCXwd5CHkHDLOfMXeV04xs3W/FBsykEFbKpqqtg4X5SxvpPNjE
ZL2zzyW/Ux+Nb69sy4a9y3tD8IHDdAeWumll9KO4psXre2iuUaqw4EjzCYKEgCbF
FHWbOe/sEQhNnOAnmLYIK5IMOAqQUN60CRYOKtCqnkNxBCo79qYSU3ugUNzvZqzE
GMnLdaSinEzSwG6J5xNgNJXwLi/6gmL2jNs9EeHRAujHCrVeAkZDB7aQCd2ObIWE
0BRTekcDe+CsZ+J8JLtmyz2ikGMnPA==
=6gY9
-----END PGP SIGNATURE-----

--Sig_/3sCidSRlU2hsOUA+1pQsWWh--
