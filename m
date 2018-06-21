Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E478EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA321CCE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEA321CCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeFUUwS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:52:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933499AbeFUUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:52:17 -0400
Received: from localhost (unknown [61.115.201.81])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 396A4D71;
        Thu, 21 Jun 2018 20:52:17 +0000 (UTC)
Date:   Fri, 22 Jun 2018 05:52:15 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nabimanya Lynn <nabimanya000@gmail.com>
Cc:     jirislaby@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.17.0-rc3 2/2] tty:mxser: remove trailing whitespace
Message-ID: <20180621205215.GB19443@kroah.com>
References: <20180621023435.GA11350@lynn-ThinkPad-T400>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621023435.GA11350@lynn-ThinkPad-T400>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:34:35AM +0300, Nabimanya Lynn wrote:
> Signed-off-by: Nabimanya Lynn <nabimanya000@gmail.com>

I can not take patches without any changelog text at all, sorry.

And why 4.17-rc3?  That's many months old?

And where is patch 1/2 in this series?

confused,

greg k-h
