Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF30FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837F22083E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837F22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeGOUE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:04:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeGOUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:04:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D458ED85;
        Sun, 15 Jul 2018 19:41:00 +0000 (UTC)
Date:   Sun, 15 Jul 2018 21:40:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH resend] staging: gasket: remove X86 Kconfig restriction
Message-ID: <20180715194058.GB2288@kroah.com>
References: <20180715182545.187942-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715182545.187942-1-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 11:25:45AM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> The gasket and apex drivers are to be used on other architectures
> besides X86.
> 
> Signed-off-by: Todd Poynor <toddpoynor@gmail.com>
> ---
>  drivers/staging/gasket/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why are these all a "resend"?  They need to be in a v2 series, based on
the changes requested, right?  "resend" implies I somehow did not see
them...

And always properly version your patch series, and number them in order,
otherwise I have no idea what order to apply them in, and if I have
missed any or not.

Remember, you need to make it as simple as possible for me not to mess
things up :)

thanks,

greg k-h
