Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C90AC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7812146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OriJ2GPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7812146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLKUiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:38:06 -0500
Received: from ozlabs.org ([203.11.71.1]:53717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKUiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:38:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DsG34MM1z9s1c;
        Wed, 12 Dec 2018 07:38:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544560683;
        bh=Vadjn1gZhJ5wwhsGeI8eeH9bkxX+XYrn3Ggko8sKm7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OriJ2GPXak6AlX0qjMRhUtn5JOmPalS4/iUh0iV1UIxHdoka91fTZ0jk2CGyczX2z
         E1q658nNpHCzTnw4JFrY/THTGhZdKGz/pyjxr4fQu9+9v3pdiQHzb9LL1bsJl10RHm
         YhLHqkAKaStOnZZfmFcj5LO1NS8eu/WYZ+s/7NeaevtmxJFTDOmYQU8/AsCwOC2G2s
         C9a3/vC8ThCqCAlp9DQkzKYzJtBVZG5UsDRBf9lNLLoyPtr8OoHV4aidAdxsFXY1AP
         pnBlsdAfJn8/jIGPlgjsVSpxHtf6WNuo6oTS1N/Qwl2M+mEH3GFEIfOte7LN7YRrXj
         9LQ+QMH1KDhEg==
Date:   Wed, 12 Dec 2018 07:38:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20181212073802.2fc8dc53@canb.auug.org.au>
In-Reply-To: <20181212072402.7b967df7@canb.auug.org.au>
References: <20181212072402.7b967df7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sYeu==ZLz16berL+QSrslWX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sYeu==ZLz16berL+QSrslWX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 12 Dec 2018 07:24:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Commit
>=20
>   ec702fa79702 ("gfs2: Dump nrpages for inodes and their glocks")
>=20
> is missing a Signed-off-by from its committer.

Now, after the rebase:

Commits

  187e4dad3f55 ("gfs2: Remove vestigial bd_ops")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/sYeu==ZLz16berL+QSrslWX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQICoACgkQAVBC80lX
0GzPsgf/fYozSjCrT89Le1QWqIyPPFRdEgYSA8Okpp6+RZE63Ig0XN/fv3dVCZW7
atVy3El+DNDbY0JvU5e8vUVnquQG+36Vh5IOexe8ynCqTzsBrWZxI9sYualakq0A
oOkl1ztYQaWBUS6UrlPui54/5LSYEJytQhCrVa2+2MQXQ6ro9MZK2LydlqaGJgIG
Mw93Ifd0zhxgQLy1CIHm4MH+pOPTDxARFWFwC5GVUD4U/R95wNbU2n4BhJc8kOI1
hggIQ9bkuNW9HZgVmvoHY+o2UWYSUGYYrO7vDAt21Vh2J2BuR6xCqTCaafw5PEZz
kzgz6ZHmhZBihmrn6ipr1xCw2VAQZw==
=if+K
-----END PGP SIGNATURE-----

--Sig_/sYeu==ZLz16berL+QSrslWX--
