Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1228C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C8C21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AKDvVH75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8C21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeI1EFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:05:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeI1EFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bFm9Zu4UXT+pl8MB1yOkSpuZ6c0hDz5PG6XcmdwuBJg=; b=AKDvVH75IaMUpsLUJHhdmR+Ob
        2xFX8+EmDkgrSn91Gfk6yVkX5c251UgDuC6Y8mkWdRBh1XgilNNMcZeYHfc5LFY6cvGaIifzW9ERE
        r3iHGBku9ymHJGMktkhIyNl40gHBoXHIxN7I5IeAEnhy2Z40fLw05w3sOKmChjor6+LQM=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5e5N-0007PQ-Mq; Thu, 27 Sep 2018 21:44:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 23626440078; Thu, 27 Sep 2018 22:44:37 +0100 (BST)
Date:   Thu, 27 Sep 2018 22:44:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 31/64] spi: fix IDR collision on systems with both
 fixed and dynamic SPI bus numbers
Message-ID: <20180927214436.GA20825@sirena.org.uk>
References: <CADVatmMTY0NHJFUOeScJGv=Jb=gCQwgrbeTmW6vkedw8rj1ELw@mail.gmail.com>
 <5055ed3a-2f29-505d-ccb3-0e0a35d8fb73@compulab.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="utUizcr4eQAkV3Ky"
Content-Disposition: inline
In-Reply-To: <5055ed3a-2f29-505d-ccb3-0e0a35d8fb73@compulab.co.il>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utUizcr4eQAkV3Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 27, 2018 at 03:04:20PM +0300, Kirill Kapranov wrote:

> Sudip is absolutely right, the patch he mentioned,
>  04b2d03a7565 ("spi: Fix double IDR allocation with DT aliases"),
> MUST be added too with the mine.

> Sudip, thank you for reminding.

Yes, they're both required.

--utUizcr4eQAkV3Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlutT0QACgkQJNaLcl1U
h9BPdgf/X8Uuyghe2Uzl90M8+EHDyyN305M7lv/1bKBHjRykMRV5nU57VMvUHe/V
/fNRWhDeH9QJuGOUcyZpv6MBp3V25mtBkFoeB5GA9W/O8B2yFHJVLqsaMT/pQ+Fp
zy2goMbCM00eS/ZUSDyoruBQYwGOEO5S4TXkAIFnUpvmUli2B1VUcR6Rku24EDkU
nQUzKRQ7jqip433JIdGbqER5Mukk1JzTXSL9f64ttoZG/zj4o/CmZ7rkPnWSsXkz
jXZ4PbySbhJ2M5IWQO8/mFm0c9Vb28UWysZoXC5uw7snEs/7dfAq4jS5w7H3qV0O
+MOUBo6hnZ5Ke9tjZprHVVOtfTCw/g==
=p9l2
-----END PGP SIGNATURE-----

--utUizcr4eQAkV3Ky--
