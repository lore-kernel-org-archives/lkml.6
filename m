Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFBB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBNXES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:04:18 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:44349 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfBNXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:04:16 -0500
Received: by mail-it1-f200.google.com with SMTP id v12so3615290itv.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=S+wxCikyHmiPG7+dd6WQXhK11mhOzXGLxdPZBMXqBBg=;
        b=aROtt4tdgnmHx3OxrqBsX5CYlZ+CRPKveWJHjp6KKRXljkfwPUAcYnpO7jiyhC19iD
         WRfyCTnedYjZ3dw14M9ED54J8H4qM8ViLl61jpBrD1hsLffkCGG1rmZQV5PgIFBPk4Tg
         4SJFf0EWh+HnlDYwl8HRHr4kPvFR4uRWgJaqMJuS2r3YKvAISlOGII0VXJ8/fm21OpdE
         HoE9/dZGrG7JrrvAI8ytKmBfE+KBAsWg7lwTezKfFVhm0H7ef8hnLAAa/NDdDElD5/Dc
         CtjFuPqQfhAvf8vx0PDg6hgyjP5+VD2bSW/A1awpSYo5RxseS7T7fnHwd54Hs3BZhomS
         FoCw==
X-Gm-Message-State: AHQUAuZj4N14zuEHQm1Xm5KsOcfhIswfg4Ia+L3W03nDAn0D6VAR7ion
        b316tN0AA6+D0UO8yIFGW34liKnUcsZNsqgrvanHNsbMIWcK
X-Google-Smtp-Source: AHgI3IYGIBFsM16yT/OpTFoF1WfTLkyYYgxAiR6940RZGHjd4RwPWLb50/+SX2ia3FQp3y6vt9Tnn2d0WkeOpyEslZJspv+9N4mg
MIME-Version: 1.0
X-Received: by 2002:a24:6283:: with SMTP id d125mr2177293itc.14.1550185455801;
 Thu, 14 Feb 2019 15:04:15 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:04:15 -0800
In-Reply-To: <CAHRSSEyYx8XLgn+6Vb-a_icEn1xZUKh8=dHTjCHK=6y38gUX6A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ddd8c0581e2ad9d@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
From:   syzbot <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, syzkaller-bugs@googlegroups.com,
        tkjos@android.com, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com

Tested on:

commit:         b3418f8bddf4 Add linux-next specific files for 20190214
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139c8f50c00000

Note: testing is done by a robot and is best-effort only.
