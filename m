Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D85C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D8B21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546591166;
	bh=Udk4XQLpdwM0jbOp5CVLzuNRERZSl8YNl9E+DXzWJhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgXlLLZ8g+tKKE9kL2SAf7562UhWyBBHRWVvD4CfCA6jzseQMI/qNenNGJS8KGUYy
	 m91gpeLbMgzr6BOWU/6vTUTQSy6FnJI1NLtn/A0k/NhTjfd9VS54H3e+tascUPpCs8
	 JPsQ8RdnaGoBkNmWtt0CFrTXel2bEfVAIFoEkd5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfADIjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfADIjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:39:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70AB7217F5;
        Fri,  4 Jan 2019 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546591164;
        bh=Udk4XQLpdwM0jbOp5CVLzuNRERZSl8YNl9E+DXzWJhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZ8WBbd8JTWYe5sjWhJq2GuZP+sJW13vhaTc+D4nRF3FpHy/WGsLdaZLZKApD0I2r
         9bgrxPrwiGp5Ilqq0gm3kHmLJqJX7lYTAPJUQtvFWoXA0qYKAYFczSTiPwppykZ/lb
         Xnkv4pAJ03oMyOqL+kmAh/PuroXOc8qMus8ffzSg=
Date:   Fri, 4 Jan 2019 09:39:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt29f_spinand: add SPDX identifiers
Message-ID: <20190104083922.GA30245@kroah.com>
References: <20181223095702.25701-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223095702.25701-1-straube.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 10:57:02AM +0100, Michael Straube wrote:
> This satisfies a checkpatch warning and is the preferred
> method for notating the license.
> 
> The SPDX identifier is a legally binding shorthand, which
> can be used instead of the full boiler plate text.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/mt29f_spinand/mt29f_spinand.c | 11 +----------
>  drivers/staging/mt29f_spinand/mt29f_spinand.h | 12 ++----------
>  2 files changed, 3 insertions(+), 20 deletions(-)

This driver is no longer in the kernel tree :(
