Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73504C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215DE251B6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215DE251B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeF3SHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:07:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeF3SHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:07:23 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3906E2D;
        Sat, 30 Jun 2018 18:07:22 +0000 (UTC)
Date:   Sat, 30 Jun 2018 11:07:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: /tmp/cctnQ1CM.s:35: Error: .err encountered
Message-Id: <20180630110720.c80f060abe6d163eef78e9a6@linux-foundation.org>
In-Reply-To: <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
References: <201806301538.bewm1wka%fengguang.wu@intel.com>
        <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018 12:27:09 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1904148a361a07fb2d7cba1261d1d2c2f33c8d2e
> > commit: 758517202bd2e427664857c9f2aa59da36848aca arm: port KCOV to arm
> > date:   2 weeks ago
> > config: arm-allmodconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 758517202bd2e427664857c9f2aa59da36848aca
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=arm
> >
> > All errors (new ones prefixed by >>):
> >
> >    /tmp/cctnQ1CM.s: Assembler messages:
> >>> /tmp/cctnQ1CM.s:35: Error: .err encountered
> >    /tmp/cctnQ1CM.s:36: Error: .err encountered
> >    /tmp/cctnQ1CM.s:37: Error: .err encountered
> 
> Hi kbuild test robot,
> 
> The fix was mailed more than a month ago, but still not merged into
> the tree. That's linux...

That was a rather unhelpful email.

I've just scanned all your lkml emails since the start of May and
cannot find anything which looks like a fix for this issue.

Please resend.   About three weks ago :(
