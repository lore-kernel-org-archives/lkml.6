Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC0ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F522086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F522086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeIRTLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:11:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbeIRTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:11:31 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC3A48E2;
        Tue, 18 Sep 2018 13:38:52 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:38:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] tty_port: Fix kernel-docs warnings
Message-ID: <20180918133849.GA25134@kroah.com>
References: <20180912075044.8695-1-me@tobin.cc>
 <20180912075044.8695-4-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912075044.8695-4-me@tobin.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:50:44PM +1000, Tobin C. Harding wrote:
> Currently extracting the kernel-docs causes a six warnings of type
> 
>   warning: Function parameter or member 'foo' not described in 'bar'
> 
> Add function parameter descriptions to the function kernel-docs.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  drivers/tty/tty_port.c | 6 ++++++
>  1 file changed, 6 insertions(+)

As I didn't take patch 2/3, this one doesn't apply :(

thanks,

greg k-h
