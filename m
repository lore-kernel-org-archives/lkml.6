Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85568C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398A21874
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dk6CwMop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfBKUVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:21:05 -0500
Received: from ozlabs.org ([203.11.71.1]:55171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBKUVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:21:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yxxn1L9bz9s7h;
        Tue, 12 Feb 2019 07:21:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549916461;
        bh=n0OD7Qcbs1GkU+FxJnfM+vIU5gwV0iYtiiFw1lnauy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dk6CwMopPcPT254+1cPbR2hnKiusxHY3MT07Ndmg8qudocNRBUH/BymHel1FfbRGH
         AXLpr9l7eNGBfMTj03OlkiUjx7YFdum6cOR6pmFsd3N/OjRwiZuc4aAbr89axx27+2
         ijRIt2URDY6rn7CGO8K3qNGKRpcX9NlOkoLomUJFOy544eqSrO4PGQFOJIW4p3l0LP
         9uowkpRSxtAqnh8R9GWO9A8FDm86+Ry/waKqtAtCyPgmvkDIuRvFVeRHRpEn0jUCwT
         nqDkt5IDvGYUxbdNhQeb7DgZIzC0t21MlKCl7lh+baccNi4xwyinNrU1FfN1SqTSFv
         HGEakVoT7H0sw==
Date:   Tue, 12 Feb 2019 07:21:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 081/352] f2fs: avoid build warn of fall_through
Message-ID: <20190212072100.395ec633@canb.auug.org.au>
In-Reply-To: <20190212071858.1a6a43c4@canb.auug.org.au>
References: <20190211141846.543045703@linuxfoundation.org>
        <20190211141851.175526205@linuxfoundation.org>
        <20190212071858.1a6a43c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4U.1_CSgwbzfQoB3_U9qLqy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4U.1_CSgwbzfQoB3_U9qLqy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Feb 2019 07:18:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Does the 4.20 stable tree use -Wimplicit-fallthrough?  I assume not
> (since v4.20 doesn't), so this warning does not happen in that tree.

Ditto for 4.19, 4.14 and 4.9.

--=20
Cheers,
Stephen Rothwell

--Sig_/4U.1_CSgwbzfQoB3_U9qLqy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxh2SwACgkQAVBC80lX
0GyHwwf+L/IoPipOPy0h5qlICKSUfd6JAcJiD/OX1KbDNNIUftH+N9JUFKI/tCkw
DO10OH60MpfJxAzdGOZSMs8e1vvjxSLQOar7Xuwj/RVXKh0EtSMqII5Ss6ttLkPe
DgpKR5JfJZVrBXzANwEPxDs54XdB2mNQcR0MtweTdvTnKxq4I3ZBAfoDQbaHyWBb
jz4G/YsPu02NV0SGf1UCazafD5bH1ANfCbuC3ZXBZaPaeLum3TfdGP1pMz3vxisZ
SvHug2aHwRzN+pkd9p+8AJWCPeSIJhRPEWctEetpLrUliItnIgDdnzeCdCCfMItA
YcxNPYezb2h8mBmPo9J/5G4aVqNjKw==
=HANS
-----END PGP SIGNATURE-----

--Sig_/4U.1_CSgwbzfQoB3_U9qLqy--
