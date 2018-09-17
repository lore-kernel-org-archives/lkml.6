Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F664ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2547B214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKBCgAeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547B214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeIQXU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeIQXU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:20:59 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BAEA20867;
        Mon, 17 Sep 2018 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537206754;
        bh=E9EWA/FLa8G7z3rMH6D3sTdWPBIRskTBPaGaMfIeeL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKBCgAeuJA44Cjh0F0cp0S4IpGVwCG3/A0p/T/U0N6VlISehTHPwEWQ4d/5BwSCLo
         2gEpj8rSDkPerdF9810oGNyXpZcCBBHjzNe1UaL8RkZvgkuT4QkvJ4cTmydeDkAuVl
         UUUR8XRMHfUiZOGrKSQsGL+w8ChHFh+zPfEbUInU=
Date:   Mon, 17 Sep 2018 20:52:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <Haakon.Bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, yishaih@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, jackm@dev.mellanox.co.il
Subject: Re: [PATCH 1/2] IB/mlx4: Enable debug print of SMPs
Message-ID: <20180917175231.GO3661@mtr-leonro.mtl.com>
References: <20180917145309.1255642-1-Haakon.Bugge@oracle.com>
 <20180917145309.1255642-2-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20180917145309.1255642-2-Haakon.Bugge@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 04:53:08PM +0200, H=E5kon Bugge wrote:
> IB Subnet Management Packets (SMPs) were excluded from debug prints.
>
> Fixed by enabling print even on QP0 MADs.
>
> Signed-off-by: H=E5kon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/mad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbn+nfAAoJEORje4g2clinoOUP/2j8KVolKlLI4unYeMHygihA
PoDSMe2dS643eNThDopdLmE19bMtRzS1doEkXgFUDCFycR+HjWbabZuV2CLEDSnW
DjcHqMFpobAK0GoogdBAO/yttuZUAMXVeOb4GLL1T5wQudkPDKVXlgEw5cFUonn5
AZnnJc6dIwy8vsZVp37hkVYf+ig9TcfSGhmQwo/jct2qCuOEWg+QkJSxXwedJnSc
DKPgPsON0ykaPrcq8m6ufFxheIfJBlAKx+/G6TM4q/fdVGYoI+yEFaiEIoWz2z8b
UiOWDLpfZIF/mV3GbX8LpL1ycCluQP7zUIxE1tDqnzeiUY5udGLG4E+p1P1qbTbA
FwF8HLfIMuwYz+DPP8eU7w7yRvlwcbaJWVu8IX5nkf0Xo8W+JsLjEypIiLo2CHdX
mtPkfd/n7y6PhCn4blMHP+DeTJTZ1d3H2K1fgU8SiAZjnHh24bRdkhpHu5RV4w8S
pc6m1UkvuhIRSxa0cAG6ZhhOuIkm0ltGe8CQIeiHgmlOFGZWrJRo2ORhSfhhZhah
QftH9sTBSQGYLN3lYUhgNVOkQzUYeKB55eiTfybN1deCLhgCzKPt/+MUzapysrTr
nr7bnGu9Usl1RptPaQ6Lub/OUxR1LHXJK0NA5k1yi3cIUHkX2uDubuGsjy01utG6
j87iXfQBdxThunT9vXRU
=8z77
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
