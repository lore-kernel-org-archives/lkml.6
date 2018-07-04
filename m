Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71115C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28129223BD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28129223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeGDJ0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:26:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeGDJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:26:13 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3759C9B;
        Wed,  4 Jul 2018 09:26:12 +0000 (UTC)
Date:   Wed, 4 Jul 2018 11:15:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com
Subject: Re: [PATCH 09/15] Introduce Cadence USBSSP DRD Driver - added
 debugfs files.
Message-ID: <20180704091524.GB25518@kroah.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-10-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530647879-10007-10-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:57:53PM +0100, Pawel Laszczak wrote:
> Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> ---

Again for all of these, you need a changelog text.

>  drivers/usb/usbssp/gadget-debugfs.c | 514 ++++++++++++++++++++++++++++
>  drivers/usb/usbssp/gadget-debugfs.h | 137 ++++++++
>  2 files changed, 651 insertions(+)
>  create mode 100644 drivers/usb/usbssp/gadget-debugfs.c
>  create mode 100644 drivers/usb/usbssp/gadget-debugfs.h
> 
> diff --git a/drivers/usb/usbssp/gadget-debugfs.c b/drivers/usb/usbssp/gadget-debugfs.c
> new file mode 100644
> index 000000000000..c0d1e96728e6
> --- /dev/null
> +++ b/drivers/usb/usbssp/gadget-debugfs.c
> @@ -0,0 +1,514 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USBSSP device controller driver
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak
> + * Some code borrowed from the Linux XHCI driver.

What code was borrowed?  Please acknowledge that copyright.

Also, why isn't Pawel's signed-off-by on this?

thanks,

greg k-h
