Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D78ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C105F20882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 21:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ArKGe9T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C105F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeGOWVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:21:48 -0400
Received: from ozlabs.org ([203.11.71.1]:40775 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbeGOWVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:21:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TL4Q0q3Gz9ryt;
        Mon, 16 Jul 2018 07:57:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531691847;
        bh=Jkoiph9esUj5NIoNQe8WRHEdfdiLdpsDuaWtAhO5CJc=;
        h=Date:From:To:Cc:Subject:From;
        b=ArKGe9T8A+5E7tvVpe6kzsEIH+mLeBS7YwRj4gdQZKvcHDukWzFdd46QRyVYJpKTa
         IlHlnZe4N6V8jk9UcDy9usaO9iNXIrY0NThFaTEaEMcXfXWggc19geBkRHZKM8RD99
         pkPFp4fDcaQ9Bki/dhTE7FyJysrJz2CHfMNjYdCK5nl7dFpk4BxZPlexdcY0eb6xsE
         e6mT3kkY31aFL0njh2oHIhhnxYz1y/yUrynRnN0ceaRqzv5m0YKSNpsP5v4o3MwLeK
         Gy2/11yP2HrYj0114LU2UnOVoFwlUx1k2lOzQQMKp/4axfu5zUFSf3rIAkgWxyL1pE
         hohtVnDWBCKTA==
Date:   Mon, 16 Jul 2018 07:57:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Anholt <eric@anholt.net>
Subject: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20180716075718.4e5ef491@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SNo_UrQAryXNh9eCq+Jn1SD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SNo_UrQAryXNh9eCq+Jn1SD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  b8ccf02a5014 ("ARM: dts: bcm283x: Add the PMU to the devicetree.")
  b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block")
  74d1e007915f ("hwmon: Add support for RPi voltage sensor")
  70eea1bbb556 ("firmware: raspberrypi: Register hwmon driver")
  a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SNo_UrQAryXNh9eCq+Jn1SD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltLwz4ACgkQAVBC80lX
0Gwf1Qf7B4Xn4xAMfPxVb0M+sskBPq51kCv/IbejqNZvlKN+TScnlQIvw+0sIDSf
pjEgCBc2Ep3IdJzwEyXAtd9RswCSoTwgTsWjxYNl5IcPJAy4k+0iPcVdcO30UVIA
W7GamnTTdq0Bzac8JwTKweI1RicgfjpNcsrDY+owCzv7UaBA/AoAmPzAUjOMp3lI
IaG5TXWPqHnSYm6+cHhoUf+gEazQh/bIQV7DOuiD3xYgo+6bHWsl65dqmWzjs0hw
0W4EH2RAmwkp2AjPRR3ojBmnkk1qXUx+l0vm3a10lKQNN/NzmhS0IEVOWrTsKt+X
KFpt0Fpn5WOhtYKhbDvXaXXHYnPtYg==
=sKqP
-----END PGP SIGNATURE-----

--Sig_/SNo_UrQAryXNh9eCq+Jn1SD--
