Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEAB20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEAB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeIKN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:59:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:59:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AA36CE6A;
        Tue, 11 Sep 2018 09:01:34 +0000 (UTC)
Date:   Tue, 11 Sep 2018 11:01:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911090132.GB25161@kroah.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <20180911084548.GC4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911084548.GC4185@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
> On Mon, 10 Sep 2018, Lee Jones wrote:
> 
> > Enjoy!
> > 
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > 
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> > 
> > for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> > 
> >   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
> 
> Due to a comedy of errors, I'm voiding this pull-request.

Um, I can't do that as my tree can not be rebased :(

I can take follow-on patches, so I will go apply the patch posted so
that my tree builds again.  I recommend you just apply it as well.

thanks,

greg k-h
