Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C220ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EF820875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EF820875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbeGWOdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:33:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388087AbeGWOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:33:20 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CC90BAC;
        Mon, 23 Jul 2018 13:32:02 +0000 (UTC)
Date:   Mon, 23 Jul 2018 15:32:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dev-harsh1998 <harshitjain6751@gmail.com>
Cc:     trivial@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Joe Perches <joe@perches.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Message-ID: <20180723133200.GA1167@kroah.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723131954.30739-4-harshitjain6751@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> 
> WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +		.dattr = __ATTR(_field, S_IRUGO,			\
> 
> Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>

This name doesn't match up with the From: line above :(

Please fix up and try again.

thanks,

greg k-h
