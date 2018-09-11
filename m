Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B05820882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B05820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIKTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:12:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeIKTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:12:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFF0BD6D;
        Tue, 11 Sep 2018 14:12:51 +0000 (UTC)
Date:   Tue, 11 Sep 2018 16:12:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for
 the v4.20 merge window
Message-ID: <20180911141249.GA19639@kroah.com>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911111850.GJ4185@dell>
 <20180911140400.GB18410@kroah.com>
 <20180911140733.GU4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911140733.GU4185@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 03:07:33PM +0100, Lee Jones wrote:
> On Tue, 11 Sep 2018, Greg KH wrote:
> 
> > On Tue, Sep 11, 2018 at 12:18:50PM +0100, Lee Jones wrote:
> > > [In case you missed it]
> > > 
> > > This new pull-request contains the following changes since v1:
> > > 
> > >  - Uplift the submission version from v11 to v12
> > >  - Include fix for build breakage due to missing Device Tree include file
> > > 
> > > Since it is based on the original pull-request, it can be pulled
> > > in either directly on top of it or as a pull in its own right.
> > > 
> > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > > 
> > >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20-1
> > 
> > Ok, let's try this again, I've dropped that other patch and taken this
> > branch into my tree.
> 
> What happened to not rebasing? :D

Turned out I hadn't pushed to my immutable branch yet, we got lucky :)

