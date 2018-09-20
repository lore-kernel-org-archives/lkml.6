Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F71C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62398206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62398206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbeITTXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:23:47 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42021 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732441AbeITTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:23:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1066463|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.CtSoGPG_1537450808;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtSoGPG_1537450808)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 20 Sep 2018 21:40:08 +0800
Date:   Thu, 20 Sep 2018 21:40:07 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH] MAINTAINERS: Add csky
Message-ID: <20180920134007.GA28578@guoren-Inspiron-7460>
References: <1537438447-24631-1-git-send-email-ren_guo@c-sky.com>
 <20180920101743.GA19885@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920101743.GA19885@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:17:43PM +0200, Greg KH wrote:
> On Thu, Sep 20, 2018 at 06:14:07PM +0800, Guo Ren wrote:
> > Add a maintainer information for the csky(C-SKY) architecture.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d870cb5..6b7c1be 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3211,6 +3211,22 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
> >  S:	Maintained
> >  F:	sound/pci/oxygen/
> >  
> > +C-SKY ARCHITECTURE
> > +M:	Guo Ren <ren_guo@c-sky.com>
> > +T:	git https://github.com/c-sky/csky-linux.git
> > +S:	Supported
> > +F:	arch/csky/
> 
> Shouldn't this patch be part of the original patch series for the csky
> port?  No need to put it separate.
Ok, I'll put it into my patch series and not seperate it.

Best Regards
 Guo Ren

