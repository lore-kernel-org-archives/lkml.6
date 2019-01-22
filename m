Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0130C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57E220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DSCOkKYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfAVWKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:10:53 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:44722 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VOoHOjxMvwjMT1q2U52/CwXtDXOsh7LNhwr5JD2Km6s=; b=DSCOkKYthaY8TNVDQn4gYqmFV
        j02jwixr3+A88Wq/cmfMN0T1DP2nPxc0obYJ/gg77HA0Aqjo3GN27zxuCjmSZ9Ibxv+b3o9r+lpPX
        KlIGOFXID5BYdx7FaSpJCsoq0TC+LkVr01enC5MdiYY01dgOEzDgOH/dXhyZIHvTyULjQ=;
Received: from p200300ccfbd618007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbd6:1800:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gm4Fu-0003lo-Tt; Tue, 22 Jan 2019 23:10:51 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gm4Ft-00019k-QA; Tue, 22 Jan 2019 23:10:49 +0100
Date:   Tue, 22 Jan 2019 23:10:37 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] gnss: sirf: fixes and cleanup
Message-ID: <20190122231037.5fe9cea4@kemnade.info>
In-Reply-To: <20190122172255.17944-1-johan@kernel.org>
References: <20190122172255.17944-1-johan@kernel.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i1iS83zxxgKq99kX1CM7jB4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i1iS83zxxgKq99kX1CM7jB4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, 22 Jan 2019 18:22:52 +0100
Johan Hovold <johan@kernel.org> wrote:

> These patches fixes an issue where the sirf wakeup interrupt was
> prematurely enabled during probe. As Andreas suggested, we should also
> make sure that the receiver is indeed suspended at probe (to avoid
> wasting power until first open or suspend).
>=20
I will rebase my stuff on top of it.

Regards,
Andreas

--Sig_/i1iS83zxxgKq99kX1CM7jB4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxHlN8ACgkQfb1qx03i
kyQIEw/+L+4J0jHmWP+z2VyKkUq7opng3N0tM+EKeNc26H6N5WofEdE4HwM7baKu
cOg0EqhGPGeQpTtMCqpCi85LoZqcPdgzqorO4pifdPQg4JP6S0Dpq+Tr73/jSHkI
QfruICOQprK8p0Ws9qTl0JfJ2bNggvTW/3tE/fhZ/LFNv5HTmcTTD/0LEWBxIHwg
2xYgA8OlPt9hxr5tH4h7bV07mIN5nI5b7gWw3eor65bWiMczsweCrHh3NeOlt2qd
jp46OR/UAJUgMBIIs4pcvTvlWcp80pGnKkBYHoHW4J0/HZWPBvSmKh2gUzB78aKy
iFi4O7HkdX7o1vNEsv5wT2RljckZ7W/HKAy4lUBjA46/0biK539ducZisgw60Gjb
q1nBIBzbx/iPSJeiODFRM5VQDMGAxL8JgHYk/v7O/c4Gkjx8hyivqtDQIKUk6RzP
Duqx/AZSIETEWqvpjq+b+u0VUMuqUgy/C+tAC7Rwx8bXfwp0/20V184SnP1efN5n
6KygB4E9ta46M7476X7dbOblD6fNZFcfKqWNg42P6Zi0YJYXIC/podoG/ooA+hCi
Tatk3qnieqxBU82vNula7iE5hODau0Cpi9sDxtHJJHZEBko9rdBirL4S+80iinaP
wMTwBM9sbs04iHvfsXSZ2mq3OmBUGGHV7duRA+jTOlaAF2toc4Q=
=YpQX
-----END PGP SIGNATURE-----

--Sig_/i1iS83zxxgKq99kX1CM7jB4--
