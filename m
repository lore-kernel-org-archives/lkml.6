Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB5C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD0221763
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Mhx343FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD0221763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeHNMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:43:12 -0400
Received: from ozlabs.org ([203.11.71.1]:42607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbeHNMnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:43:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qSfy5ZpLz9s78;
        Tue, 14 Aug 2018 19:56:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534240603;
        bh=jChyaC+/OQildoD9InsXOOh4ntUhfJRiDTzUYX1pVlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mhx343FJ41ZSYaGxknp5vBJZ8qJQocz6bP6aHb+q0d1X2lKstr6PNl1LINjJBLOKr
         +K4Fole8EXpSGenjLdLC0b6LIsFIZ2ZHDfKVCuAyJaWLr8QlMR7CEHlAtlLW7a/cjx
         c37siD2i57geHEP2d3vQb7SWdL+Iw2MWYjk2xkC9e8GfI/annVDP4osS8fCj88T4Gp
         P51yTdMTnolYoZ5oD8BKSIzsDCfiB7yW09ZpNyo6LgdYLrZMjFfEPQ3MNzJV0Tmyz3
         48U6/L/0cvpfCx9UUA7YsPIJ3IVQst1RHUV29lq8ctgT9EFzVyo5nk5HOl9a5tBPYI
         czr9550I6XKXg==
Date:   Tue, 14 Aug 2018 19:56:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 4.19
Message-ID: <20180814195641.56545ab0@canb.auug.org.au>
In-Reply-To: <20180814091438.GD24025@twin.jikos.cz>
References: <cover.1534161966.git.dsterba@suse.com>
        <20180814185005.7a05e8ec@canb.auug.org.au>
        <20180814091438.GD24025@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1E6v8DvpSl8vz1BwP4BbkNH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1E6v8DvpSl8vz1BwP4BbkNH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 14 Aug 2018 11:14:38 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> Done, sorry. Only the pull branch is there now.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/1E6v8DvpSl8vz1BwP4BbkNH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltyp1kACgkQAVBC80lX
0GxAdQf/eftZso3l38C7Z+C6lcXgrF0BNrVNX4AO5QVlaAgZ+Alf0Cxgu9PvZ2rt
ilXWRZ+9BaFBGsXqQzQL2CwJHhjG3a4Z79+xg8/+YV3sW+HIxd7utG/avTNjLM2W
J9RcceEmKDcqqaDSEFnnDXvWbjRmJFcV2BhaEgVlGcmTcAqYPzX6V3GnqeOdPbGN
VlO3k2gBz2W0W238c73EkFGveEz3mZoc6/c3lNOnfkXV7irU9oQGX5MJsRYlLL7M
HOvdyGkCl9gCyS2KhTD7Qeyig++4zjXDX6sXMVsdq+Y4dZCHqQc8FdTG1mbfEYp8
SKqMHBtVBzxV91v0qB0JJspvPi70OQ==
=APZj
-----END PGP SIGNATURE-----

--Sig_/1E6v8DvpSl8vz1BwP4BbkNH--
