Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF426C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA29E20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbfARI5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:57:01 -0500
Received: from shell.v3.sk ([90.176.6.54]:37105 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfARI5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:57:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D20F05ED1C;
        Fri, 18 Jan 2019 09:56:57 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9LSg8G4D1Inh; Fri, 18 Jan 2019 09:56:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 724445ED3F;
        Fri, 18 Jan 2019 09:56:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ywmN2yxUZKkc; Fri, 18 Jan 2019 09:56:55 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B9D685ED1C;
        Fri, 18 Jan 2019 09:56:54 +0100 (CET)
Message-ID: <6f756e0e84275266848dab28866a9250bc43088b.camel@v3.sk>
Subject: Re: [PATCH] USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Fri, 18 Jan 2019 09:56:53 +0100
In-Reply-To: <20190118085226.GB9572@kroah.com>
References: <20190114201608.17514-1-lkundrak@v3.sk>
         <20190118085226.GB9572@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 09:52 +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 14, 2019 at 09:16:08PM +0100, Lubomir Rintel wrote:
> > This fixes autoloading the module by the OF compatible string.
> > 
> > Fixes: 813e18b18a87 ("USB: EHCI: ehci-mv: add DT support")
> > Cc: stable@vger.kernel.org # v4.19+
> 
> Wait, why 4.19?  813e18b18a87 is in 4.20, not 4.19, so why would this
> matter to 4.19 at all?

You're right.

Sorry. (I've naively used "git describe 813e18b18a87" to guess the
release this went to, failing to realize that the commit went to main
tree via merge. I guess I should've done a git tag --contains instead.)

> 
> thanks,
> 
> greg k-h

Lubo

