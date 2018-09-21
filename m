Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72EECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7560321531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7560321531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbeIURKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:10:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44170 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeIURKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:10:24 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 465A980743; Fri, 21 Sep 2018 13:21:56 +0200 (CEST)
Date:   Fri, 21 Sep 2018 13:21:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/12][v4] x86-32, hibernate: Use temp_pgt as the
 temporary page table
Message-ID: <20180921112155.GA7102@amd>
References: <cover.1537448058.git.yu.c.chen@intel.com>
 <ca2e027db5bd990ffebed9086db3dac335afdf64.1537448058.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <ca2e027db5bd990ffebed9086db3dac335afdf64.1537448058.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-21 14:27:51, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
>=20
> This is to reuse the temp_pgt for both 32bit and 64bit
> system.
>=20
> No functional change.

I'd say this is functional change. "No functional change" normally
means "compiled code has not changed".

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluk1FMACgkQMOfwapXb+vIcSwCeJW25JAqEIDxy7u9CC6ZvLaGm
69oAnRbUEkklgJ4bZl85EcgUZeZYlLgh
=SwTA
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
