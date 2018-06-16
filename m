Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFAEC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C764208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mCpskIZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C764208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeFPMan (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 08:30:43 -0400
Received: from ozlabs.org ([203.11.71.1]:52363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932741AbeFPMal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 08:30:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 417Gsn4hgvz9s4n;
        Sat, 16 Jun 2018 22:30:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529152239;
        bh=db/+ppHoKi/D6n+KVj6/VnriZ79mBgJxHjwyykhw4e8=;
        h=Date:From:To:Cc:Subject:From;
        b=mCpskIZ2tKlTd2mxl88vPa9ugJWKHL+Fe96WhyeBYKI2MelMhTxWH35TVlfAuxeSC
         1417TRzfUr87I/Vd5gv7L0U3fqvBfhUrDqMTXHharXpk/CTcMeX2/VjeYdZl061RMk
         b5HEMe/9t3LGpdNvcETutczZlHr/LRAdFtSkfOrDIh4OIKBp4CiBLWYlkY3qtuBtZ6
         5G74wJjSp01pf3qzua+OnSMxB81kvlZ/SDNQ+x5QOpIwJop8nVDmlcmnDY51GrjqS/
         QI38XbAeimET2PvTUWsBRlkRm/nVWKaA3iVLsvGuZSmFfVL9/mAWCzdzo/8TB3Wdt4
         6dLlKkdwiTK4Q==
Date:   Sat, 16 Jun 2018 22:30:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: linux-next: Signed-off-by missing for commit in the mac80211-next
 tree
Message-ID: <20180616223036.46abefcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.XiUKwHyEa9LHmLz4WHSqN/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.XiUKwHyEa9LHmLz4WHSqN/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f9444b499f68 ("ieee80211: bump IEEE80211_MAX_AMPDU_BUF to support HE")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/.XiUKwHyEa9LHmLz4WHSqN/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlslAuwACgkQAVBC80lX
0GxKcwf+MX+sT8jbymxo0849bfiGi2jN25ncj6uIkpOFATN/Sq3W+Emb5P1bjlXg
sr0uF9Ymk29SdWDgxCdEgOdKqCHBNKy+2nJ5NrCBL+Ni8t8Txy1v2LpDs14B2cWr
x1SLKuIlrpea0KPgWiCN7CRKCq0aAJt5ioc2UyPJT93lo8A6CsC+Hl28zrG69a83
RITu8QlZfO9qS1WAuovTU/Bdb6bdFz0lWhCFk1h0If514zskIjVZ178l/5AHFBwD
OLpX7O5p/WOriJ0I8RuS7vUqLS7fTcqzwE2KU98M90y3pjjq1cIvTf4AuH5U2pBR
F4KWC78e5XYmH5c9w9IIUk1z0I9JJg==
=2S2s
-----END PGP SIGNATURE-----

--Sig_/.XiUKwHyEa9LHmLz4WHSqN/--
