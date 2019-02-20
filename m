Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EA320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfBTKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:54:10 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:42101 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:54:09 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1KAqmng017000;
        Wed, 20 Feb 2019 19:52:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Wed, 20 Feb 2019 19:52:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1KAqhoc016965
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Feb 2019 19:52:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: possible deadlock in console_unlock
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
 <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
 <20180615083804.GB8964@jagdpanzerIV>
 <20180619080412.zkdanx6bmq5qm3dz@pathway.suse.cz>
 <20180619080812.GC405@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <beaa0c78-362d-c4b7-d381-1e74c302c439@I-love.SAKURA.ne.jp>
Date:   Wed, 20 Feb 2019 19:52:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20180619080812.GC405@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FTR, this topic seems to be moved to
https://lkml.kernel.org/r/ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com .
