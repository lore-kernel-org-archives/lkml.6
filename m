Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD92420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8CCH0C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD92420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeKBCqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKBCqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:46:40 -0400
Received: from localhost (unknown [95.99.172.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2236820657;
        Thu,  1 Nov 2018 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541094163;
        bh=aEJQUK7ggPrGQlhRXBK1VqWBsOhXl7b8W1cZHsQi+Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8CCH0C2X0KmxKVODVA/PCEa/zLXqVTNYVSWImUHFOGxlA8gpkxCECIQxmIqH/wg/
         101GR/MyWhEIGgvVMu0v11TWWO0Kt5sINrHiqSuM8HcFasf87lQI/zKGsY08uzAdu7
         O+d3XqHyanKqe+c6vq0HkhrUBzP1MnhzPPAH0z3s=
Date:   Thu, 1 Nov 2018 18:41:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix small typo
Message-ID: <20181101174104.GA5179@kroah.com>
References: <20181101155624.23435-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101155624.23435-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:56:24AM -0400, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/usb/host/xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't take patches without any changelog text, sorry.

greg k-h
