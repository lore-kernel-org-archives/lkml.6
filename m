Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0309BC3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABED52089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZfYt7JPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfAUWmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:42:07 -0500
Received: from ozlabs.org ([203.11.71.1]:34965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfAUWmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:42:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43k64D3CDjz9s9G;
        Tue, 22 Jan 2019 09:42:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548110524;
        bh=gGg0L8dNjmlZKLrdoXWclm8cvn1Znl+Ah/Nd+RnquUo=;
        h=Date:From:To:Cc:Subject:From;
        b=ZfYt7JPsVFPamM+PNM+SfJxcGcQaNPzI9K+EgeM9GptfvApEcGoCdwBFPXqUTsCB6
         ZHceuAp29G/Dn4P/9HJcUdn0XBQn0PXwwXx/dVU1qWsDMByCW+D4RdjQUIBVBvi76a
         1vuCBNk5sibD8IM7f0klG+0A/PERwD+nlme30mRImL2yECHYthGIfu/lMqbWbLb+Uf
         STT3dc6QwKa8OeOVRg+vE6fqz/c/xCgzPtbEa+UF9M7kPTijD6Iyl03m8L/M9g24Qt
         UAGZQLZh15r1ISPjkWQCvXLsLlLYBWh6pyaGvO8MXkaIJZS++OykaL/d3YOpxxphF7
         uqUuTt4B2pd8Q==
Date:   Tue, 22 Jan 2019 09:42:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190122094203.54570662@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9oi3s5XDxr69yehg7+C6bLZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9oi3s5XDxr69yehg7+C6bLZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

In commit

  15d90c339a7f ("pinctrl: sunxi: Correct number of IRQ banks on H6 main pin=
 controller")

Fixes tag

  Fixes: c8a830904991 ("pinctrl: sunxi: add support for the Allwinner H6

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes: tags over more than 1 line.

--=20
Cheers,
Stephen Rothwell

--Sig_/9oi3s5XDxr69yehg7+C6bLZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxGSrsACgkQAVBC80lX
0Gx1tggAiOhilq5/5UdLah4RSfv3BEye2oUOX4Em2WQRcR3K2SAFV/WqkRbc/qB4
GCDa6DAUUXs94QXDln3tV25PmHAp3WrxcN4DcThaqKCmtvHCsI2xDJ4RNKutS6JY
jfMCReXfSDX1+ehCnJtgB/C0Y1Oia2kn/OEPWnsqpAemF07ydRyVZRk65QT7dNEY
v341Y2WoZlGl1d1Rta9drHo35hqOWzW6pjh45aNx6inIZLeY+lw1kWKn3fDz4H5e
GmgvkluVQ2WaHv9If3QTVdX9xCsPMxEN+/kMELKkXqMWuVVegxkCIfZJS6v0YGV/
tMckmzxle9XFEc9drxFU/lG42ZzPEw==
=X9vq
-----END PGP SIGNATURE-----

--Sig_/9oi3s5XDxr69yehg7+C6bLZ--
