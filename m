Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAACC46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C5217B4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="toJzN3Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7C5217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeHCXcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbeHCXcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:32:19 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19366217AA;
        Fri,  3 Aug 2018 21:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533332056;
        bh=mA2dxVELFUtiPrfSR8z+vwDu8PClY5J9WOe9FMPvAw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=toJzN3LwiDTIBdV0NrNeijQ6QaTf6kAK54aOkLEhp6w/UUlgW5Y7pCQJCqsyOTJuL
         5GIxaowsYi3GrPpBdCbnkh3DFebqKS83hancdMwE3KHU1knOSzNvMv/XLQlwanVvZb
         dJPPSgLpVxG0JuGZUk63RE56qhJaHTcj6TeIkdFk=
Date:   Fri, 3 Aug 2018 22:34:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][iio-next] iio: chemical: fix spelling mistake "failted"
 -> "failed"
Message-ID: <20180803223411.02e1deb4@archlinux>
In-Reply-To: <20180803120505.GA3741@himanshu-Vostro-3559>
References: <20180803115551.18866-1-colin.king@canonical.com>
        <20180803120505.GA3741@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 17:35:06 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 03, 2018 at 12:55:51PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > fix spelling mistake in dev_err error message text
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>  
> 
> Oops! Thanks for the patch Colin.
> 
> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
Applied to the togreg  branch of iio.git. Thanks,

Jonathan

