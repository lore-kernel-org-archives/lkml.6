Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF46C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81A320880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeIJU7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:59:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeIJU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:59:51 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26036EC0;
        Mon, 10 Sep 2018 16:05:04 +0000 (UTC)
Date:   Mon, 10 Sep 2018 18:04:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, op <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] tty: hvc: latency break regression fixes
Message-ID: <20180910160454.GA30939@kroah.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 03:39:13PM +1000, Nicholas Piggin wrote:
> Re-sending this one with the used-uinitialized warning in patch
> 3 fixed.
> 
> Greg these patches are needed to fix regressions in this merge
> window, please consider them for your tty tree.

All now queued up, thanks.

greg k-h
