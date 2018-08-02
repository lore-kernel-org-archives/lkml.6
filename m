Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CB1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E80520C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E80520C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeHBKIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:08:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:08:14 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 434BFC3A;
        Thu,  2 Aug 2018 08:18:12 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:18:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next 06/12] mei: dma ring buffers allocation
Message-ID: <20180802081809.GA8969@kroah.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
 <20180731063544.25540-7-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731063544.25540-7-tomas.winkler@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:35:38AM +0300, Tomas Winkler wrote:
> --- /dev/null
> +++ b/drivers/misc/mei/dma-ring.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0

I thought Intel was not doing this type of crazy nonsense anymore and
just properly creating new files that were GPL-2.0.

Are you _sure_ you want to do this?

> +/*
> + * Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved.

How is a new file copyright 2016?  You have had this file laying around
for 2 years?

thanks,

greg k-h
