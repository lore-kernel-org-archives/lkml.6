Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF31C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC7520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547800509;
	bh=Bh8kln6PmpMlCP7DFo4Xyx4Xs8GBTiyej5iaeo11pFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H1PG7lPLeB4QrAer2TQvCYtqhJfZ+t3V9u653EsADtlfMb8JxLXaB84ODfLqhLmHq
	 kOmMfgLr1CMl+KqsXuaR1RB12WuETktdaHRnzn0DhKVJ3lhUOUofonO74GT0vzC8dj
	 cHIB8EHTYwkR01gbt2yLPWfHuA0J9Il0CEETMUag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfARIfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfARIfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:35:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDBA20823;
        Fri, 18 Jan 2019 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547800506;
        bh=Bh8kln6PmpMlCP7DFo4Xyx4Xs8GBTiyej5iaeo11pFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6rFpRjzCgzWP4DHmonJgeSAED4I7aAX1dliUYfr9GUrbS/RV6v69IuWENWAirlyp
         WRCLTO6lnfhtNzZW1GDtEan2kc27rk4nXODaFI4PGuD2tF51IZqKZbt3TztaKwe7ji
         Iy1+VmXDTbvDXlaFhPeA2fhtzp+fOSNcz/jfHBYo=
Date:   Fri, 18 Jan 2019 09:35:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: email address update in MAINTAINERS entries
Message-ID: <20190118083504.GA28351@kroah.com>
References: <20190116232820.26180-1-shuah@kernel.org>
 <20190117083224.GA17261@kroah.com>
 <7c8ea821-68c8-2c8d-56c3-58612a46d3ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8ea821-68c8-2c8d-56c3-58612a46d3ce@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 07:30:54AM -0700, shuah wrote:
> On 1/17/19 1:32 AM, Greg KH wrote:
> > On Wed, Jan 16, 2019 at 04:28:20PM -0700, shuah@kernel.org wrote:
> > > From: Shuah Khan <shuah@kernel.org>
> > > 
> > > Update email address in MAINTAINERS entries.
> > > 
> > > Signed-off-by: Shuah Khan <shuah@kernel.org>
> > > ---
> > >   MAINTAINERS | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4d04cebb4a71..6ca780f24808 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3979,6 +3979,7 @@ F:	drivers/cpufreq/arm_big_little.c
> > >   CPU POWER MONITORING SUBSYSTEM
> > >   M:	Thomas Renninger <trenn@suse.com>
> > >   M:	Shuah Khan <shuah@kernel.org>
> > > +M:	Shuah Khan <skhan@linuxfoundation.org>
> > >   L:	linux-pm@vger.kernel.org
> > >   S:	Maintained
> > >   F:	tools/power/cpupower/
> > > @@ -8259,6 +8260,7 @@ F:	include/uapi/linux/sunrpc/
> > >   KERNEL SELFTEST FRAMEWORK
> > >   M:	Shuah Khan <shuah@kernel.org>
> > > +M:	Shuah Khan <skhan@linuxfoundation.org>
> > >   L:	linux-kselftest@vger.kernel.org
> > >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> > >   Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
> > > @@ -15842,6 +15844,7 @@ F:	drivers/usb/common/usb-otg-fsm.c
> > >   USB OVER IP DRIVER
> > >   M:	Valentina Manea <valentina.manea.m@gmail.com>
> > >   M:	Shuah Khan <shuah@kernel.org>
> > > +M:	Shuah Khan <skhan@linuxfoundation.org>
> > >   L:	linux-usb@vger.kernel.org
> > >   S:	Maintained
> > >   F:	Documentation/usb/usbip_protocol.txt
> > > -- 
> > > 2.17.1
> > > 
> > 
> > I can take this through my USB tree as 1/3 of these entries come from
> > there, unless you want to take it through your kselftest tree?  If so,
> > feel free to add my:
> > 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > to it.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Greg,
> 
> Please go ahead and take this through USB tree.

Ok, will queue it up today, thanks.

greg k-h
