Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399B92146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399B92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeLFDng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbeLFDng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:43:36 -0500
Received: from vmware.local.home (unknown [184.48.106.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5BE213A2;
        Thu,  6 Dec 2018 03:43:35 +0000 (UTC)
Date:   Wed, 5 Dec 2018 22:43:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Message-ID: <20181205224333.3c589916@vmware.local.home>
In-Reply-To: <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
References: <20181130150859.27366-1-anders.roxell@linaro.org>
        <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
        <20181205212651.488d9cd4@vmware.local.home>
        <20181205212945.58edee31@vmware.local.home>
        <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 19:29:11 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Dec 5, 2018 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 5 Dec 2018 21:26:51 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > On Wed, 5 Dec 2018 17:08:34 -0800
> > > Kees Cook <keescook@chromium.org> wrote:
> > >  
> >  
> > > I'll Ack the Makefile
> > > change in the tracing directory, but the rest belongs to others.  
> 
> Okay, I wasn't sure. Anders's patch was marked "1/3" so I thought it
> was directed at you. :)
> 
> I'll grab this one in the gcc-plugins tree.

Should I just take patch 2 then? I'm thinking it's independent too.

I'm collecting patches for the next merge window right now so it wont
really be an issue if I do.

-- Steve
