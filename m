Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DD620882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DD620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeGIKLQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:11:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:34387 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932427AbeGIKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:11:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 03:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="244099043"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2018 03:11:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com>,
        acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in _free_event
In-Reply-To: <000000000000ccdf0605708a9ccc@google.com>
References: <000000000000ccdf0605708a9ccc@google.com>
Date:   Mon, 09 Jul 2018 13:11:11 +0300
Message-ID: <87y3ekafcw.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=178cf50c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=a24c397a29ad22d86c98
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.

Is there a chance of getting a reproducer for this one?

Thanks,
--
Alex
