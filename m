Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28292C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE992088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE992088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeILMQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:16:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeILMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:16:57 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4C3BE30;
        Wed, 12 Sep 2018 07:13:46 +0000 (UTC)
Date:   Wed, 12 Sep 2018 09:13:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next 06/12] mei: dma ring buffers allocation
Message-ID: <20180912071344.GB19548@kroah.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
 <20180731063544.25540-7-tomas.winkler@intel.com>
 <20180802081809.GA8969@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D97F93D@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D97F93D@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 08:38:30PM +0000, Winkler, Tomas wrote:
> 
> > Subject: RE: [char-misc-next 06/12] mei: dma ring buffers allocation
> > 
> > 
> > > On Tue, Jul 31, 2018 at 09:35:38AM +0300, Tomas Winkler wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/misc/mei/dma-ring.c
> > > > @@ -0,0 +1,103 @@
> > > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> > >
> > > I thought Intel was not doing this type of crazy nonsense anymore and
> > > just properly creating new files that were GPL-2.0.
> > >
> > > Are you _sure_ you want to do this?
> I would prefer to keep it that way actually,  hoping eventually
> relicense most of the files in the driver under the dual license, 
> currently it's really kind of mix. 
> I'm not sure where this was discussed before, so you've surprised me with this comment.

Please go talk to the open source legal team at Intel, this has been
discussed with them a number of times now.  Look at the IB drivers for
one example of how this has changed.

thanks,

greg k-h
