Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4836C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1C7217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uodJnvgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfAWFef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 00:34:35 -0500
Received: from ozlabs.org ([203.11.71.1]:60037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfAWFef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 00:34:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kv9j2FHVz9s9G;
        Wed, 23 Jan 2019 16:34:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548221673;
        bh=fxyfk1hUTw7Kh4yytmu0RRp++npk9zU1wS+vOwnEU84=;
        h=Date:From:To:Cc:Subject:From;
        b=uodJnvgW04RFTIiSN4NuGNh9CvRPvWeT7Szdxg21dALrzFBxI2DNDVX4WSbC3gVfr
         fQAxp04l41D0XvDdiH6nwv6I9vVtrU2y1mocuypABxjw4EuBjG/CO4zIpVg9uP7euU
         qJhhvmAjUnwZiF8BPpVfVbuiYLjGGKWuBifICoq0c8zJ5yGNnlr9w+pXHne78kQmCc
         1her4khWS9Y3hZfrj33WckyKjOOUSY/Y4N/HoqA0HqedgKADQ2JOzNo4gMuF/BmJE0
         YuPlIisNE/sfmsOZQbiThjcArOqw5jutlR3oeWwnuhvSFEGATw0GDcgzWZsXa9iwem
         aYCiX7r293Y9w==
Date:   Wed, 23 Jan 2019 16:34:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: Fixes tag needs some work in the scsi-fixes tree
Message-ID: <20190123163432.2f02124f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_Dq84qRTbUxqZWewXeQy8pp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_Dq84qRTbUxqZWewXeQy8pp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

In commit

  a8cf59a6692c ("scsi: communicate max segment size to the DMA mapping code=
")

Fixes tag

  Fixes: 50c2e9107f ("scsi: introduce a max_segment_size host_template para=
meters")

has these problem(s):

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/_Dq84qRTbUxqZWewXeQy8pp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxH/OgACgkQAVBC80lX
0GzOrggAhkjgBJvTiIMeACDKBBiYZO1wuMloGtOIH1niULzg+uCJEasS8qkpEZY2
gGUWr9ty5j70F4f1h5p6lBtKJdgyyGrCSDQbN6YIupl8pGtPhk0aRTBlBQpr74bl
ire0J3ehOBrMpxLM4OG7bML4heA92+9Dhr/HdszLg+I/NC0mIt86uPZNrKyMbf8s
5ON8ibKMWnNaOoBUdN4bLhFbmttzbY4S9h/Kg+VNRlWaSQEWPy733CNJu05qtSNC
sIYW0xI4XuGWFpegT7yCjGeh8qIWDkmAxhNrPuQjCe9cDFTBe/dYKeG/ibND3Lvo
JZIpFJNV4Pqa6HcLO0/axcHTcxBKyQ==
=2fae
-----END PGP SIGNATURE-----

--Sig_/_Dq84qRTbUxqZWewXeQy8pp--
