Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C35121872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546591515;
	bh=VHMwOTubUxcWCk7XL3rnch1R2SGmgfqQVR6tbzSbm9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XnNsoMWZOuC13raZA1AVTzL5zcHjsCzWuqVfAuoO1jJu2gnpUBK+BYqxz7FDPnOel
	 FCKqKHq723gh+rN3Sz/LNSL61I5iIbe4XMQkXxLjrzcgeP2ib8oRrd94quWzyIrVs4
	 JY5L5SWjpujh9iARO3/poQYyBpvCWjBXQkmvyusc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfADIpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfADIpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:45:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D80820665;
        Fri,  4 Jan 2019 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546591513;
        bh=VHMwOTubUxcWCk7XL3rnch1R2SGmgfqQVR6tbzSbm9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1BJrpgq5jJb+yndMN+hE+Q+y4mAOpycrQWCkCFh9wmdDAArcESRy57lCAok42rd/
         DKUZujXH4X2L/3Av+GRWYEXZ43Ut49+qowQhyXRPw4ZMZ+tcvibvRNDhCwyipz/e2g
         jNzGIFRelqSZm0ThqJIqKPJ6UbppW1Te7R2Ltob0=
Date:   Fri, 4 Jan 2019 09:45:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register
 variables
Message-ID: <20190104084511.GA17997@kroah.com>
References: <20190102213636.40866-1-ryandcase@chromium.org>
 <20190102213636.40866-5-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102213636.40866-5-ryandcase@chromium.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 01:36:36PM -0800, Ryan Case wrote:
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

I can not take patches without any changelog text, sorry.

greg k-h
