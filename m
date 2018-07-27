Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B789C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3FD20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3FD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbeG0JDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:03:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:31220 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeG0JDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:03:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 00:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="57574611"
Received: from taolv-mobl.ccr.corp.intel.com ([10.249.169.42])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2018 00:42:47 -0700
Message-ID: <1532677364.2358.51.camel@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as designated reviewer for
 thermal
From:   Zhang Rui <rui.zhang@intel.com>
To:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 15:42:44 +0800
In-Reply-To: <20180726211237.GA3487@localhost.localdomain>
References: <1532600980-29357-1-git-send-email-daniel.lezcano@linaro.org>
         <20180726211237.GA3487@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 四, 2018-07-26 at 14:12 -0700, Eduardo Valentin wrote:
> On Thu, Jul 26, 2018 at 12:29:40PM +0200, Daniel Lezcano wrote:
> > 
> > I would like to participate in the review process effort for the
> > thermal framework, especially the SoC part.
> > 
> > Instead of capturing emails with message filters, I would like to
> > humbly add myself as reviewer so I can receive the patches directly
> > in
> > my INBOX and focus on their review.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> 
> Thanks for the help Daniel.
> 
> Rui, want to take care of this?
> 

yes, I will take this patch

thanks,
rui
> > 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0fe4228..1890aad 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14119,6 +14119,7 @@ F:	drivers/media/radio/radio-
> > raremono.c
> >  THERMAL
> >  M:	Zhang Rui <rui.zhang@intel.com>
> >  M:	Eduardo Valentin <edubezval@gmail.com>
> > +R:	Daniel Lezcano <daniel.lezcano@linaro.org>
> >  L:	linux-pm@vger.kernel.org
> >  T:	git
> > git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> >  T:	git
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > thermal.git
