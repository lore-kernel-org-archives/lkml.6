Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeEUQes (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:34:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeEUQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:34:44 -0400
Date: Mon, 21 May 2018 12:34:41 -0400 (EDT)
Message-Id: <20180521.123441.1933324667176430245.davem@davemloft.net>
To: rahul.lakkireddy@chelsio.com
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next] vmcore: move get_vmcore_size out of __init
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526909870-27630-1-git-send-email-rahul.lakkireddy@chelsio.com>
References: <1526909870-27630-1-git-send-email-rahul.lakkireddy@chelsio.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Date: Mon, 21 May 2018 19:07:50 +0530

> Fix below build warning:
> 
> WARNING: vmlinux.o(.text+0x422bb8): Section mismatch in reference from
> the function vmcore_add_device_dump() to the function
> .init.text:get_vmcore_size.constprop.5()
> 
> The function vmcore_add_device_dump() references
> the function __init get_vmcore_size.constprop.5().
> This is often because vmcore_add_device_dump lacks a __init
> annotation or the annotation of get_vmcore_size.constprop.5 is wrong.
> 
> Fixes: 7efe48df8a3d ("vmcore: append device dumps to vmcore as elf notes")
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>

Applied, thank you.
