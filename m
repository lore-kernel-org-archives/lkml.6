Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeDXTy5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:54:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDXTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:54:54 -0400
Date: Tue, 24 Apr 2018 15:54:52 -0400 (EDT)
Message-Id: <20180424.155452.825338057383489874.davem@davemloft.net>
To: rahul.lakkireddy@chelsio.com
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v5 0/3] kernel: add support to collect
 hardware logs in crash recovery kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
References: <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Date: Sat, 21 Apr 2018 22:35:52 +0530

> Patch 1 adds API to vmcore module to allow drivers to register callback
> to collect the device specific hardware/firmware logs.  The logs will
> be added to /proc/vmcore as elf notes.
> 
> Patch 2 updates read and mmap logic to append device specific hardware/
> firmware logs as elf notes.
> 
> Patch 3 shows a cxgb4 driver example using the API to collect
> hardware/firmware logs in crash recovery kernel, before hardware is
> initialized.

Are there any serious remaining objections to this series?  I'm going to
integrate this into net-next soon if not.

Thank you.
