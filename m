Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F48ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64F720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64F720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeGWWwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:52:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57940 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbeGWWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:52:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 89FCA80386; Mon, 23 Jul 2018 23:49:18 +0200 (CEST)
Date:   Mon, 23 Jul 2018 23:49:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: linux-next-20180723: battery status funny after bootup
Message-ID: <20180723214917.GA3733@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      0 mWh
present voltage:         0 mV
pavel@amd:~$ uname -a
Linux amd 4.18.0-rc6-next-20180723+ #141 SMP Mon Jul 23 22:11:47 CEST
2018 i686 GNU/Linux

It will correct itself if I unplug/replug the AC adapter, I
believe. Gnome2 battery monitor also looks confused.


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltWTV0ACgkQMOfwapXb+vLHqACcCPP7t/ZmhjIA7zm1jnb2IlqL
aGUAnRHpeZvvAUEdi1k9xQpyNenbGXOd
=m7zw
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
