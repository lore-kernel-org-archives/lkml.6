Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC1DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8609420894
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8609420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeILMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:16:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeILMQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:16:07 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89C2FE30;
        Wed, 12 Sep 2018 07:12:56 +0000 (UTC)
Date:   Wed, 12 Sep 2018 09:12:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next 00/12] mei: Add DMA ring
Message-ID: <20180912071253.GA19548@kroah.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
 <20180802081921.GB8969@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D983269@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D983269@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 04:11:56PM +0000, Winkler, Tomas wrote:
> > On Tue, Jul 31, 2018 at 09:35:32AM +0300, Tomas Winkler wrote:
> > > This series adds an alternative method for transferring data between
> > > the mei driver and the device via a DMA ring. The DMA ring allows
> > > transferring data in bigger chunks, up to 128K, than the HW ring 512B.
> > > The actual sizes depend on particular MEI generations.
> > > The HW ring is faster for packets that fits into the HW ring while a
> > > packet that would require fragmentation is faster to send via the DMA
> > > ring.
> > 
> > I've applied the first 5 patches now.  Please fix up and resend the rest.
> 
> Greg, as I wrote, we wish to stay with the dual license in that file,
> please can you apply the patches as they are?

I don't have these anymore in my queue, can you rebase and resend?

thanks,

greg k-h
