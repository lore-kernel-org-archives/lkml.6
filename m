Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADBDC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65A420896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkaeYprm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65A420896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeFPHD0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932319AbeFPHDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:03:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B23420896;
        Sat, 16 Jun 2018 07:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529132604;
        bh=RoC8XU4xuYhFyqj0pRUfM1u4aOe+tXmvWkZaDNbpjVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkaeYprmMoL7DVPo6NuSGfqe3QwWfdnR23/OYVr9ub2n2qpM2wDwj/socM364pVIi
         MEtqfi/np8iHrAjHGckmBtWPpeR3Nud0W2sTydAOd0M7N+oa6edf4450Xho0YdUahZ
         Gt7WQn8BH3niuejhg7tEz+eYjh3f6V1UMceZWyRM=
Date:   Sat, 16 Jun 2018 09:03:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "JoonHwan.Kim" <spilit464@gmail.com>
Cc:     alan@linux.intel.com, sakari.ailus@linux.intel.com,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: staging: atomisp: add a blank line after
 declarations
Message-ID: <20180616070301.GA30558@kroah.com>
References: <2750553.3y1WJKmnP5@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2750553.3y1WJKmnP5@joonhwan-virtualbox>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 01:30:48PM +0900, JoonHwan.Kim wrote:
> fix checkpatch.pl warning:
>   * Missing a blank line after declarations
> 
> Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
> ---
>  drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c | 5 +++++

Always work against the latest development tree so you do not duplicate
work.  This file is gone in Linus's tree, and in linux-next :(

thanks,

greg k-h
