Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CDFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9703021CE8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9703021CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbeFUUxZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:53:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbeFUUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:53:24 -0400
Received: from localhost (unknown [61.115.201.81])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06F8FD71;
        Thu, 21 Jun 2018 20:53:23 +0000 (UTC)
Date:   Fri, 22 Jun 2018 05:53:22 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nabimanya Lynn <nabimanya000@gmail.com>
Cc:     jirislaby@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.17.0-rc3 1/2] tty: add spaces
Message-ID: <20180621205322.GC19443@kroah.com>
References: <20180621020059.GA10915@lynn-ThinkPad-T400>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621020059.GA10915@lynn-ThinkPad-T400>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:00:59AM +0300, Nabimanya Lynn wrote:
> linux-kernel@vger.kernel.org
> Bcc: 
> Subject: [PATCH 4.17.0-rc3 1/2] tty: add spaces 
> Reply-To: 

Why is that in the changelog text?

And here is patch 1/2, why is it not threaded?

Please fix this all up and resend the series and properly cc: the
correct mailing list.  scripts/get_maintainer.pl is your friend.

thanks,

greg k-h
