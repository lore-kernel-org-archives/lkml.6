Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9788CC282CA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 00:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607482085A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 00:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BPSmgpQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfA1Act (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 19:32:49 -0500
Received: from ozlabs.org ([203.11.71.1]:46283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfA1Act (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 19:32:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43nrFB471pz9s7T;
        Mon, 28 Jan 2019 11:32:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548635566;
        bh=yyQ1dBWkV/kYuEOxdIuweNAiIjbAhs5KTZLFb0pxTSk=;
        h=Date:From:To:Cc:Subject:From;
        b=BPSmgpQ11MMAoccmsvg8re/+Yx1fBGaw+wbaHw4mHDn4ncFijvVl25BuzOq7pumeH
         2oLkT6398lBCvEUU32DfIKo5e/j5UjD7Z2gR2vTIR6F25M36zD3hGTzjvirO0pnBQt
         hdzwJL6hnxvLfjJSnoQc7JpAPpM6b7fE0d9lLqaxgMzNsH7S2noMXVNxETC2swLt9i
         l/GpyuEZELjDCOw0s4hYZcvVfHo5JRBsM6hM+ERvdti8HCd2iY7kySj6MVaN/BBmbH
         qG6ndcrQuYe9mHuOovEW7t/6gQei4DqRV2jrcr39NIjwyGHw8mIq6QQCOD/uzxXxWn
         brQDnkhsVwuBA==
Date:   Mon, 28 Jan 2019 11:32:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: no release today
Message-ID: <20190128113245.065d0d30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iLM.VuBMHTjN.g3=3ElLo6M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iLM.VuBMHTjN.g3=3ElLo6M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no linux-next release today, normal service will resume
tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/iLM.VuBMHTjN.g3=3ElLo6M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxOTa0ACgkQAVBC80lX
0GxdMwf/WNQf6UqUdruN21domcy0XqIESEzf/OmDSqqwF3fyXU8277CH5BhfCYFr
8cXAny56TbntUiRCe4hF80MEGuNrE9na/JBKUSm3YCH2XOYrSDLnSnuOFI+HvjUe
TwQ132dqNPDwTzQNgpP6JhfrvCnKJQYZo/N3yHv882YcUwO1HEWqm7oldA8r9juW
9/Ox4vV6Utr6JrO3RuofDyYUw17Un9Y0H9GhZbp/36Dd4w0/Zg1wDO+bNaO2Iycq
FyDOQlsnuM508kMM3zfdJ+JLVctRSi3IDll1uz8iYAyy6scWQ6El0Ji+Iskxki8A
qtI9W7A9X5YfAMHuF85hK+uWYhS2EA==
=3USI
-----END PGP SIGNATURE-----

--Sig_/iLM.VuBMHTjN.g3=3ElLo6M--
