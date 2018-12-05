Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5105EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB1F213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p58LzHK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeLEWbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:31:24 -0500
Received: from ozlabs.org ([203.11.71.1]:41137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLEWbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:31:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439D3W0f27z9s6w;
        Thu,  6 Dec 2018 09:31:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544049081;
        bh=BS0YAF8xRnTL/HcSSSF+9ISlZ92HtPVR9l2LfcYli+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p58LzHK6bWHFYjo5Hgx0wWt3aQfd5+7YwxXTBsomJjLntOlrPhdZEsS/nShY6WZnd
         d6Bz0lLzC+nC6PHt5nk63OTjh6qYFG3/SuVuSMISKWJk2EJpXHTm6gg0GFQMJ4Me2I
         hW5jQOgkEm5Gpp0RA1U1NjgF8Yws8yn/vesx/cS9kaAC7xKymhRuTUgPnBjznwe3jL
         E6yqZcLk5ZItt6pRbDGMjS+f44jrMm0KonE7xpYwzZ8DDnrWxAzi9sbj3jmu2tMth5
         y6DcrE3YhEDZZ1Kgq94GLTD6prYC1iXLt+prfb4IUI8Thu7HAkdd5jk9vO63AjYf6k
         OLZicDZAE4X9Q==
Date:   Thu, 6 Dec 2018 09:31:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux-Next <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: Add Thunderbolt tree to linux-next
Message-ID: <20181206093106.70511c41@canb.auug.org.au>
In-Reply-To: <20181205113736.GM2469@lahna.fi.intel.com>
References: <20181205113736.GM2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oIojDWPp.l3UCbgSPrOrW/G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oIojDWPp.l3UCbgSPrOrW/G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On Wed, 5 Dec 2018 13:37:36 +0200 Mika Westerberg <mika.westerberg@linux.in=
tel.com> wrote:
>
> I maintain the Thunderbolt tree that gets merged to mainline via Greg's
> char-misc tree. I would like to get the tree included in linux-next to
> get wider coverage before it hits Greg's tree.
>=20
> Can you please include branches 'fixes' and 'next' from:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
>    =20
> in linux-next?

Added from today (well the fixes tree will be added tomorrow - but it
was empty anyway).

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

--Sig_/oIojDWPp.l3UCbgSPrOrW/G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIUaoACgkQAVBC80lX
0Gw6/wf/eeq8inNICyvIiS/ArSdmLq1BElOUfZzGDsKENAYxVzz4b4VSpPmEFS8+
067yF+QywrGndq669ByOSwBu4Z57BFZnL8W4UvRzkhjK1Pv2rF4e+SLTv2yCoLGy
gVjYgHKl+mtzgB7I6RHHDRwy2GfP66p4N6vqYMn7fjspguCKsFcqnffSZpxKpJO1
j6iyOWwmluqMnQnaPT54Yev0BXoAUBXHDE0khHpac+J+ZFWBDywV5ATqYYukGvvb
mWoPEX6wyugdR6N0FjqX/JAjBtvz6cWEh86bZOaWfTncBMoQi+Op7+juS8JbbVL7
j+o+ahyvDk5iyixrY0O2skXCi/GqYg==
=Bbp1
-----END PGP SIGNATURE-----

--Sig_/oIojDWPp.l3UCbgSPrOrW/G--
