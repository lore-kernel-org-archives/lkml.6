Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934724AbeEWTYr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:24:47 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934667AbeEWTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:24:43 -0400
Date: Wed, 23 May 2018 15:24:40 -0400 (EDT)
Message-Id: <20180523.152440.915264101771444714.davem@davemloft.net>
To: christianvanbrauner@gmail.com
Cc: shuah@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        mic@digikod.net, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ebiederm@xmission.com,
        netdev@vger.kernel.org, christian@brauner.io
Subject: Re: [PATCH] selftests: uevent filtering
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522193421.7017-1-christian@brauner.io>
References: <20180522193421.7017-1-christian@brauner.io>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christianvanbrauner@gmail.com>
Date: Tue, 22 May 2018 21:34:21 +0200

> Recent discussions around uevent filtering (cf. net-next commit [1], [2],
> and [3] and discussions in [4], [5], and [6]) have shown that the semantics
> around uevent filtering where not well understood.
> Now that we have settled - at least for the moment - how uevent filtering
> should look like let's add some selftests to ensure we don't regress
> anything in the future.
> Note, the semantics of uevent filtering are described in detail in my
> commit message to [2] so I won't repeat them here.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=90d52d4fd82007005125d9a8d2d560a1ca059b9d
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a3498436b3a0f8ec289e6847e1de40b4123e1639
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=26045a7b14bc7a5455e411d820110f66557d6589
> [4]: https://lkml.org/lkml/2018/4/4/739
> [5]: https://lkml.org/lkml/2018/4/26/767
> [6]: https://lkml.org/lkml/2018/4/26/738
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Applied to net-next, thanks.
