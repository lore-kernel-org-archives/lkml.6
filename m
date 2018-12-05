Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047DAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1BE20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/64CzEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1BE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeLEGbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeLEGbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:31:02 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F07206B7;
        Wed,  5 Dec 2018 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543991461;
        bh=sqeB95SFYkLA+0OreqO+mnxsGtp7l8qtxIM2eEAbTEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/64CzEqCzpzybNOOpwJAFlqFrCvUU9GuOhBNhsI8qi2acRj5RlytAOIBVW9L86/c
         73nLAThSlA2k4e234ZenXZgHpqdFyYCSvUZSjNaVLlN1vlMXdfnH7rgYVCmErAdgpz
         jD6XKQozGBMp2iJ+4IxXTd97Jt63TVddLDpqP1no=
Date:   Wed, 5 Dec 2018 08:30:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20181205063049.GG15544@mtr-leonro.mtl.com>
References: <20181205120706.294b9422@canb.auug.org.au>
 <a15a43d96bdbfc7201df2ea00e813fb4c0a323a1.camel@redhat.com>
 <20181205131050.40ab2924@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline
In-Reply-To: <20181205131050.40ab2924@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 05, 2018 at 01:10:50PM +1100, Stephen Rothwell wrote:
> Hi Doug,
>
> On Tue, 04 Dec 2018 20:33:08 -0500 Doug Ledford <dledford@redhat.com> wrote:
> >
> > FWIW this will go away in a day or two.  I merged mlx5-next into rdma
> > for-next in order to take a series that depended on it.
>
> Understood, thanks.

Thanks Stephen and Doug,

It worked so well that I forgot that our tree participates in linux-next :)
I'll add you to rare emails like this:
https://marc.info/?l=linux-rdma&m=154391249623140&w=2

Thanks

>
> --
> Cheers,
> Stephen Rothwell



--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcB3CZAAoJEORje4g2clinz1gQAImK/fzU+yTSHwVToUglIoS5
fS/jFedR86lxk01swyXlynLWlz6UXGu/nIXdkIuhJPDt9ThBGAvgM6J7WfltFSkb
+llbs3kusVHkqKExYXbJaVL6sxMKmYudUWh5X6BLbvFBlXnXAymNMSUcjKpSZbe4
lN96KMs2hb7DFOfuWvcHEdJW5a72hnTUpYJ/rTAkTN677SVH5ZREjhI92NoRQXlx
UuCVyldrIvjzN4MRFwGuPeEp31WAdcXzInX3Tblkj57tzfHQQEAKaPONMK1VPJQY
5zfoc9JujDT4M5NcjYzH+qEbzssVLEAnqgvxdUWT2fvtunSEOLJBEAOtFdMm/8Kc
EVTPRrPqgLLNoLTW8RqvASRunPrTo5lbgWtdzPdBCEpkOhf3ItkeRre2v3EBOdGE
6QBW3fE6YvMMdbiV7eMlqLbanstohJ5rVFhudo28+oQc4KyqVBC73G4Nj9GGzc6g
Z7VibCX3pCKcajfu+/3tzCUnKAFJ+FfGP3ebUWk4swLpneHLevs6iaqh3bsL7Jhy
DXY7B+6KMiCYFqcjPHpZKFEHSx/aKoF+V2Ri4e//Ecw2Tbcd7MNP8PTkYAuW/6Sz
e4UEAYHTlwwkF4p1AYqISaI3g0VUqldns9gfTDLiodG7oomfbJ94Mn77xLiksptw
M7iYUYRrsv1QylilWZK0
=RNjv
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
