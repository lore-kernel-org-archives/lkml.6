Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeFAQ36 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:29:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752934AbeFAQ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:29:57 -0400
Date: Fri, 1 Jun 2018 18:29:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 04/17] signal: make do_sigpending() void
Message-ID: <20180601162954.GF1058@redhat.com>
References: <20180601132239.4421-1-christian@brauner.io>
 <20180601132239.4421-5-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601132239.4421-5-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Christian Brauner wrote:
>
> do_sigpending() returned 0 unconditionally so it doesn't make sense to have
> it return at all. This allows us to simplify a bunch of syscall callers.

Agreed, ACK
