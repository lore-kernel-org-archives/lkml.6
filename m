Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB83C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445762148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xDxo7/rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445762148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeKLF0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeKLF0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:26:16 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB243214DB;
        Sun, 11 Nov 2018 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541965011;
        bh=mE4jdqqGKgo7qXp2kB9UW/kgt/ogBbzNaG8Ct4uMuNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDxo7/rBrcfqp5ftb9Tr1OuBwj5/u6xXYO8A4SQSQ0TmawSOJNZ0BwRzdi6ecmvUI
         49Elb+vX/16G1WLKR7TYmXFIYL6b4UdEPrXA/xwnvlz77GKN3Ylu8AKmr3m6brnnIX
         wX/nBhggwo9QbB7kqggRAhbfVnUMuCQrkzSrJJQU=
Date:   Sun, 11 Nov 2018 11:36:51 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-apb-ctrl.c: Switch to the gpio
 descriptor interface
Message-ID: <20181111193651.GA18278@kroah.com>
References: <20181111054405.GA32548@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111054405.GA32548@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:14:14AM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/greybus/arche-apb-ctrl.c | 158 ++++++++++-------------
>  1 file changed, 65 insertions(+), 93 deletions(-)

This patch does not apply to my tree at all :(

Please rebase and resend, thanks.

greg k-h
