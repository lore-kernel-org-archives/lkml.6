Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA79FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8731B20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfBVKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:13:23 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:59811 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfBVKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:13:23 -0500
Received: by mail-it1-f199.google.com with SMTP id m136so1475692ita.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 02:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=UZlpPAw14wBFJEx/jiv0qgqpiTBjtMRyan7yaYv6MxrxwMEKeWL+58AMj73Dh2oeeV
         ygufgv5pQIsdVucvPwUutCDwa+N3/6+Gp4iIpLf3MZ+bv1j95SGNrF4OvuvTkIai1+iz
         uAz6QuEvDqj8OjiVojY8VbbUzmeuEAtQGRkHApu17mkhDAqMn2K/ytcKZrj7huoGJ7AQ
         y3eAdOAwJJQ3y2I2FdY36HqufHGtUyravLrdSQouXTteO7R+uJmZO/Sa6mHAtnUHuNF2
         XuIiUQfM1tNv34gvdYLtBfutU5gMXrRw7LowEP4JW0tkjZaCAtZ7/Mp9vdozY5lM5omD
         oJWA==
X-Gm-Message-State: AHQUAubYj+oiAaBWnNupDYtSNCZ+COIguzmFBwcOiXNQHNXetXq9i3jw
        +AXlyTJ9rL+xyAjdhaelSgiqH3ixuYOIEmP9Xnm8kNndLGsL
X-Google-Smtp-Source: AHgI3Ia/t6OJWn6+AcwSxFNOidotVm21bPoap04x82AEc9vZHJuh1Kk3nUfGLDTSDIkKMq2KId+xHuLwNSXAS72Vjp1EGN6ohrcI
MIME-Version: 1.0
X-Received: by 2002:a24:1c0c:: with SMTP id c12mr1846733itc.19.1550830402199;
 Fri, 22 Feb 2019 02:13:22 -0800 (PST)
Date:   Fri, 22 Feb 2019 02:13:22 -0800
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003aeb52058278d758@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
From:   syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
vfs: namespace: error pointer dereference in do_remount()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
