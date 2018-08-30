Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B22082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508B22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeH3Pbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:31:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35678 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbeH3Pbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:31:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 28567804FE; Thu, 30 Aug 2018 13:30:04 +0200 (CEST)
Date:   Thu, 30 Aug 2018 13:30:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Trivial patch monkey <trivial@kernel.org>,
        Netdev list <netdev@vger.kernel.org>,
        sowmini.varadhan@oracle.com, santosh.shilimkar@oracle.com,
        ka-cheong.poon@oracle.com, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>
Subject: [PATCHv2] net/rds: RDS is not Radio Data System
Message-ID: <20180830113003.GA29794@amd>
References: <20180830102336.GA21063@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20180830102336.GA21063@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
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
+	tristate "The Reliable Datagram Sockets Protocol"
 	depends on INET
 	---help---
 	  The RDS (Reliable Datagram Sockets) protocol provides reliable,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluH1TsACgkQMOfwapXb+vIukQCgjUDECJo3b6YBEjjDtjwCd2M7
QWYAoJw4YhRHCGqAxwNiRpjE4KQOpimy
=XqE7
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
