Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34354C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5A1222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gP4gmg3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfBLXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:03:15 -0500
Received: from ozlabs.org ([203.11.71.1]:57635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfBLXDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:03:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zdVR4dXZz9sDr;
        Wed, 13 Feb 2019 10:03:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550012592;
        bh=IFRIsHqfENd3vRvEd9Cdd7tqwN0Zw7K/Mh5ORmjSgMo=;
        h=Date:From:To:Cc:Subject:From;
        b=gP4gmg3SLnugBiBedAfbc5bqJc0TgUakynVUfxF0uIyMmIuRtCy6vcOEA2GNFrCCU
         91leWY3onbCHYjcFWnGTpViK0KOocLRCZxT0Ka0d2LhASoHCdHaVj42ga+kEetX3/x
         6mHyfLeF5AwNNQqhJFvMNzJRQI5UwA15r6Cb2XJjJF63VrLZzuWokT6GsYArmB6tB5
         H/odl19rXHoUxSBAtLPZDIGQrNJbaoLTGVOOMQmYtb4SL8TCsP883lNJpoqKC7W6G4
         f8brajkIuwPNsem0nYI58ujQN8onSBflqM8zNooaWqgfCCXRdaMKz10w+QjaLvodCY
         sMZa1dY29HAIA==
Date:   Wed, 13 Feb 2019 10:03:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: linux-next: Fixes tag needs some work in the pci tree
Message-ID: <20190213100309.03b5ea58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HvgDBrY/Nok0OKr._Fm/jPi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HvgDBrY/Nok0OKr._Fm/jPi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  593425276b94 ("PCI: endpoint: functions: Use memcpy_fromio()/memcpy_toio(=
)")

Fixes tag

  Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than 1 line.

--=20
Cheers,
Stephen Rothwell

--Sig_/HvgDBrY/Nok0OKr._Fm/jPi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjUK0ACgkQAVBC80lX
0GwiCAf/ZPyYTChTdSIz144wglVmqevEgejwyKpwETfuTeqb68kD6/IzkmRR9R8a
5D9HvGOiPuz4LuucUUJ1GrAefEB41YAQiLs6FTlxyjD8I27UjcBtWxM/07gLNqMC
XBSFsH+3khENk6I/Q1/aaPsZi7YM4rU1Xrk9goC2EQzjxYEwJ4RsYx519FwE4/st
YJpJPY2fd9lxX+g0bFxV6f96DQ7nQqZaDgQlmCVhtO4B4Qp3WTHvlt4QXioU12A7
FjVQcCg09/SEqiOB3rixJHV9RiFmZXUcR+ob4gY8vNRaLhhBFLeh561Ui+MyGk91
f9GuZ4SgrgFyEJ7Z+rkqSUt6t9oyQQ==
=qy5h
-----END PGP SIGNATURE-----

--Sig_/HvgDBrY/Nok0OKr._Fm/jPi--
