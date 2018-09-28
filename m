Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C0EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BBC2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BBC2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeI1WrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:47:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1WrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:47:22 -0400
Received: from localhost (unknown [88.128.83.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EFAA8D8B;
        Fri, 28 Sep 2018 16:22:49 +0000 (UTC)
Date:   Fri, 28 Sep 2018 14:36:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 06/13] staging:rtl8192u: Remove TxSTBC and RxSTBC - Style
Message-ID: <20180928123632.GB7089@kroah.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-7-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191704.16322-7-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:16:57PM +0100, John Whitmore wrote:
> Remove the member variables TxSTBC and RxSTBC as neither is used in
> code.
> 
> This is a coding style change which should not impact runtime code
> execution.

Same as before, I think this _does_ impact runtime :(

I'll stop here in the series.

thanks,

greg k-h
