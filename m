Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E74C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065CB214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065CB214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeHUFZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:25:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:21521 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeHUFZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:25:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 19:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="83062121"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.96])
  by fmsmga001.fm.intel.com with SMTP; 20 Aug 2018 19:07:53 -0700
Received: by ubuntu (sSMTP sendmail emulation); Tue, 21 Aug 2018 10:07:54 +0800
Message-ID: <1534817274.25697.0.camel@intel.com>
Subject: Re: [PATCH] nios2: kconfig: remove duplicate DEBUG_STACK_USAGE
 symbol defintions
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>,
        nios2-dev@lists.rocketboards.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Aug 2018 10:07:54 +0800
In-Reply-To: <CAK7LNASB3RQV=_PbB-RsN3akebnBzc+RbfiyrvfishZfhcTUVQ@mail.gmail.com>
References: <20180816070518.10441-1-tklauser@distanz.ch>
         <CAK7LNASB3RQV=_PbB-RsN3akebnBzc+RbfiyrvfishZfhcTUVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 01:15 +0900, Masahiro Yamada wrote:
> 2018-08-16 16:05 GMT+09:00 Tobias Klauser <tklauser@distanz.ch>:
> > 
> > DEBUG_STACK_USAGE is already defined in lib/Kconfig.debug
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> 
> > 
> > ---
> >  arch/nios2/Kconfig.debug | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> > index 7a49f0d28d14..f1da8a7b17ff 100644
> > --- a/arch/nios2/Kconfig.debug
> > +++ b/arch/nios2/Kconfig.debug
> > @@ -3,15 +3,6 @@
> >  config TRACE_IRQFLAGS_SUPPORT
> >         def_bool y
> > 
> > -config DEBUG_STACK_USAGE
> > -       bool "Enable stack utilization instrumentation"
> > -       depends on DEBUG_KERNEL
> > -       help
> > -         Enables the display of the minimum amount of free stack
> > which each
> > -         task has ever had available in the sysrq-T and sysrq-P
> > debug output.
> > -
> > -         This option will slow down process creation somewhat.
> > -
> >  config EARLY_PRINTK
> >         bool "Activate early kernel debugging"
> >         default y
> > --
> > 2.18.0.130.g98da2f6b3e4a
> > 
> > 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
