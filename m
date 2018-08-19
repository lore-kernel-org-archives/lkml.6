Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C1C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 08:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61E321473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cL77MWMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61E321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeHSL56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 07:57:58 -0400
Received: from ozlabs.org ([203.11.71.1]:34701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeHSL55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 07:57:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41tVtQ3Rk0z9s7X;
        Sun, 19 Aug 2018 18:47:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534668430;
        bh=hVRqPPswu/upGlyUjXlxDGo+Gbqa0sw1hvoaknSsHbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cL77MWMddOka/1Uqyph8EUiW0GWiIsKun055TFyXA9EoX9Fx7xH6eDZVzsnrDVUav
         ljPofwD6fZzTz0+qnMsYF0NAhwxwgGSITsDPPjHHmK3/Z5SmLIRfpJy30TH0UW7i+/
         a9gh4pqGeHDQoajuHcz7N2J2s6oj1qKhzl2raF1d7VRIRGLUg0ORK0abYFcgSVigCM
         XQG88J7Mgx8Ek/IrD2hTcn75j0JP2nqx0uBrLv2IQeumZtL028ukcffwlPd8uMsZpO
         iVSGdynWit5vcw/IS7V0jUWUtWUv6KNU+lOEU0njplsDG5XqljbKkovKKmSweGtMQG
         HOxjHcZSXtvnw==
Date:   Sun, 19 Aug 2018 18:47:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the h8300 tree
Message-ID: <20180819184709.49aa2577@canb.auug.org.au>
In-Reply-To: <876006erfx.wl-ysato@users.sourceforge.jp>
References: <20180819003005.4a5792e8@canb.auug.org.au>
        <877ekneios.wl-ysato@users.sourceforge.jp>
        <20180819104545.183ee1bc@canb.auug.org.au>
        <876006erfx.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yfWdx/kmBZW+rGvN+8MmI0G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yfWdx/kmBZW+rGvN+8MmI0G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

On Sun, 19 Aug 2018 16:38:58 +0900 Yoshinori Sato <ysato@users.sourceforge.=
jp> wrote:
>
> Oh. Fixed.

thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/yfWdx/kmBZW+rGvN+8MmI0G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt5Lo0ACgkQAVBC80lX
0Gxn7Af/dnJpfXuj3gELtPgOKg6AQLUwztmqebt44gceYaOdPdBTdQgRH58l/fDr
vjU9enHD8I32S1/5kSn3KO6V30zCYCBDiRdFY+T9ofTsVTbD9aX+KXxeY1rAP7ph
dN3ckE4NVU+TJDSil/n3+n4BBSgbEZLfIOH/JnYVLuumwyulkeouftsnvmRKuTrL
iixQ/3PTmaGG9lfQEtWy781i2tkdJj5PDV8+hCbDtwxaPUf59pOdjoT4fMt7xSqv
SrDY1BK9m/3DkJKyoKBCpJyPh6eXLr3LBRBVvMCZVEEWXTlijB6kN/bq3R4E2HQD
LlY5texSj/UEvzQlLIjydQhtaqdH3Q==
=wo2S
-----END PGP SIGNATURE-----

--Sig_/yfWdx/kmBZW+rGvN+8MmI0G--
