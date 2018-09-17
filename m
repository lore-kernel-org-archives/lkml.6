Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325F220867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZSa0JBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325F220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIQXVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIQXVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:21:24 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7129520867;
        Mon, 17 Sep 2018 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537206779;
        bh=lJPwEQu2KAbEZSfSDIWQFvhGNnQ2kpLru3x9LXQ2pW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZSa0JBGbRxGajvq/N1pcUR+PujoDrNCQSYZPj9ctY3FXteo3V7xpxJgT2VhmVqd/
         gnEoTcBhxe9Hhm0QNHuKUaUSArnvyWBBwggCArKt8+ge6dyH0F4PO4xDENSBUf+L3c
         KoQJkbtSQ7kIgcHby/+8EzuLTB0j947pirb3SBCk=
Date:   Mon, 17 Sep 2018 20:52:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <Haakon.Bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, yishaih@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, jackm@dev.mellanox.co.il
Subject: Re: [PATCH 2/2] IB/mlx4: Add port and TID to MAD debug print
Message-ID: <20180917175255.GP3661@mtr-leonro.mtl.com>
References: <20180917145309.1255642-1-Haakon.Bugge@oracle.com>
 <20180917145309.1255642-3-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <20180917145309.1255642-3-Haakon.Bugge@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 04:53:09PM +0200, H=E5kon Bugge wrote:
> Add said information and make the debug print format consistent.
>
> Signed-off-by: H=E5kon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/mad.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbn+n3AAoJEORje4g2clin+gQQALRcu1z/F1uuFfCCkmDSg1Pc
yIiGR+1o1rdTwXmwooL+dj+Bp4gNHLx6d7iXNdDF4m7bLUaElfmO+vkfnUVRk7uK
vJQP2mjTZdrskbgXK/G9lujYE/elsI+ZyNIkyDYSSwRnOWHB8vdTOQlvNKBSiUFC
UJ78pgryTs6g7S5NYyN2JuvJpgcONjcHotqse+L5wCWufXDhi52YFIoX0M8jZoMH
jujlhx2uwGOzDcCzhRsEmpbpXShHSnpX47mq6CscPh2LXnnBgRi4YWMC+6z6WNXJ
5h1iGi2hfRgsZgWxC0kC6XzMiW0W5UEwT4tqhxQhssNwJ4sDUkEv8PJ6QN0Wsqru
wInBMPvc+U5ax5rUw5WKOk/h6Ccby0HB08Rf7BlHaYeRhbB8DCObPIkbhAkO8rrz
50h6TL+APC/2rBMpTHpSXv8m9akoPdcurlFjTWk+KW8Od7f37NHFRij9XXdpuBip
ON3m+Btkivmn/OnBgPZ5d/PCArYuWqrtVIiJVZJ3xL1K/Yf0FOm0YzQQXqb4EbeC
ZboBYyQOpIC2mltgbJAg5E6AMslmbzxPQdxiPJhhrKlTDcYJD9HefLvsG5PMQe3q
WLWTjJMcLOGN+Gd9LdVi2wpD9GfcA8bIVbSAjjZfa7LOU18yn2REqoKwJb6hZmyf
zSYeKhdy5wV28P9y8O8s
=bF+g
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
