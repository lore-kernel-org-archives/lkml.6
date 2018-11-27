Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8828C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925EA20660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925EA20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeK1DVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:21:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:32938 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbeK1DVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:21:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 08:22:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="94776165"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2018 08:22:45 -0800
Date:   Tue, 27 Nov 2018 08:22:45 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, arnd@arndb.de, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        manfred@colorfullife.com, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in freeary
Message-ID: <20181127162244.GC27075@linux.intel.com>
References: <0000000000004eade9057ba76eae@google.com>
 <87d0qqjyg6.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0qqjyg6.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:07:53AM -0600, Eric W. Biederman wrote:
> 
> 
> syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com> writes:
> 
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> I don't have this commit.  I don't have a clue where it find this
> commit.  I can't possibly look into this let alone debug this.

It's in v4.20-rc4.

> 
> That is not a useful but report.  Please fix your bot.
> 
> Eric
> 
> 
