Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96736ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545892084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545892084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGRLhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:37:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47299 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeGRLhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:37:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AE42C80578; Wed, 18 Jul 2018 13:00:20 +0200 (CEST)
Date:   Wed, 18 Jul 2018 13:00:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     hannes@cmpxchg.org, cl@linux.com, mingo@redhat.com, jweiner@fb.com,
        efault@gmx.de, peterz@infradead.org, shakeelb@google.com,
        surenb@google.com, tj@kernel.org, vinmenon@codeaurora.org,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        kernel list <linux-kernel@vger.kernel.org>
Subject: PSI? What is PSI?
Message-ID: <20180718110016.GA20917@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, after reading Kconfig help I get it, but as we have
/proc/pressure, should we perhaps have CONFIG_PRESSURE and
Documentation/.../pressure.txt?

We already have too many TLAs.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltPHcAACgkQMOfwapXb+vIACACcC8lC9akQMcTuelp/v7xf6RJd
f3oAn0gNrLmgrEnhoziP+vABmHTRZinn
=Nvzw
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
