Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B046F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B046F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeG3KZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:25:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3KZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:25:50 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FFAACA1;
        Mon, 30 Jul 2018 08:51:52 +0000 (UTC)
Date:   Mon, 30 Jul 2018 10:51:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v5] Staging: octeon-usb: Using defined error codes and
 applying coding style.
Message-ID: <20180730085149.GA8460@kroah.com>
References: <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
 <20180729222936.27608-1-tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729222936.27608-1-tsotsos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 01:29:36AM +0300, Georgios Tsotsos wrote:
> Replaced -1 with defined error code EINVAL
> 
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
> v2: Apply coding style to function cvmx_usb_poll_channel
> v3: Break down function cvmx_usb_poll_channel
> v4: Return defined error code and applying coding style for function calls
> v5: Fixing wrong patch applied before with typo on dev_err and applying coding
> style as suggested on v3
> 
>  drivers/staging/octeon-usb/octeon-hcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ugh, I have no idea anymore what patches to apply from you for this
driver, sorry, there are too many flying around.

Take a day off, relax, and then resend all of your pending patches as
one series, properly numbered, and we can go from there.  I've dropped
all of your patches from my queue for now.

thanks,

greg k-h
