Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D486E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BIzGfhFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D486E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLCWdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:33:51 -0500
Received: from ozlabs.org ([203.11.71.1]:41559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeLCWdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:33:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4380CK0Qt8z9s7W;
        Tue,  4 Dec 2018 09:33:49 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543876429;
        bh=1YzftDb8YIBBXHW9xcayfEn/qgmQwdTHNBa3j/r/nqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BIzGfhFOUV4Bj6j2r/Iy2LIQvohiQUs6VR7q9LpKcnpeLL9Yk/ETQ+vKYpfnAAkBY
         D1HUsch8SqFmJChxzfXLxIxWGfCb8n3g69cMhm3QjIVC2GzvTuWdi0al2Lw12MQ2R3
         MGanHSlI6OdYia8rAPEbooWpkWVAUyxO3wegRLIbyIwg8g/O8B9jAENxqX8SCK2xOa
         6MnAolL/UDJmhTkzFnKmqVLW6ZaMbR3qGzyFUAw7Ab+0KdFLEyl3e5VB13HYFDGYKz
         SqySY1hHZBtZ3SnetrcXwfPmvbFQKm3bRti59iYCBojLNJMcwZF+sXg/DJ86mGh+Dw
         THb8NO9HAbyYg==
Date:   Tue, 4 Dec 2018 09:33:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: error when trying to fetch the mediatek tree
Message-ID: <20181204093330.6872d904@canb.auug.org.au>
In-Reply-To: <CABuKBeJ9ixe=dhWBFbw-yE=25TfNhaWoHncqxJKqsjSEbMkiNQ@mail.gmail.com>
References: <20181204074058.3bd8e572@canb.auug.org.au>
        <CABuKBeJ9ixe=dhWBFbw-yE=25TfNhaWoHncqxJKqsjSEbMkiNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ao8elICt2.FPhmBJG6aAQfQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ao8elICt2.FPhmBJG6aAQfQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Mon, 3 Dec 2018 22:07:07 +0100 Matthias Brugger <matthias.bgg@gmail.com>=
 wrote:
>
> I pushed and deleted the branch yesterday, as it does not build ATM.
> I'll fix that tomorrow.

No worries.

--=20
Cheers,
Stephen Rothwell

--Sig_/ao8elICt2.FPhmBJG6aAQfQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwFrzoACgkQAVBC80lX
0Gx+uwf/bXMS5e8L69a3zP1xR8fVgy59FoCxvNzLZOpWGRTrutgkXAWL2vWSgVWx
5eq1foAHqDpxD/mhrx5QGmznvInGh7TZV+ei9poaWGZsAoeEJBwuKP4SfUJXwP8J
NkJrrbG7UGxNHLb2sbb+w8cOGsEir12B4UMySSLPuHgmhyCVizj/bRVgROdwcU19
NNyidHgEuEAqz3Uzx1UJf87GsxCRuGy/LMBuFBIqm0qKM7eIgKMS9IV/ePRPfc2S
ZfeEhdWFVsYet/jeXhnzCB5gcYohvPXmcHpGCcqOvpW/o5R04cHp7lxAyKzSm9ov
mjXwAAVRRjOJ+45ULJHMfKim0FZl1w==
=nJ4F
-----END PGP SIGNATURE-----

--Sig_/ao8elICt2.FPhmBJG6aAQfQ--
