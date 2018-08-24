Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA867C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8263321477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8263321477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeHXWpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:45:38 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32929 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeHXWpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:45:38 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w7OJ9WaW013027;
        Fri, 24 Aug 2018 21:09:32 +0200
Date:   Fri, 24 Aug 2018 21:09:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Current LTS and their EOL
Message-ID: <20180824190932.GA13024@1wt.eu>
References: <20180817154006.GA3725@intel.com>
 <20180817161727.GA24945@kroah.com>
 <7b13f62636d1f0547287cfe0a6135651eba194c1.camel@decadent.org.uk>
 <20180824182445.GA8702@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824182445.GA8702@kroah.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 08:24:45PM +0200, Greg KH wrote:
> On Sat, Aug 18, 2018 at 07:52:58PM +0100, Ben Hutchings wrote:
> > In the latest release we used Linux 4.9 which currently has a stated
> > EOL of 2019.  But I'm prepared to take on maintenance from that point
> > until June 2022.  Greg, is that OK with you and should the EOL be
> > updated on that basis?
> 
> Thanks a lot for the offer, but I can handle 4.9 until 2023 now, and
> I've updated kernel.org with the new dates to reflect this.  I can
> always use help though, if you want to make sure I don't miss any
> patches that Debian specifically needs.

Excellent, thank you very much Greg!

Willy
