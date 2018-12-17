Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E94C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F682146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545059725;
	bh=mlX7Aa+SmOstjZQvOtmBH5jCPEcWusEB2NM1jp1Aa70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xw6O4SlPlokKMnQVYCZmxBisKjjaatWve7tJrOG9k4ZpbwcYu0NZ2YVYi6kkpHW1D
	 oV6VXqJpnrUKpuuWv3ZxT2oit6h05/vHK0iRtlLR1V92urXBhJb4oD8aIGmFKeG5SP
	 yAHvggCKL0arpR3nHkkj5x04TncQrm9Co6qc4bN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbeLQPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLQPPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:15:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ECA52133F;
        Mon, 17 Dec 2018 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545059723;
        bh=mlX7Aa+SmOstjZQvOtmBH5jCPEcWusEB2NM1jp1Aa70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVFVTqhq38qYSXyJL2ZCnt277DOlAexowGkR7r6hqxmuw/UE+k3CJhR57q2wo0+Tx
         3qURyFyFUpXIUsv0JYPpxNrwF9hR++sJIXbCEzoM7OnCMrb3ndcwkuBaYONg8GAcD3
         zE+NtqL0cm/+1X1xUavwSFtSFAEorKcBXyavemsk=
Date:   Mon, 17 Dec 2018 16:15:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: uartps: Add the device_init_wakeup
Message-ID: <20181217151520.GA12453@kroah.com>
References: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:20:11PM +0100, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Initialise the device wakeup.

Why?  This says what happened, which you can see from the patch itself,
but it does not say why this is needed at all.

Also, you sent 4 patches, without any numbering, so I have no idea what
order to apply them in.

Please fix the changelog entries up and send this as a patch series so
that I can correctly apply them.

thanks,

greg k-h
