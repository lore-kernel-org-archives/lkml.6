Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89280C46475
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3130F2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JKk3HhZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3130F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeJ1J6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 05:58:38 -0400
Received: from ozlabs.org ([203.11.71.1]:46065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbeJ1J6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 05:58:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jKY847HZz9sD2;
        Sun, 28 Oct 2018 12:15:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540689340;
        bh=OKsqYyxdrhgCq/T/zwu0EWEYpiLvrGRa5RW+0iqejok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JKk3HhZuegmKAc+wc9iy2AtznPk8uDkMsftMprqDi25HQmN3UW29lfiimCqZF4WXX
         PxROoS/ZjHBD6Qhy0/6jW+0+QzkDEjLJdTGQwBbL7YSDQWvoAXfpdechcoO+eqS6fk
         2/Gx6Nb+/7fEMG11zODFaI0JkuPkHAfBU1M9C8T/1Vc2n4E3hrmPhw9Pq4ASLoU9UU
         DErFqawjK5fjceevEcqYMXtqVqvFpJaeb3TQmbCP6ZBeGhTW0qpFZxokDY/9e5NUEM
         4hy4f/PXhSNzM5I1nLkeOpyGdGd/Uhbe3P6xBwoI2YpjzrIAJpGm8Eij3BQqcTkDxi
         1jULx45rUDpgg==
Date:   Sun, 28 Oct 2018 12:15:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: moving to group maintainership model
Message-ID: <20181028121202.3efcbee5@canb.auug.org.au>
In-Reply-To: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X2xECjmDpLIudRSbuvfwmpn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X2xECjmDpLIudRSbuvfwmpn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Sat, 27 Oct 2018 14:19:02 +0200 (CEST) Jiri Kosina <jikos@kernel.org> wr=
ote:
>
> Stephen, could you please update the hid.git URL for linux-next as below?=
=20
> Thanks.

Done, also added Benjamin as a contact.

[for Benjamin's benefit ...]

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

--Sig_/X2xECjmDpLIudRSbuvfwmpn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvVDbUACgkQAVBC80lX
0Gxxbwf/a+o3mYCPDkfx6dbJfVhQ6J7k6OnbkwoTDAbdxb9RsrPFkBhSx7n7bxMG
jrkBK9wZW89Lh2OPFhTna/kE3PDtBu/w34b3ilR93dt6F/T2dGR61kSQl1VW7cCx
PiHg7LqUgkiEC2yj3jq2+gRiA361vtQ7Amp7/yxGSnn4UJitK3olqphAt0uavw3E
IObQiDQhHDXdA5jWqTeOquhrG/rIGld6rT/Uoq8rgi+JJUdzq/WoBb734JIpaH5U
d9Srl6SYZA219UQUvospAkfxck9/EJVkRClmyDcDrmlopu1ieRWZ342l+O03ATh7
5puqTsi0UDTti67BnhhyUeFlxYRYug==
=AhaS
-----END PGP SIGNATURE-----

--Sig_/X2xECjmDpLIudRSbuvfwmpn--
