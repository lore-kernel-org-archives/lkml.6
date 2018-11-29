Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D73AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED00420868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED00420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeK3CNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:13:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:14990 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbeK3CNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:13:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 07:08:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="113561300"
Received: from isister-mobl.amr.corp.intel.com ([10.255.76.222])
  by orsmga002.jf.intel.com with ESMTP; 29 Nov 2018 07:08:05 -0800
Message-ID: <b98fdad2b1fab93132e8535e5589eacfcf02a00c.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/12] tracing: Unifying dynamic event interface
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date:   Thu, 29 Nov 2018 09:08:05 -0600
In-Reply-To: <20181129142049.9404dcc0f74d65c9c129d13c@kernel.org>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
         <20181128163101.d86844338bcba3fc3b0580f1@kernel.org>
         <ff8ca3062cad3747a664e6888790cc3c58e24c7e.camel@linux.intel.com>
         <20181129142049.9404dcc0f74d65c9c129d13c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, 2018-11-29 at 14:20 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 28 Nov 2018 17:42:22 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Hi Masami,
> > 
> > On Wed, 2018-11-28 at 16:31 +0900, Masami Hiramatsu wrote:
> > > Ping?
> > > 
> > > Hi Tom,
> > > 
> > > This series, especially [09/12] tracing: Remove unneeded
> > > synth_event_mutex
> > > will effect your current working series. Please tell me your
> > > opinion.
> > > 
> > 
> > Sorry for the delay in reviewing this - I completely forgot about
> > it in
> > my inbox.
> > 
> > It's all very nice, and the mutex updates along with the dyn_event
> > management make that part of the code much cleaner, thanks!
> > 
> > In any case, you can have my
> > 
> > Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Thank you!
> And as I pointed, synth_event_mutex is removed by this series, it may
> affect your hist trigger series too. 
> 

Yes, thanks for pointing that out - I'll rebase mine on top of this.

Tom


