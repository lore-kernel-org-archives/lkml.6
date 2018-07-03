Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CECC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045A924B71
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045A924B71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeGCLjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:39:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeGCLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:39:33 -0400
Received: from localhost (mobile-166-137-176-030.mycingular.net [166.137.176.30])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0F85CA0;
        Tue,  3 Jul 2018 11:39:30 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:38:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc 1/2] mei: remove unused MEI_IAMTHIF_STALL_TIMER define
Message-ID: <20180703113835.GA19389@kroah.com>
References: <20180606213148.9469-1-tomas.winkler@intel.com>
 <20180606213148.9469-2-tomas.winkler@intel.com>
 <20180703111113.GA14839@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D95AFF1@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D95AFF1@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:28:12AM +0000, Winkler, Tomas wrote:
> 
> > 
> > On Thu, Jun 07, 2018 at 12:31:47AM +0300, Tomas Winkler wrote:
> > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > >
> > > MEI_IAMTHIF_STALL_TIMER is unused now and can be safely removed.
> > >
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > >  drivers/misc/mei/hw.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > 
> > Not a regression fix :(
> 
> No problem, please merge to next.

Already done! :)
