Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00208C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7AF218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfAaLfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:35:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:40260 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaLfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:35:04 -0500
Received: by mail-it1-f200.google.com with SMTP id 135so2216905itk.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OOVKRl0kmwYYGsMMVLfAGRAgoSRWlW/vz12qgCCQqSY=;
        b=OvN3OzIIqos6ebAwS5yNoefYn4rQwqeSgqPW7AzrYCeOWNCDwCXyMwCBPEEZOWmBRa
         5Py0LRocxUZDaw9IoLSxakjvxRTFFWSkVx1cAjJ42NzUXNcWwc7DEndy04M2Sg565Esc
         MXWBIZ4DqbK3mwCNUlFQIZYG0yJh6IPnZxIPtbrOx5Xz8SyK7naMX2mGWfZjnzQByedg
         HWBsfEAGiLGwn1HsAPmQWICd+xUBjzyvkspwimBGkRAiqinxl44QnmHDxcFg4umOO012
         zUUnU2/xEmyKDK9kJOHKSULk4e20hIQodTkZQGToAmp8bkKYDc2+o577PQen1R+HOvIT
         /8BQ==
X-Gm-Message-State: AHQUAubmho7ccE3T8xQAwJWRyiQs1+cot+ecKsLTvNkGH3t5mT6TZ0qz
        H3V2bG0CFjXLYMMbJ4+GAES6zjPzkpTEJYaiO5iyeAsSgak2
X-Google-Smtp-Source: AHgI3IbzE8o9NOkuxPtdpp3eKHNzEoun/GkaeuCBYbEVh9I51c6VDD9T8cz8Qinu2U3E2XGv9NUSZ2mQ5IEFEH7hoIJGG1+AkTb6
MIME-Version: 1.0
X-Received: by 2002:a24:7a05:: with SMTP id a5mr9725896itc.30.1548934503099;
 Thu, 31 Jan 2019 03:35:03 -0800 (PST)
Date:   Thu, 31 Jan 2019 03:35:03 -0800
In-Reply-To: <CACT4Y+ZtG6Ef4vRApPuZsG0pquCV94Hg0KYBxpgpQueaG8STHA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d671490580bf6a53@google.com>
Subject: Re: general protection fault in relay_open_buf
From:   syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, ebiggers@google.com,
        gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com

Tested on:

commit:         af0c9af1b3f6 fs/dcache: Track & report number of negative ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3495238483eab50f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166d48df400000

Note: testing is done by a robot and is best-effort only.
