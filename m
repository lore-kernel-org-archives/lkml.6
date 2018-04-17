Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeDQFYu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:24:50 -0400
Received: from namei.org ([65.99.196.166]:57506 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeDQFYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:24:49 -0400
Date: Tue, 17 Apr 2018 15:24:41 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Sargun Dhillon <sargun@sargun.me>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, casey@schaufler-ca.com
Subject: Re: [PATCH] security: remove security_settime
In-Reply-To: <20180401084205.GA14512@ircssh-2.c.rugged-nimbus-611.internal>
Message-ID: <alpine.LRH.2.21.1804171524190.5681@namei.org>
References: <20180401084205.GA14512@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2018, Sargun Dhillon wrote:

> security_settime was a wrapper around security_settime64. There are no more
> users of it. Therefore it can be removed. It was removed in:
> commit 4eb1bca17933 ("time: Use do_settimeofday64() internally")
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing

-- 
James Morris
<jmorris@namei.org>
