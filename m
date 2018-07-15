Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F282ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D0420882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D0420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeGOIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 04:33:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeGOIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 04:33:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9220899;
        Sun, 15 Jul 2018 08:11:37 +0000 (UTC)
Date:   Sun, 15 Jul 2018 10:11:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Message-ID: <20180715081134.GA20758@kroah.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
 <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180612080256.GA17399@kroah.com>
 <MWHPR02MB2816AE6D9F6C065DADA78D7EA75F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180715080206.GA19377@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715080206.GA19377@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:02:06AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 14, 2018 at 03:37:20PM +0000, Anurag Kumar Vulisha wrote:
> > HI Greg,
> > 
> > Ping!
> > Thought of giving a friendly remainder about this patch.
> 
> I am not the xhci maintainer, I need to wait from an ack from him before
> I can take it.

And he's on vacation until later this week, so just relax.

greg k-h
