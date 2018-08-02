Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4437C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F78621522
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XCcElSKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F78621522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbeHBQ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:29:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbeHBQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i15At+eeoNhVkCmv6AZ/LfmHZuHy0JcPoBHMHXcKpM8=; b=XCcElSKtv9oR1hKfPH8yE7SGM
        cUdfGf0DGvxsUw2g0haYLuHXvrC1NKV7X8/bGW0/UXH5182SVXjcMM7Pzz9oeJMVu1+TwTkDkzaFa
        Q1Qi4YOS62xWS7wD1Nmn3yPL2mc9iVJFAcT7GmNxl0SMvSv3VhTVp68Akihsh06KhzKPA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flEjU-00025j-7K; Thu, 02 Aug 2018 14:37:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EB1E11121BE5; Thu,  2 Aug 2018 15:37:39 +0100 (BST)
Date:   Thu, 2 Aug 2018 15:37:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20180802143739.GP9117@sirena.org.uk>
References: <20180802140630.7618b9d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7GkBbkEatsaRqBf"
Content-Disposition: inline
In-Reply-To: <20180802140630.7618b9d1@canb.auug.org.au>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7GkBbkEatsaRqBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2018 at 02:06:30PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:

I was sent a patch for this already, should be fixed tomorrow.  Thanks
for reporting.

--l7GkBbkEatsaRqBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltjFzMACgkQJNaLcl1U
h9AAnQf7Bzmvgt8cSKgmYOTF09b+mjKTJZw07x/ZMSUQAOpT8lT881G9VZ3ByJ+W
nCADSeb+E8GeIgSsB9Ri8QdJy7q0j+WEXNpTW0Pl4oXgSXncEBgAkJeL7GYuIJCV
1OxIDvUJWixA+T6OTU/OTYTcV1d92X4sIVwZeoYW1JYegzE6BMVTSNcRml5LlgjL
geMdo0olyU1AO3PcJ5BlGqP960OjNY4NUA5n22dIpk3o+vM4kFc29CKLxfKQCrUn
sZZoAn9HygQWpYZqu+tWUf+EX8DkyOr6fMHdqs71wLkvya/tmj+OsSBEi3/eBFQJ
gBRbOts/5Ub2bT75/jiQehW05/axIg==
=a3Jz
-----END PGP SIGNATURE-----

--l7GkBbkEatsaRqBf--
