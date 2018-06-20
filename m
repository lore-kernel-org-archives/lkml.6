Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28033C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F3D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F3D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbeFTQVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:21:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754318AbeFTQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:21:41 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99CC2CB2;
        Wed, 20 Jun 2018 16:21:40 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:21:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2] kernel/hung_task.c: allow to set checking interval
 separately from timeout
Message-Id: <20180620092139.37276f2e21758b60ac69881c@linux-foundation.org>
In-Reply-To: <CACT4Y+YN-EPuFc2br+XPRZRcwn=Lxizd3LjTV=7wh_pboMnNCg@mail.gmail.com>
References: <20180611111004.203513-1-dvyukov@google.com>
        <20180619160327.b6ca2389401f421116c155ad@linux-foundation.org>
        <CACT4Y+YN-EPuFc2br+XPRZRcwn=Lxizd3LjTV=7wh_pboMnNCg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 07:23:49 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:

> > I suppose we shoold do this:
> 
> 
> Hi Andrew,
> 
> I see you added the patch and fixup to mm tree. Do you want me to
> resend v3 with the fixup included, or how does this work?

Is OK.  I queued both patches and shall consolidate them into a single
one prior to sending upstream to Linus.

