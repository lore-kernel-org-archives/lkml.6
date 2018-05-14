Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeENNil (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeENNii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:38:38 -0400
Date: Mon, 14 May 2018 22:38:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [PATCH 01/18] kernel: Use pr_fmt
Message-Id: <20180514223833.f3c2224e458e89949d3042d4@kernel.org>
In-Reply-To: <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
        <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 08:45:27 -0700
Joe Perches <joe@perches.com> wrote:

> Sometime in the future, it would be useful to convert pr_fmt from a
> default simple define to use a default prefix with KBUILD_MODNAME.
> 
> There are files in kernel/ that use pr_<level>, some with an embedded
> prefix, that also do not have a specific pr_fmt define.
> 
> Add pr_fmt for those files.
> 
> There are some differences in output as some messages are now prefixed
> with their KBUILD_MODNAME.
> 
> Miscellanea:
> 
> o Align multiline statements to open parenthesis
> o Wrap and realign arguments to 80 columns where sensible
> o Coalesce formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Kprobes part looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
