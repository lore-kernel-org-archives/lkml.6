Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B155ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9D92145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YnDkUrg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9D92145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJSNC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:02:29 -0400
Received: from ozlabs.org ([203.11.71.1]:33941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeJSNC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:02:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42btvv6H5rz9sBn;
        Fri, 19 Oct 2018 15:58:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539925083;
        bh=GTZZETFK7CYIHuYGLYe+YMbs5uIxPxi1Qy0vmpPYov8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YnDkUrg45Vu8x71avQTM94WWxp03iNq/DShMYd9dsajcFBg98qZ+0wYrkwood5pxq
         oPWBfTK6jytuWFhHtMKfLXdZGa5Yx+N3WyrpVbLDeX+3+oJ5iDQF8tZFd36q322PaE
         jvIJsHjRoLhg/lb+eZMZRWZEGhOLXZ044GqgqVgtz48nuditanwrJHAKF6jFmN3ajI
         hTOibKaJukf9gnWa8MEp1jANedXUhg6SlDzeP2TfVlQQAkkWmG3LX5i2NvPd0Gi3sY
         UB+xvubIA3BNzZgnAK5YbxJ1v+1GGfg7wv69FGjKpkd7NGCk6TLnMwUFdsxWYZDe+x
         L0vZPGMVS+Chg==
Date:   Fri, 19 Oct 2018 15:58:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
Message-ID: <20181019155802.0b75dd69@canb.auug.org.au>
In-Reply-To: <1539924843.18970.35.camel@HansenPartnership.com>
References: <20181019155034.2cf7f864@canb.auug.org.au>
        <1539924843.18970.35.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pop22MGTLMa4b4IQHSGox+R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pop22MGTLMa4b4IQHSGox+R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, 18 Oct 2018 21:54:03 -0700 James Bottomley <James.Bottomley@HansenP=
artnership.com> wrote:
>
> It's the merge commit ... it was obviously the wrong choice; I'll fix
> it.

OK, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/pop22MGTLMa4b4IQHSGox+R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvJZFoACgkQAVBC80lX
0GzdsAgAlzNWpVObA2JYzjWB0EbpGrWDhNHfzRGfWlIu6iinrIUuwj8EAimemt7K
RBjL6Y6Dgc6umD0GC5lddlYuKGEWDdRTedJCUf2c0JYWp9Cz3GaWNdR/AtcW7W5Z
jWOmlrBAjVrCGPmXgX1Yv4qdDDLAxyTaERe+B/T7SJinH8oSbIJZ5i+HZS77W8Wm
ZnvSEKbx+MgWD2kQ+UYxf3oV9zF0QUngZIM5cR7OJXi+HFDxxVTz37Qe5XT+6vww
nfnrRkU1ZYL/B7cnJ9FTZwTNfHaxS77Uu2f2OVb5tMvu8j/KSf3ptc3skLWWbZ2w
8djzBC1HxpbJiYOCDADxZG5t5MtehQ==
=/juR
-----END PGP SIGNATURE-----

--Sig_/pop22MGTLMa4b4IQHSGox+R--
