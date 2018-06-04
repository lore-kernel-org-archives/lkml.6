Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeFDOKu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:50 -0400
Received: from ozlabs.org ([203.11.71.1]:35251 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbeFDOKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:46 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 589b1f7e4b0db4c31cef3b55f7514857bfc4b093
In-Reply-To: <20180425112707.16392-1-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <geoff@infradead.org>, <joe@perches.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc/xics: add missing of_node_put() in error path
Message-Id: <40zxfr2Pzrz9s4Y@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:41 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 11:27:07 UTC, YueHaibing wrote:
> The device node obtained with of_find_compatible_node() should be
> released by calling of_node_put().  But it was not released when
> of_get_property() failed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/589b1f7e4b0db4c31cef3b55f75148

cheers
