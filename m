Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeCTREV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:04:21 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57115 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752211AbeCTREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:04:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=qixuan.wu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SznUFD6_1521565448;
Message-ID: <5AB13ECE.2090005@linux.alibaba.com>
Date: Wed, 21 Mar 2018 01:03:10 +0800
From: Qixuan Wu <qixuan.wu@linux.alibaba.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
CC: linux-kernel@vger.kernel.org
Subject: About dmesg time and uptime
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

   I have a doubt in kernel 4.9 about dmesg time and uptime. Would you
please to help to clarify whether it's bug or not.
   Below is our log. The dmesg time second is large than uptime second.

[25049978.919097] bond0.700: port 9(veth4e77160) entered forwarding state
[25049978.926455] bond0.700: port 9(veth4e77160) entered forwarding state
[chenggang.qcg@e80g10383 ~]$ cat /proc/uptime
25023128.55 1416627078.34

   I found dmesg second is just directly get from tsc (x86 64 platform).
While the uptime is get by a complicated computation.

   In my another board running 4.9, uptime is very large than dmesg
second (about 8000 second).

Thanks & Regards
Qixuan Wu
