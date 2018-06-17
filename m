Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF6D208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSJZx3OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF6D208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934385AbeFQSw7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 14:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933681AbeFQSw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 14:52:57 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C25520891;
        Sun, 17 Jun 2018 18:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529261577;
        bh=Cy7qn3XGTqpobxnlVENRPFH1I7ZQo99tEXdaNRx+AS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSJZx3OJ3MbfC4CdWH9lnN0D9PieRf4UsjhxXoNgtEu7zziARrbdpoIoc3fg3pyN9
         eazumAcJGmrcIHACAhxr+pZj7bFo3GmVdwT5NAf4OnNTDA3dXUkb+TDLfdTfIjfa8s
         zU/sc7/qc9trX17hF2hZiKei8MwjX27P8f7AsQe0=
Date:   Sun, 17 Jun 2018 21:52:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Please add mlx5-next tree
Message-ID: <20180617185253.GA7393@mtr-leonro.mtl.com>
References: <20180606192500.GZ2958@mtr-leonro.mtl.com>
 <20180608074726.5b3883e2@canb.auug.org.au>
 <20180610054128.GG12407@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20180610054128.GG12407@mtr-leonro.mtl.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 10, 2018 at 08:41:28AM +0300, Leon Romanovsky wrote:
> On Fri, Jun 08, 2018 at 07:47:26AM +1000, Stephen Rothwell wrote:
> > Hi Leon,
> >
> > On Wed, 6 Jun 2018 22:25:00 +0300 Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > Can you please add the branch "mlx5-next" from the following tree to the
> > > linux-next integration tree?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/
> > >
> > > The mlx5-next branch is used to send shared pull requests to both netdev
> > > and RDMA subsystems and it is worth to have linux-next coverage on it
> > > before.
> >
> > I try hard not to add new trees during the merge window, sorry.  If I
> > forget to add it after -rc1 has been released, please remind me.
>
> Thanks Stephen, I'll do.
>

Hi Stephen,

This is reminder.

Thanks

> >
> > --
> > Cheers,
> > Stephen Rothwell
>
>



--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbJq4FAAoJEORje4g2clinc0MP/iyLkAw8x2jg3WfXW1flAH75
QY6mdmkx94bLPQq0k/wYnQQfoo3aMdxRWcABzKEGsAY8toWFLK0lkUkt8w/njzgv
grGlBNSHXQbPHCAXNuxbUSBLqZ4xpD5ainJkUZqDW/Z/4zpX4xcqjElyMCDPF10u
V2izS5DorHb0ny2+YSxrrckSldEWtFTsLBXHUXVya5Edsf6755DdirwgEyTD/92e
a1FJ+aDRh74zzgMDOJzZjUPgj5fwVnINuf4v6o0+YMJIVfkI7XDI1B4cP6XL2vT+
kYyIfd53MNqZ1m5UtPowLxWyLHNn1UnWERlGDxbzvqhPBLfVClTZQDyqSp6VbfoR
+zem0z/8bLVzPbZLDZqdYwGOfHo9K6BM99jMdYvDseyoG1pgtgXat03YjdxRWPZl
WvLeSNDGJg+Lar79HMkCAznW0SNSdRKmipELGqnVvS5vq11welLOfzvQ+s67Oy4U
lIbnwm2YgDZ8iN+GRNJHmr1Pu6A1wvsDfLsBl3sV1qe0RrVHouwBcuN6YgUOCqpg
lhg6S+HWHrKqxJ1cuW+DW0RSmfpVz/OqtNZXGhOB6o/n8Z/2FAd2rbtycqfijDr+
2VeMK6o+nplk0kEcSEef+YVQ5JPU/7b0K6CUXHYHNZH5jZ+RCyN5K85NYKuTvlb3
SNQXxmpLiItcQAI9Ca1w
=Sq+z
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
