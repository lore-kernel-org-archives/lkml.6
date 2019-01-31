Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8ACC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A775020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qBcetFC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfAaWKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:10:03 -0500
Received: from ozlabs.org ([203.11.71.1]:33487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfAaWKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:10:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rDtc2NfMz9sDX;
        Fri,  1 Feb 2019 09:10:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548972600;
        bh=2/ktIMrwkFcN/uRzwgPhqOKkapk2PffOcgOHIgKjkjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qBcetFC+jLYy0dqxZvWlx9rl0eD3Eso+GvwQnJl6OC259s0JCkmPmeTOuYupqvpm3
         T3Z0WifEO7FOeSNwmbIatbLVTVHqXyaYpVrD1f8jup36ADvnNcfwCNyCfaV8BbriYj
         z1tQcf7xs1WTo1rLLiW1nexMWEdh/A0uV6grkYiAU8zYzNYgkhERTRAVUiPO0vGhWa
         fwSgxODkBfI77QdmGN09IYuYrTU7OJp4dvs/uD84xEN5Zv8faYk7ExvMZBWtNJks4e
         npXjQsaQhK6OY/2iCHSSe+tcEJl0yRqX1/l57Kt7flfJnPCen7HqDs843rsENaIhk3
         +b8gI1h549tZA==
Date:   Fri, 1 Feb 2019 09:09:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ext3 tree
Message-ID: <20190201090939.08eeda02@canb.auug.org.au>
In-Reply-To: <20190131101122.GD19222@quack2.suse.cz>
References: <20190131151411.7e8b89b3@canb.auug.org.au>
        <20190131101122.GD19222@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n7C1yrq3FIFtrBcXeHrTUhh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n7C1yrq3FIFtrBcXeHrTUhh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Thu, 31 Jan 2019 11:11:22 +0100 Jan Kara <jack@suse.cz> wrote:
>
> Yeah, I've fixed that already in my tree. Thanks for letting me know and
> sorry for the breakage.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/n7C1yrq3FIFtrBcXeHrTUhh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTciQACgkQAVBC80lX
0GwB7Qf/SkXfeq8qUGxf/3aLrQswVGAa2JKtF5tHUTMRuHgb5cWPX2V5smkC5smM
qNHgTdM8YVnXHhbD73zKzRcNkWg/y5bEr0G842DKfqV0PmILO9uRBczyXtWMvcaR
ahabaHgsH//+kwR1XXfy3ehCpNoi5U64+LWbhr8yc4YpLeOXLarY8V8EC7CgAkRB
6QMC7sE9MSqry1FQtJ/BgJT4gFbQekCakI1ROEDkStkgW/eRPyVr5GCBDaZs7gGr
UXoKx2lz/UJxpZmosKKB/V/wYOurGWcTAyb2e63qfCrtwFI9iZQbUbdtfQBRLow6
7w+3qBt/58o9B6FFfGutng1x1btFSA==
=y7+E
-----END PGP SIGNATURE-----

--Sig_/n7C1yrq3FIFtrBcXeHrTUhh--
