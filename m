Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D6C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E827AA9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920E827AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966317AbeF2S0H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:26:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966039AbeF2S0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:26:04 -0400
Received: from localhost (unknown [65.196.126.174])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14916DB3;
        Fri, 29 Jun 2018 18:26:03 +0000 (UTC)
Date:   Fri, 29 Jun 2018 14:26:00 -0400
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180629182600.GA17562@kroah.com>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629094607.GC31718@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:46:07AM +0200, Pavel Machek wrote:
> 
> > > Finally, note that documentation (including kerneldoc) remains to be
> > > written, but hopefully this will not hinder review given that the
> > > current interfaces are fairly self-describing.
> > 
> > This all looks great.  Thanks for doing this work and adding a new
> > subsystem for something that has been asked for for many years.
> > 
> > All now merged in my tree, nice job!
> 
> I don't think discussion was finished on this one.

It looked done to me as there was only a single set of patches, with no
other working patches submitted from anyone else.

If this turns out to be a "bad" api, then we can deal with it then, but
for now let's try this out.

thanks,

greg k-h
