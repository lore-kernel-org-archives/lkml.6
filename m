Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C18C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333BB2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333BB2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeI0Lfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:35:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeI0Lfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:35:53 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21EA8BD8;
        Thu, 27 Sep 2018 05:19:27 +0000 (UTC)
Date:   Thu, 27 Sep 2018 07:19:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Lingfeng Yang <lfy@google.com>
Subject: Re: [PATCH v2 06/21] platform: goldfish: pipe: Add DMA support to
 goldfish pipe
Message-ID: <20180927051925.GA473@kroah.com>
References: <20180926230222.126513-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926230222.126513-1-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:02:19PM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> Goldfish DMA is an extension to the pipe device and is designed
> to facilitate high-speed RAM->RAM transfers from guest to host.
> 
> See uapi/linux/goldfish/goldfish_dma.h for more details.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> Signed-off-by: Lingfeng Yang <lfy@google.com>
> ---
> Changes in v2:
>  - Got sign-off from Lingfeng Yang.
>  - Removed the license boilerplate from goldfish_dma.h.
>  - Rebased.

I don't understand this series.  Please start over with 01/XX as your
other patches were all merged.

And I still think you need a better justification for this, given the
many other ways the kernel already has for this feature...

thanks,

greg k-h
