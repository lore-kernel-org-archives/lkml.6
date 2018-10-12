Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E98C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391B52077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfmF7pw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391B52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeJLSoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbeJLSoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:44:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33D32087D;
        Fri, 12 Oct 2018 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539342725;
        bh=irjhZN30JRfU6wJy7Tb92fEMENin2qzNcsL8e7NSLBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfmF7pw3cp6EISdzFQFM2D6UuFfRJ1b6Wv4cTtmxe5Y81bpyCYxTqOcGOMx8MiIAr
         dnZrwy9bVPdAWB7n2R9I+3AfmeyfuqE75fjP2upPDiOmY+FIK+gxcTAi2e20pSeDic
         YtiKud1kdpOREqrjVKF7NymqiVZZ3WlNXlL+ekd0=
Date:   Fri, 12 Oct 2018 13:12:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [GIT PULL] pin control fix for v4.19
Message-ID: <20181012111202.GD6536@kroah.com>
References: <CACRpkdYaWwrwYvOK9PoFE7GvyAZxVA5JqPbCRSpLHLVcQubp6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYaWwrwYvOK9PoFE7GvyAZxVA5JqPbCRSpLHLVcQubp6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:30:18AM +0200, Linus Walleij wrote:
> Hi Greg,
> 
> Here is a last minute pin control fix for the v4.19 series.
> 
> Please pull it in. It fixes interrupts on the MCP23s08.
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> tags/pinctrl-v4.19-5

Now merged, thanks.

greg k-h

