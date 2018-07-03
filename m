Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6AD24AB4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6AD24AB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGCObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:31:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeGCObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:31:12 -0400
Received: from localhost (unknown [213.138.59.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94C95E3B;
        Tue,  3 Jul 2018 14:31:11 +0000 (UTC)
Date:   Tue, 3 Jul 2018 16:31:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/4] dts: misc: Add bindings documentation for
 bmc-misc-ctrl
Message-ID: <20180703143109.GB2043@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-2-andrew@aj.id.au>
 <20180703075009.GA27649@kroah.com>
 <a1c3ecd4fed28e2b33c95a476452318dba58cd7e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c3ecd4fed28e2b33c95a476452318dba58cd7e.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:16:49AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-03 at 09:50 +0200, Greg KH wrote:
> > On Tue, Jul 03, 2018 at 05:04:10PM +1000, Andrew Jeffery wrote:
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > 
> > I can't take patches without any changelog text at all :(
> 
> Greg (and replying to your other comments as well)...
> 
> This is an RFC series, it's not meant for you to take at this point,
> it's about discussing the overall approach to exposing BMC random
> "tunables" as explained in patch 0 of the series.
> 
> Yes the individual patches aren't yet at the level of polish for a
> formal submission, we (naively ?) thought that's what the whole RFC tag
> is about :-)

Oh come on, putting a basic "here is what this patch does" comment
should be part of every patch, otherwise what is there to comment on if
we don't know what is going on in the patch itself?

Anyway, I provided a bunch of feedback to the "real" patch in this
series...


greg k-h
