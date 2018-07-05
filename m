Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46473C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0925D223B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0925D223B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeGEQFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:05:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeGEQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:05:15 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54F46CAD;
        Thu,  5 Jul 2018 16:05:14 +0000 (UTC)
Date:   Thu, 5 Jul 2018 18:05:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        vivek.gautam@codeaurora.org
Subject: Re: [PATCH] drivers/base: add sysfs entries for suppliers and
 consumers
Message-ID: <20180705160511.GA7761@kroah.com>
References: <1530806428-19702-1-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530806428-19702-1-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:00:28PM +0300, Ioana Ciornei wrote:
> Instead of scraping dmesg for messages such as 'Linked as a consumer to'
> or 'Dropping the link to' export two new sysfs entries in the device
> folder that list the consumer and supplier devices.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/base/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

No new documentation files for these new sysfs files?  Not good :(
