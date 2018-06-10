Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bIH1JxC6HFuiUQAAmS7hNA
	; Sun, 10 Jun 2018 05:41:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8868560795; Sun, 10 Jun 2018 05:41:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7KwIPKe"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1A103601C3;
	Sun, 10 Jun 2018 05:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A103601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeFJFle (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932157AbeFJFlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:41:32 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D368F2087E;
        Sun, 10 Jun 2018 05:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528609291;
        bh=Qy49DxjZPaW4BLNlRKWbRAmhP19ScggDDMBjApXBvIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7KwIPKeWX5Gnaj+bXlO1bhbMc3P2uZlIpQ2xsAOQo0xGUMN5FXkf+b/5D6lAkwbo
         iXVa9qXoGXg2PHpMUAXvRMfmXSoo38e7l1q5Xhkok84IkdkkNbfsqM2kpns+8+19Yv
         +R9/NdSgSxkdyDcmD8TVLeD95VnJF2TY7952zZ8o=
Date: Sun, 10 Jun 2018 08:41:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Please add mlx5-next tree
Message-ID: <20180610054128.GG12407@mtr-leonro.mtl.com>
References: <20180606192500.GZ2958@mtr-leonro.mtl.com>
 <20180608074726.5b3883e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20180608074726.5b3883e2@canb.auug.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2018 at 07:47:26AM +1000, Stephen Rothwell wrote:
> Hi Leon,
>
> On Wed, 6 Jun 2018 22:25:00 +0300 Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Can you please add the branch "mlx5-next" from the following tree to the
> > linux-next integration tree?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/
> >
> > The mlx5-next branch is used to send shared pull requests to both netdev
> > and RDMA subsystems and it is worth to have linux-next coverage on it
> > before.
>
> I try hard not to add new trees during the merge window, sorry.  If I
> forget to add it after -rc1 has been released, please remind me.

Thanks Stephen, I'll do.

>
> --
> Cheers,
> Stephen Rothwell



--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbHLoIAAoJEORje4g2clinJiMP/Ak2LG4PndOAA3xyKSgfGFc4
W/0/mn1Q+Dw3J1xE2SJKSselEb6d3UWWklrUrU+1hUkNMHRj5oRayTXvUETaCxHa
hNYlmlEFy/LK0u9JlxXJX/yj3MjGOEnFsT+ElEpqzDAlt27hxNrd6br2bcnN6Epr
RI9gNCsSl0UWla7rMfr21gMDwK1BNIg1Ef7ar5K0xuSZsFq0c8pzRqcMS8cTIwA3
QrIpYynXYvx1/VTSr4XhWbT7Q4TM5h8804LVwbs3vmsg6rxzWjOvAndjGaMunA2r
A6XZEtp32qntVq6dNdQxG5PzffQv/u2gNhL4sM5TEo6lIdZoiDem8P1Wweyhu4im
58S3/rQAjonsh1B4f6I/E+1wGmXXLnS4yCv7TscwrF4zD7cBT5JfE4S7+b0s+6dI
eC5ms5DdqbkyAQuqWelC+63PtuclnQReyEsBzWJhwy8I0azA5de1iTITriCQ6i7/
CKjthpuHny/tKiPbCW0MbaWn5tSNoncvGyorDFb85kw2wNXn8Qn8enbcaAvqAEd1
cdaZtVqQOJE9ezWS6+Klh+Ywk8mHPU4PhUSE15bbetAuW165LTiLNrz4MmM/k2m0
g7NQEP+XdfYKQzB9K608fBI9N4vjsDvA761OyLzW56ef3DaskDExeDq5bgtIyity
WDkwMH/sIWvRef3k3xiy
=g+n6
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
