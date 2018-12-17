Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10261C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A40214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZgES40ZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeLQVse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:48:34 -0500
Received: from ozlabs.org ([203.11.71.1]:51837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLQVse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:48:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JZXZ5KzZz9s4s;
        Tue, 18 Dec 2018 08:48:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545083311;
        bh=KGpjTk5HfHdnPV5+yKNL/krJUWZKEYMBs6/fEytM+pI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZgES40ZPpxTT6adx0h0iQh16l28jnNinic0Q5ds+tcd26FFG+0cBUUWSSC8/ZHsxk
         MTlH+x+FHGw+GQL+OInBhw6734OMZC20CKlhxw0Q3Pg4T/BSRdjqfhkBNz5TgRk/qa
         9X852PqGPNITkETsCESX6/nlxVG9VRMs6J9CcKhMu5IDLGlFMxV3J6Zi8u4WJ334Y0
         7yagfcNrMviEwLQhMUUUYn2Qb5UhADKRo4dyJK+JXxWUpxLW3m9WpcbJK4hNzXaXP/
         szDe3G/Zul3qRM6G3pMuWEmJxloAz4guT73XQIDnH9ilW2vYfMVmPH8JNfDlpyIP7V
         m3L+grn96/fjQ==
Date:   Tue, 18 Dec 2018 08:48:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: linux-next: Add secondary kgdb tree
Message-ID: <20181218084813.03360386@canb.auug.org.au>
In-Reply-To: <20181217164253.5ficzs4zr4dxbemu@holly.lan>
References: <20181217164253.5ficzs4zr4dxbemu@holly.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_FEzZclaidC3mbsmZDb2DHy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_FEzZclaidC3mbsmZDb2DHy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, 17 Dec 2018 16:42:53 +0000 Daniel Thompson <daniel.thompson@linaro.=
org> wrote:
>
> Is there any change you could add my kgdb tree to the roster for
> linux-next :
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git kgdb/fo=
r-next
>=20
> I'm currently collecting kgdb patches for v4.21 together and at the
> moment it looks like the PR for kgdb will come from my tree this dev
> cycle.
>=20
> This will leave you with two kgdb trees in this list which I assume
> isn't great for you (although Jason's tree isn't really changing much
> at the moment so I guess merging it is a nop). Anyhow I've made a diary
> note to follow this up in two kernel cycles time and decide which one
> we want to keep on the roster. Is that OK for you?

Added from today.  I called it kgdb-dt but that can be changed if you
decide to replace Jason's tree with this one.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/_FEzZclaidC3mbsmZDb2DHy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYGZ0ACgkQAVBC80lX
0GyQ1wf/e5WXJTmLg29JEbKb5tf2bS0p9k0c7cc96zuFYnQ5M3768vyyYF5CeL/h
dGautkUUwYz5O4gAaIixFhTowRjyAifvMjxXFqCB7/3VnwnhPLZpQRenCfkvdN0H
mCEeGiD9ZaWSVmKKhb8ePHhNrej/jTJR8yVhlMBwAFNoLf5Efby62ziToK3ehvJC
2qDS0bbTegwu+n0ogr2fmmqJCO6yGoZpS8JwmEmBzxz5px0K3mkGDxekzkvoZp7o
4n2GvMXd4rLMUGLLXyzhKPqoJfHChejJyCMMauVnrOal8O8N9+JVD4gPTbP9zOJR
IGp+Mqn1YeSdskgz5vsahr0VuYyF3A==
=0Y7Y
-----END PGP SIGNATURE-----

--Sig_/_FEzZclaidC3mbsmZDb2DHy--
