Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499AA20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499AA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeK1DIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:08:19 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36519 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeK1DIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:08:19 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gRfvu-0002uu-OT; Tue, 27 Nov 2018 09:09:54 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gRfu8-0004Jo-Cb; Tue, 27 Nov 2018 09:09:54 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        manfred@colorfullife.com, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in freeary
References: <0000000000004eade9057ba76eae@google.com>
Date:   Tue, 27 Nov 2018 10:07:53 -0600
In-Reply-To: <0000000000004eade9057ba76eae@google.com> (syzbot's message of
        "Tue, 27 Nov 2018 07:52:03 -0800")
Message-ID: <87d0qqjyg6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gRfu8-0004Jo-Cb;;;mid=<87d0qqjyg6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cXWga0qtpWa3KJpTXZM7Dd/T+3kN+bgk=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on in02.mta.xmission.com); SA Timed out after 110 secs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> dashboard link: https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

I don't have this commit.  I don't have a clue where it find this
commit.  I can't possibly look into this let alone debug this.

That is not a useful but report.  Please fix your bot.

Eric


