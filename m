Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0669C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCFD20882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeL0Wns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:43:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34638 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbeL0Wns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:43:48 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D3749806EF; Thu, 27 Dec 2018 23:43:40 +0100 (CET)
Date:   Thu, 27 Dec 2018 23:43:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid
 refconut leak
Message-ID: <20181227224344.GA14925@amd>
References: <20181215090846.28009-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20181215090846.28009-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-12-15 04:08:46, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller. Add
> i8042_is_mr_coffee() helper to avoid refconut leak.

refconut->refcount, here and in subject.
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwlVaAACgkQMOfwapXb+vJW6ACglv83GBoZjn75uotdQD6f3hnl
5BYAoJLsyWJzzj1seB/gV5vIYKvKW+gC
=fzg6
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
