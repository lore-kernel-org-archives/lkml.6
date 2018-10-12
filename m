Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD2BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F72213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku+y3ejy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F72213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJLSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbeJLSoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:44:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22A82098A;
        Fri, 12 Oct 2018 11:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539342730;
        bh=lu4Q4yK45nmJxMa/5nNcGGzrNZInK57hnjgb2Jd1WkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ku+y3ejyD6nOo4apd7vhNrzCWbqVIbxWPDavjb3D4yW4orB4FdUvsJ4gfXb73ElhT
         ThDW77GRZBTwMyvjYY7Rb281z9poafjr0nzi/Xo2+pioBJ0cQHP68RQmHa57fk1jZ3
         dNQ0E9/ExS7lUJJOv2Sg1RdfMOPWyIo/AzCG58rs=
Date:   Fri, 12 Oct 2018 13:12:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [GIT PULL] GPIO fix for v4.19
Message-ID: <20181012111207.GE6536@kroah.com>
References: <CACRpkdb-KP_m6+2oB9r-WbR9K3juC+EMjgktv7v-PS_OACie=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb-KP_m6+2oB9r-WbR9K3juC+EMjgktv7v-PS_OACie=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:34:55AM +0200, Linus Walleij wrote:
> Hi Greg,
> 
> here is a last minute GPIO fix for the v4.19 series.
> 
> This fixes GPIO IRQchip parent assignment on a lot
> of GPIO drivers.
> 
> Please pull it in!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
> tags/gpio-v4.19-4

Now merged, thanks.

greg k-h

