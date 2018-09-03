Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D415C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2844E20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="juWEj5l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2844E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeICPhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:37:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeICPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WVtYSusTU3Oj8Xta+PpkkhAeq36FBMwJQKh082HdRzs=; b=juWEj5l352EF07NCyhlZ9Ny9Y
        zzfAoO2jLg5dfFXvsrOAhCk0ewuRZeOIS8QuujoArDeC/erjS0LFSlP/u0h2JlgmVuBx7VkJvI0Nw
        hIPqb21b2FG33YAZ5u4h1ojLK2re6o9YuOcZU/1+JTiSRgj6H+xi+rb7iBBiVEO7GoBr0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwmra-0000BO-LN; Mon, 03 Sep 2018 11:17:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 66F6911227AE; Mon,  3 Sep 2018 12:17:46 +0100 (BST)
Date:   Mon, 3 Sep 2018 12:17:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] sound: soc: fix soc-core.c kernel-doc warning
Message-ID: <20180903111746.GD10302@sirena.org.uk>
References: <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2018 at 07:38:10PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Fix kernel-doc warning:

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNGFkACgkQJNaLcl1U
h9Av+gf/bB6RZnAsbhuRQD6TCkeVzN2OkGvfzGqm8xXj9fohEWZFB0+/9uo84W39
VwqZTFRUgUU5kqujxv+TufLb0JyOXiNhzjQ+kDQLUB5s1GGRSXF1a3kdVt5iU+89
FTrdo17Q0/MexZAgH6Sq7zO4iMb0v6teUQG4KTkRR2TiJ6tm2F3hId2ww5b48oLZ
Zeu3QZQ6t2/e59R2u99wXtyyd8ARt2v9DVyQZ7BpqpvzHfa6eJ8y6hfxU/BeriVW
rvO+JYqSqG3Z0/CtNOSgcuxQEv/dR4OCnEDSTM8e1ryDp88YKzx2n3N/ZNM5e9p4
dyrQUz1b/3ncf97dr355C69LvUDNng==
=Ba7E
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
