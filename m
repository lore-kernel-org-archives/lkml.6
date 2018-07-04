Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED640C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3463223BD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3463223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933733AbeGDJ0R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:26:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932978AbeGDJ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:26:10 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7092CC9A;
        Wed,  4 Jul 2018 09:26:09 +0000 (UTC)
Date:   Wed, 4 Jul 2018 11:13:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com
Subject: Re: [PATCH 01/15] Introduce Cadence USBSSP DRD Driver - added
 gadget.c file.
Message-ID: <20180704091342.GA25518@kroah.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-2-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530647879-10007-2-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:57:45PM +0100, Pawel Laszczak wrote:
> From: Laszczak Pawel <pawell.cadence.com>
> 
> Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> ---

I can't take patches without any changelog text at all, sorry.

Also, your subject lines need work, look at how all other usb patches
are written, your long prefix is not really helping out here.

>  drivers/usb/usbssp/gadget.c | 2082 +++++++++++++++++++++++++++++++++++
>  1 file changed, 2082 insertions(+)
>  create mode 100644 drivers/usb/usbssp/gadget.c


Just splitting the driver up by file is hard to review, as you are just
dumping individual files on us, not functionality, and we can not review
anything until all of them are added.  Can you break this up into
logical chunks?  Make these in a way that is easy to review, would you
want to review this patch series in this way?

thanks,

greg k-h
