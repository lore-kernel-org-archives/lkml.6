Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0982FC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCBC20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCBC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeG1QVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:21:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeG1QVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:21:03 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9121C75;
        Sat, 28 Jul 2018 14:54:15 +0000 (UTC)
Date:   Sat, 28 Jul 2018 16:54:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, vikram.prakash@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2] serial: 8250_dw: Add ACPI support for uart on
 Broadcom SoC
Message-ID: <20180728145412.GA19385@kroah.com>
References: <1532680970-5703-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532680970-5703-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:12:50PM +0530, Srinath Mannam wrote:
> Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
> to match the HID passed through ACPI tables to enable
> UART controller.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 1 +
>  1 file changed, 1 insertion(+)

WHat changed from v1?  ALways put that below the --- line.

v3?

thanks,

greg k-h
