Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CABC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25C72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nqo7U4BL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25C72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeLJFKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:10:43 -0500
Received: from ozlabs.org ([203.11.71.1]:58517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeLJFKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:10:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CrkR66CDz9s4s;
        Mon, 10 Dec 2018 16:10:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544418639;
        bh=18SuysdI/VG9hgaz0jFWjbGEFa6xPHuRSpwhmXNldDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nqo7U4BLNYd4KeG3ta/ORa0SBnmT81WUrL+RKzSMCYizpy/5VC0Xtb24FVXPDgPu2
         1d2/oB4kQUJqtL9jF9+gh8GkTwsSFvCH3ShLj7n69sX8P/J4F4aqi55UHF7Uj2nK17
         6S6IRn5oYQGMbWHYcZsofl2Ycbo812lUTnOtTJDhB3TVKNcq4fxsjvsKrH7y9WI8Ht
         LSWrYgWn2OvJZv03jGNikh0SjmpTe52I4TqPZ9VPifQLidmTMRZMcBBOiRY5F/WvWS
         iS9juISqacuT6VnaZgIxBG3Uo0lFIHTqDUWhlKrPfTAxx+TcPFDvMpCJIudPeO7iKX
         c4ZVEs//M+v0Q==
Date:   Mon, 10 Dec 2018 16:10:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Subject: Re: linux-next: manual merge of the rcu tree with the crypto tree
Message-ID: <20181210161039.655e399f@canb.auug.org.au>
In-Reply-To: <20181210154744.3b35b1c7@canb.auug.org.au>
References: <20181210154744.3b35b1c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nfiuJUWvVjLqp4leHGpU983"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nfiuJUWvVjLqp4leHGpU983
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 10 Dec 2018 15:47:44 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I fixed it up (I used the crypto tree version of the changes) and can

This turned out to be the correct thing to do since my email to Paulo
Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> (when forwarded to <pfsmori=
go@linux.ibm.com>) bounced.   ;-)
=20

--=20
Cheers,
Stephen Rothwell

--Sig_/nfiuJUWvVjLqp4leHGpU983
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwN9U8ACgkQAVBC80lX
0Gz6/gf8Dv8XLbp9lbdRTdqoMllJOziRClhlOW2tR+A51YCMeoE/wVbxdmEBqodL
yC7HMp2ukKQDDmhBWeLy9ns/laGmp87CpzBOpYSsN9aMExe20Atw8tNZv7u1hW80
gpvBfwjn2BO0ZbTFJCzYCkSa//KOB/wvdTgBy7U1vgEo5ftLe9Kr/QMZL+Pv3xJN
q2Rzl5Nt0d5nyrjk1OXkv16fRK3ityl72oPQM492+otiLH0XvIM8hIoayzPX3vj6
U5/E/DcnRd4W5sNSg5MyKoetWji3sYQFBtEYvEUzZ0IJGYTzUsVUy5uk19GowX+G
zt6K73lyBjb/fdI0K5cyxp8cMoEXnQ==
=Jm3/
-----END PGP SIGNATURE-----

--Sig_/nfiuJUWvVjLqp4leHGpU983--
