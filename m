Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeFDOLd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:11:33 -0400
Received: from ozlabs.org ([203.11.71.1]:38369 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDOLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:31 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0abbf2bfdc9dec32e9832aa8d4522a57d698e753
In-Reply-To: <1527765086-19873-21-git-send-email-xieyisheng1@huawei.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, <linux-kernel@vger.kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, andy.shevchenko@gmail.com,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,20/21] powerpc/xmon: use match_string() helper
Message-Id: <40zxgj5Kw4z9s1B@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:28 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 11:11:25 UTC, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0abbf2bfdc9dec32e9832aa8d4522a

cheers
