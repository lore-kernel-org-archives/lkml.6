Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFACFECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A421121529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A421121529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbeITQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:20:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbeITQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:20:35 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0479ED4;
        Thu, 20 Sep 2018 10:37:44 +0000 (UTC)
Date:   Thu, 20 Sep 2018 12:37:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Zeng Tao <prime.zeng@hisilicon.com>, stern@rowland.harvard.edu,
        mathias.nyman@linux.intel.com, drinkcat@chromium.org,
        felipe.balbi@linux.intel.com, drake@endlessm.com,
        ravisadineni@chromium.org, joe@perches.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: hub: try old enumeration scheme first for high
 speed devices
Message-ID: <20180920103742.GD14252@kroah.com>
References: <1534759484-44744-1-git-send-email-prime.zeng@hisilicon.com>
 <535e6c93-4369-c01e-953c-35e7041129e8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535e6c93-4369-c01e-953c-35e7041129e8@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 09:55:49AM +0300, Roger Quadros wrote:
> On 20/08/18 13:04, Zeng Tao wrote:
> > The new scheme is required just to support legacy low and full-speed
> > devices. For high speed devices, it will slower the enumeration speed.
> > So in this patch we try the "old" enumeration scheme first for high speed
> > devices, and this is what Windows does since Windows 8.
> > 
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> 
> You need to add Alan's Ack here. I don't think you need to resend though.
> 
> Reviewed-by: Roger Quadros <rogerq@ti.com>

Please resend, I need his ack here :)

thanks,

greg k-h
