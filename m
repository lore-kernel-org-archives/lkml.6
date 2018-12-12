Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F0C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEBE20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEBE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeLLVBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:01:08 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:29775 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLLVBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:01:07 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBCL15pu032478;
        Thu, 13 Dec 2018 06:01:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 13 Dec 2018 06:01:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBCL15Pn032475
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 13 Dec 2018 06:01:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_mount (2)
To:     syzbot <syzbot+5751b57c82cd229ffbee@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <0000000000004a25cc057cd65aad@google.com>
Cc:     akpm@linux-foundation.org, amir73il@gmail.com,
        darrick.wong@oracle.com, david@fromorbit.com, hannes@cmpxchg.org,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <240fff25-0288-a0e6-a018-2e1593afc228@I-love.SAKURA.ne.jp>
Date:   Thu, 13 Dec 2018 06:01:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <0000000000004a25cc057cd65aad@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stalling inside __getblk_gfp()...

#syz dup: INFO: rcu detected stall in sys_creat

