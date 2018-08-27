Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6BEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473A4208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473A4208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH0V5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:57:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0V5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:57:15 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1A1ECB6;
        Mon, 27 Aug 2018 18:09:36 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:56:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jannis Nawroth <jnaw@jpberlin.de>
Cc:     ruxandra.radulescu@nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] Staging: fsl-dpaa2: ethsw: dpsw: Use correct
 SPDX-License-Identifier comment
Message-ID: <20180827175651.GA11957@kroah.com>
References: <20180819162136.19647-1-jnaw@jpberlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819162136.19647-1-jnaw@jpberlin.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 06:21:36PM +0200, Jannis Nawroth wrote:
> Use correct comment for SPDX-License-Identifier
> 
> Signed-off-by: Jannis Nawroth <jnaw@jpberlin.de>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/dpsw.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
> index db43fa3782b8..95feb7ffd575 100644
> --- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
> +++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
> @@ -1,5 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> +/* SPDX-License-Identifier: GPL-2.0

Close, but still incorrect :(

