Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82BCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7352F2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7352F2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeH3OZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:25:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34189 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeH3OZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:25:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 919CD804D8; Thu, 30 Aug 2018 12:23:37 +0200 (CEST)
Date:   Thu, 30 Aug 2018 12:23:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Trivial patch monkey <trivial@kernel.org>,
        Netdev list <netdev@vger.kernel.org>,
        sowmini.varadhan@oracle.com, santosh.shilimkar@oracle.com,
        ka-cheong.poon@oracle.com, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] net/rds: RDS is not Radio Data System
Message-ID: <20180830102336.GA21063@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Getting prompt "The RDS Protocol" (RDS) is not too helpful, and it is
easily confused with Radio Data System (which we may want to support
in kernel, too).

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 41f7556..2738f14 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -1,6 +1,6 @@
=20
 config RDS
-	tristate "The RDS Protocol"
+	tristate "The (Reliable Datagram Sockets) Protocol"
 	depends on INET
 	---help---
 	  The RDS (Reliable Datagram Sockets) protocol provides reliable,

 =20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluHxagACgkQMOfwapXb+vL2yACfXFyjZxxln0r5tCnvvcdY8urv
EgAAni2dtY7PQXQJ6K+rIx1iApiRt/WD
=BxFu
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
