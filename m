Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeCaOEL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:04:11 -0400
Received: from ozlabs.org ([103.22.144.67]:56723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbeCaOEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:04:10 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9a2c1d31e6910b9d5e0205f9167d0b1abeea1413
In-Reply-To: <1522075389-23511-1-git-send-email-weiyongjun1@huawei.com>
To: Wei Yongjun <weiyongjun1@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Rob Herring <robh@kernel.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [-next] powerpc: Fix error return code in ppc4xx_msi_probe()
Message-Id: <40D0bD5FH1z9s3q@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:08 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 14:43:09 UTC, Wei Yongjun wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9a2c1d31e6910b9d5e0205f9167d0b

cheers
