Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A8422419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A8422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeKOSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:06:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34369 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:06:41 -0500
Received: by mail-vs1-f66.google.com with SMTP id y27so11201497vsi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i20C0xmyPMlO06G+9sXE07nm8g7Bo2ErRitswHLva/8=;
        b=CJaw9lccSSkb6VPS7+Zw0O3gM7kPayD48i7mewVO0v+7G8hqUJ/53HMXf+VAUaMwv0
         1y5LW21O0hhIfnRIrNDqIBd35omjThOoJylY8nkNpoR955fZvq0mFKMWas2/s03y4OOr
         dRFCyWM+eXzxUqxf4n+S0OkzyV+P/dJgILS8R0vFjEzjm4MMC8madwWOVPKUokBNvHMi
         B/XABpAFqczisGcJWond1UGAR0M4dIpBYt60Y5HmYMZMfpA+K2QQoTQoPgykw7WSxP/x
         Uj9FIyV1YmqOekmsiHyYYDJ5qJUARcudtnLegDukB7JYorxDzCfw/ft5ZSUyURdMqHHG
         pVqg==
X-Gm-Message-State: AGRZ1gL7MvRgPUQsZINlJGX1L3AJS3Z87fO3C5CKLiARKiuD+6LSFOpv
        XiX5XY3/xx+tUZyckHDp5niPS3O9CSy+qkmZUxM=
X-Google-Smtp-Source: AJdET5fyLLi5gq+en8eiYHuGrOlKz+bVlarp9/QdEKlIMT8lG1lIuAH7hlhTGTYWarBTbryNqgIkaFMvOSWvJAXJpy0=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2040011vsj.11.1542268795132;
 Wed, 14 Nov 2018 23:59:55 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <alpine.DEB.2.21.1811142146230.9620@hadrien>
In-Reply-To: <alpine.DEB.2.21.1811142146230.9620@hadrien>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Nov 2018 08:59:43 +0100
Message-ID: <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stfrench@microsoft.com, Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Thu, Nov 15, 2018 at 6:48 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Wed, 14 Nov 2018, Dan Williams wrote:
> > As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> > Profile is proposed as a way to reduce friction between committers and
> > maintainers and perhaps encourage conversations amongst maintainers
> > about best practice policies.
> >
> > The profile contains short answers to some of the common policy
> > questions a contributor might have, or that a maintainer might consider
> > formalizing. The current list of maintenance policies is:
> >
> > Overview: General introduction to maintaining the subsystem
> > Core: List of source files considered core
> > Leaf: List of source files that consume core functionality
> > Patches or Pull requests: Simple statement of expected submission format
> > Last -rc for new feature submissions: Expected lead time for submissions
> > Last -rc to merge features: Deadline for merge decisions
> > Non-author Ack / Review Tags Required: Patch review economics
> > Test Suite: Pass this suite before requesting inclusion
> > Resubmit Cadence: When to ping the maintainer
> > Trusted Reviewers: Help for triaging patches
> > Time Zone / Office Hours: When might a maintainer be available
> > Checkpatch / Style Cleanups: Policy on pure cleanup patches
> > Off-list review: Request for review gates
> > TODO: Potential development tasks up for grabs, or active focus areas
>
> How about patch subject lines?  What is the formula that should be used to
> transform the name(s) of the affected file(s) into an appropriate suject
> line?

Automating that may be difficult.
I always use "git log --oneline", and try to derive something sane
from its output.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
