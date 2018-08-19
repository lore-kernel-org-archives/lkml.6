Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F14C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625222159D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625222159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHSJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 05:22:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeHSJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 05:22:53 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DD522C;
        Sun, 19 Aug 2018 06:12:30 +0000 (UTC)
Date:   Sun, 19 Aug 2018 08:12:27 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next 00/12] mei: Add DMA ring
Message-ID: <20180819061227.GA3784@kroah.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
 <20180802081921.GB8969@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D983269@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D995EBE@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D995EBE@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 05:34:35AM +0000, Winkler, Tomas wrote:
> 
> > 
> > > On Tue, Jul 31, 2018 at 09:35:32AM +0300, Tomas Winkler wrote:
> > > > This series adds an alternative method for transferring data between
> > > > the mei driver and the device via a DMA ring. The DMA ring allows
> > > > transferring data in bigger chunks, up to 128K, than the HW ring 512B.
> > > > The actual sizes depend on particular MEI generations.
> > > > The HW ring is faster for packets that fits into the HW ring while a
> > > > packet that would require fragmentation is faster to send via the
> > > > DMA ring.
> > >
> > > I've applied the first 5 patches now.  Please fix up and resend the rest.
> > 
> > Greg, as I wrote, we wish to stay with the dual license in that file,  please can
> > you apply the patches as they are?
> 
> Hi Greg, can you please respond, we have half of the series merged only, it should be completed.

It's the middle of the merge window, with major security things
happening at the same time, my ability to be persistant and annoyed at
minor things like this is very low...

Anyway, the patch series is long gone from my queue, you will have to
resend them please.  But first, I want to see an Intel lawyer's
signed-off-by on them when you do resend them as the last time I talked
to them, they said they were not going to be doing dual-licensed kernel
code anymore for a whole bunch of reasons I don't want to get into on a
public mailing list.

So go verify this please, and get their approval before resending.

thanks,

greg k-h
