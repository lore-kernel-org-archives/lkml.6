Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0DFC04AB8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506E0214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506E0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeIRTJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:09:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:09:56 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A60CD8E2;
        Tue, 18 Sep 2018 13:37:17 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:37:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] tty_port: Fix function name and brief desc
Message-ID: <20180918133715.GB23431@kroah.com>
References: <20180912075044.8695-1-me@tobin.cc>
 <20180912075044.8695-3-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912075044.8695-3-me@tobin.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:50:43PM +1000, Tobin C. Harding wrote:
> @@ -235,7 +235,7 @@ void tty_port_free_xmit_buf(struct tty_port *port)
>  EXPORT_SYMBOL(tty_port_free_xmit_buf);
>  
>  /**
> - * tty_port_destroy -- destroy inited port
> + * tty_port_destroy() - Destroy inited port.

Ok, using () for a function name, that's fine, but then you do:

>  /**
> - *	tty_port_tty_set	-	set the tty of a port
> - *	@port: tty port
> - *	@tty: the tty
> + * tty_port_tty_set - Set the tty of a port.

Oops, not here.  Consistency is the key.

thanks,

greg k-h
