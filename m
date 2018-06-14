Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 738E0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E6A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E6A208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeFNJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:45:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:52588 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754708AbeFNJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:45:20 -0400
Received: from [178.197.249.11] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fTOog-0005QZ-6z; Thu, 14 Jun 2018 11:45:18 +0200
Subject: Re: WARNING in bpf_prog_select_runtime
To:     syzbot <syzbot+3b889862e65a98317058@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000556929056e952ae0@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6c60569d-50c4-14ac-93db-15e761cf7d60@iogearbox.net>
Date:   Thu, 14 Jun 2018 11:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000556929056e952ae0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24661/Thu Jun 14 06:40:37 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 09:37 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ee946c36be21 Merge tag 'platform-drivers-x86-v4.17-2' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ca275b800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=889265cebaf9bda1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3b889862e65a98317058
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17530b5b800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3b889862e65a98317058@syzkaller.appspotmail.com

Will submit a fix for this today.
