Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeFEPTx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:19:53 -0400
Received: from ozlabs.org ([203.11.71.1]:41543 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752037AbeFEPTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:19:39 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2e5c93d6bb2f7bc17eb82748943a1b9f6b068520
In-Reply-To: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
To: Wei Yongjun <weiyongjun1@huawei.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alastair D'Silva" <alastair@d-silva.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [-next] ocxl: Fix missing unlock on error in afu_ioctl_enable_p9_wait()
Message-Id: <410b7r1h68z9s2k@ozlabs.org>
Date: Wed,  6 Jun 2018 01:19:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 09:16:21 UTC, Wei Yongjun wrote:
> Add the missing unlock before return from function
> afu_ioctl_enable_p9_wait() in the error handling case.
> 
> Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Alastair D'Silva <alastair@d-silva.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2e5c93d6bb2f7bc17eb82748943a1b

cheers
