Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E31DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132402075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fC4Gt25I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132402075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeKTPnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:43:03 -0500
Received: from ozlabs.org ([203.11.71.1]:43569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeKTPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:43:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42zYnc03j2z9s4s;
        Tue, 20 Nov 2018 16:15:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542690948;
        bh=QxLkMQbvhflfLrIZw4eY1Kz5jKaCI7eYw0ylTZeOOYA=;
        h=Date:From:To:Cc:Subject:From;
        b=fC4Gt25IpsFGfGdCbfkXonDueDKcPQcLgTvrhZnNDo6aFYofLqJb87ON1lnVDVjCU
         q15fK/m/4bRzGeb7fQFBbBbM8oA2LUGnQyDXDk3vuYt4Z6OBTMZOFiopQWHbuiaTJn
         BLvPcjsSqsqLMy+EzL64IbvU7/GGvIhCi3F1iGIylwTp+7EEvUtKvvCkopiGYA9F4E
         3TKgswYyzWrcjpVTiiNWmTUUjeEYMh+2p7rdAq772GQLNNBK3ZOPeX/r1x44QvM09X
         iwfq65bGlx7WBKLkpSxrva2T6VVRkC13s4cnvA+dFkaLs7DvpMwCiwVYRj41WUqk8Q
         Q+8PAJ/MZZgsQ==
Date:   Tue, 20 Nov 2018 16:15:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20181120161546.1098b346@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vsxwVg0T9.VYGn8MnutzUEE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vsxwVg0T9.VYGn8MnutzUEE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  69fec325a643 ("Revert "sctp: remove sctp_transport_pmtu_check"")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/vsxwVg0T9.VYGn8MnutzUEE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvzmIIACgkQAVBC80lX
0GyEzggAiFFfFHS/Bf54O6F9vw3vVvg8FXsO06bPcbyho6gAcKRVOp26qnNEJZah
glO+0ZpPgkDYx8G3Icw2Scz3FVY3j38l03GcvVXfC7X0Q9TsagYEBYjQOt1W4xkw
9ZEfbUj6ugaCLvGtUyA3fQoIi6EQlEa1MOctXEdCCekH9unV6FCWKi51y0asTKAR
6AGxMvA9/Zn5AUhTmzUmhj/BBB7AkyExQRTjaw2uqFQd0J9r9/BMoknF0/bZEqFM
PWl4DpP/Vg9TdOotwINBxnZlE29K9LPLXYcxg9a8tqfn2LsOXrhiAlUHXTmqSzrF
Oj6pz1xeYhebvBYxCtZ9NBEZsQOBdA==
=4G96
-----END PGP SIGNATURE-----

--Sig_/vsxwVg0T9.VYGn8MnutzUEE--
