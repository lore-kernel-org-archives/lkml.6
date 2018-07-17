Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC40ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2EF208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2EF208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeGQMZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:25:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeGQMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:25:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B98A9899;
        Tue, 17 Jul 2018 11:53:05 +0000 (UTC)
Date:   Tue, 17 Jul 2018 13:53:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@google.com>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, frankhu@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, sque@chromium.org,
        groeck@chromium.org, Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 00/32 v2] staging: gasket: sundry fixes and fixups
Message-ID: <20180717115303.GA28592@kroah.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717111600.GA17117@kroah.com>
 <CAAW3Ypb-5=oUWdRP=DdR50onROXYn0PD2ofoeCttnP09Qq_pHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAW3Ypb-5=oUWdRP=DdR50onROXYn0PD2ofoeCttnP09Qq_pHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:25:36AM -0700, Todd Poynor wrote:
> On Tue, Jul 17, 2018 at 4:16 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 16, 2018 at 07:08:54PM -0700, Todd Poynor wrote:
> > > From: Todd Poynor <toddpoynor@google.com>
> > >
> > > Various fixes mainly from the chromium review of the gasket and apex
> > > drivers.  More to come.
> >
> > What changed from v1?
> >
> > You have to list it somewhere...
> 
> I have a list of each changed, dropped, and unchanged patch from v1
> here, was hoping it's in the right place for that info, does it need
> to be elsewhere farther up?

Ah, yeah, it was below the diffstat, I didn't even notice it there,
sorry about that.  Putting it higher up is nice, but not essencial.

thanks,

greg k-h
