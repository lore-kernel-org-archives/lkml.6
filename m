Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F1CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D89B20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D89B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLFQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:58:05 -0500
Received: from ms.lwn.net ([45.79.88.28]:33760 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeLFQ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:58:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC2D82B6;
        Thu,  6 Dec 2018 16:58:00 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:57:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] Documentation/admin-guide: introduce
 perf-security.rst file
Message-ID: <20181206095755.2c2a0b6b@lwn.net>
In-Reply-To: <CAGXu5jJ_CyE5A2VUSyyi-uj4webfZM9ZOACp523p5xFhv1KCAQ@mail.gmail.com>
References: <feac7efa-df6f-cca1-e321-28d220bf0411@linux.intel.com>
        <b1a4fa08-482d-0fcc-c798-efb9a9894a47@linux.intel.com>
        <CAGXu5jJ_CyE5A2VUSyyi-uj4webfZM9ZOACp523p5xFhv1KCAQ@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 17:10:48 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Nov 27, 2018 at 12:15 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
> >
> >
> > Implement initial version of perf-security.rst documentation file
> > covering security concerns of perf_event_paranoid settings.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>  
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

OK, series applied, thanks.

jon
