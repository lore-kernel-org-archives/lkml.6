Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeEGUDQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:03:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeEGUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:03:14 -0400
Date: Mon, 07 May 2018 16:03:10 -0400 (EDT)
Message-Id: <20180507.160310.1980287981944658521.davem@davemloft.net>
To: rahul.lakkireddy@chelsio.com
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v8 0/3] kernel: add support to collect
 hardware logs in crash recovery kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
References: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Date: Wed,  2 May 2018 15:17:16 +0530

> This series of patches add new generic framework that enable device
> drivers to collect device specific snapshot of the hardware/firmware
> state of the underlying device in the crash recovery kernel. In crash
> recovery kernel, the collected logs are added as elf notes to
> /proc/vmcore, which is copied by user space scripts for post-analysis.

Eric B., since you've been giving very useful and active feedback on
this series could you please give it a review?

Thank you.
