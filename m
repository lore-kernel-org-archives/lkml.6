Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2006208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2006208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeH0Neq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:34:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59462 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Neq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:34:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F13EC82F8B; Mon, 27 Aug 2018 11:48:48 +0200 (CEST)
Date:   Mon, 27 Aug 2018 11:48:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gu Zhimin <kookoo.gu@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yu Chen <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86, hibernate: Extract the common code of 64/32 bit
 system
Message-ID: <20180827094848.GB31905@amd>
References: <cover.1535361949.git.kookoo.gu@intel.com>
 <541d9caef16c4a6c6e0ef160f607566c61c081c9.1535361949.git.kookoo.gu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <541d9caef16c4a6c6e0ef160f607566c61c081c9.1535361949.git.kookoo.gu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-08-27 17:42:19, Gu Zhimin wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
>=20
> Reduce the hibernation code duplication between x86-32 and x86-64
> by extracting the common code into hibernate.c.
>=20
> No functional change.
>=20
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>

Thanks a lot for doing this.

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDyQAACgkQMOfwapXb+vKvBgCgq52QQuIk9T1tILCZZp2tjASs
jWQAn0bnY9vx0LapJL8MiWh03Ci9qZpm
=CEYt
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
