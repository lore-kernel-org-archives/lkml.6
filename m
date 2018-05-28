Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162476AbeE1OPn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:15:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50314 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162177AbeE1OPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:15:40 -0400
Date: Mon, 28 May 2018 15:15:37 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, akpm@linux-foundation.org,
        oleg@redhat.com
Subject: Re: [PATCH 5/8] signal: flatten do_send_sig_info()
Message-ID: <20180528141537.GA30522@ZenIV.linux.org.uk>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-6-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528134916.7568-6-christian@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:49:13PM +0200, Christian Brauner wrote:
> Let's return early when lock_task_sighand() fails and move send_signal()
> and unlock_task_sighand() out of the if block.

Why is it an improvement?
