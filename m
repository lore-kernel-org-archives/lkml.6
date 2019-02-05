Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3254C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673172083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfBEAIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:08:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBEAIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:08:05 -0500
Received: from X1 (c-24-6-103-156.hsd1.ca.comcast.net [24.6.103.156])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A41FA9AD2;
        Tue,  5 Feb 2019 00:08:04 +0000 (UTC)
Date:   Mon, 4 Feb 2019 16:08:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 03/13] kbuild: Raise the minimum required binutils
 version to 2.21
Message-Id: <20190204160803.cbb2a196652df40b6dff5220@linux-foundation.org>
In-Reply-To: <CALCETrVcY4VhOX5DG7dwoy6RgiQ3iZCZ_h_dXP_5RuuRuoChfQ@mail.gmail.com>
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
        <20190201205319.15995-4-chang.seok.bae@intel.com>
        <CALCETrVcY4VhOX5DG7dwoy6RgiQ3iZCZ_h_dXP_5RuuRuoChfQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 18:45:44 -0800 Andy Lutomirski <luto@kernel.org> wrote:

> On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
> > It helps to use some new instructions directly in inline assembly.
> 
> akpm, can you ack this patch?  AFAIK you are the only, or at least
> most vocal, user of ancient userspace to build new kernels.  Are you
> okay with this?

Acked-by: Andrew Morton <akpm@linux-foundation.org>

That little initiative got beaten into submission :(
