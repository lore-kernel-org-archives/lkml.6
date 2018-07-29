Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFBFF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64A1205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64A1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeG2OOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 10:14:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeG2OOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 10:14:25 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94416898;
        Sun, 29 Jul 2018 12:44:03 +0000 (UTC)
Date:   Sun, 29 Jul 2018 14:44:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v3 1/2] Staging: octeon-usb: Change multiple calling of
 CVMX_USBCX_GRSTCTL
Message-ID: <20180729124400.GB27275@kroah.com>
References: <20180727151527.GA2209@kroah.com>
 <cover.1532864087.git.tsotsos@gmail.com>
 <d2799c79835e21fd0421fc50189a6ea631fd7e15.1532864087.git.tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2799c79835e21fd0421fc50189a6ea631fd7e15.1532864087.git.tsotsos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 02:40:34PM +0300, Georgios Tsotsos wrote:
> Assign to variable the result of CVMX_USBCX_GRSTCTL instead of multiple
> calling a macro.
> 
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

What changed from previous versions?  You should always list that below
the --- line so that we know what is going on...

v4?  :)

thanks,

greg k-h
