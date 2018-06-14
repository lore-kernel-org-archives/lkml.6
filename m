Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3575BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D9208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVD1YACv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04D9208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeFNFlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbeFNFlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:41:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA33208D9;
        Thu, 14 Jun 2018 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528954864;
        bh=uBNJeMLAa1WKPfP6ToWZ1zqs3lrNuW61UFY3cZtvZf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVD1YACvWE25QmxiEDYQUa5SpDwD0shh05c5LcbhDYMFtfey+sQX1P68TTbZIw0Gc
         +q5Q7qyAnhCTXPPX62MxspZ9UDxy4ktdpmxLfDHFVAxeiTE6tPAPJlzNoW2QBYaQf7
         ge3Sofiwze49S9gWgmP59yYejVVQBYB16Z1mRvao=
Date:   Thu, 14 Jun 2018 07:40:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Javier Martinez <javiermlinux@gmail.com>
Cc:     devel@driverdev.osuosl.org, jhogan@kernel.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@iki.fi
Subject: Re: [PATCH] Staging: octeon-usb: octeon-hcd.c: Remove boiler plate
 and add SPDX
Message-ID: <20180614054041.GA30298@kroah.com>
References: <20180613212825.GA16479@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613212825.GA16479@javier-Z97X>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:28:25PM -0400, Javier Martinez wrote:
> Removed massive boiler plate text at top of the file and instead
> replaced it with a simple SPDX license identifier.
> 
> Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 47 ++-----------------------
>  1 file changed, 2 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index cded30f145aa..df61e8321140 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -1,48 +1,5 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright (C) 2008 Cavium Networks
> - *
> - * Some parts of the code were originally released under BSD license:
> - *
> - * Copyright (c) 2003-2010 Cavium Networks (support@cavium.com). All rights
> - * reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions are
> - * met:
> - *
> - *   * Redistributions of source code must retain the above copyright
> - *     notice, this list of conditions and the following disclaimer.
> - *
> - *   * Redistributions in binary form must reproduce the above
> - *     copyright notice, this list of conditions and the following
> - *     disclaimer in the documentation and/or other materials provided
> - *     with the distribution.
> - *
> - *   * Neither the name of Cavium Networks nor the names of
> - *     its contributors may be used to endorse or promote products
> - *     derived from this software without specific prior written
> - *     permission.
> - *
> - * This Software, including technical data, may be subject to U.S. export
> - * control laws, including the U.S. Export Administration Act and its associated
> - * regulations, and may be subject to export or import regulations in other
> - * countries.
> - *
> - * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
> - * AND WITH ALL FAULTS AND CAVIUM NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
> - * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
> - * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION
> - * OR DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
> - * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
> - * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
> - * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
> - * CORRESPONDENCE TO DESCRIPTION. THE ENTIRE RISK ARISING OUT OF USE OR
> - * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
> - */
> +// SPDX-License-Identifier: GNU GPL

That is not a valid identifier, please read the documentation for how to
do this properly.

Also, and more importantly, you picked the wrong one.  Do NOT mess with
license texts if you don't know what you are doing...

greg k-h
