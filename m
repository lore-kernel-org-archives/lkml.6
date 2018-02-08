Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeBHVEv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:04:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751700AbeBHVEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:04:50 -0500
Date: Thu, 08 Feb 2018 16:04:48 -0500 (EST)
Message-Id: <20180208.160448.186357541261251073.davem@redhat.com>
To: keescook@chromium.org
Cc: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiggers3@gmail.com, james.morse@arm.com, keun-o.park@darkmatter.ae,
        labbott@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH] net: Whitelist the skbuff_head_cache "cb" field
From: David Miller <davem@redhat.com>
In-Reply-To: <CAGXu5jJsmECUtyXBJb60o_Ve3PTUw8pkyaH2=SFHSxHy1vjsmA@mail.gmail.com>
References: <20180208014438.GA12186@beast>
        <20180208.151621.581060088482890871.davem@davemloft.net>
        <CAGXu5jJsmECUtyXBJb60o_Ve3PTUw8pkyaH2=SFHSxHy1vjsmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Feb 2018 08:01:12 +1100

> Cool, thanks. And just to be clear, if it's not already obvious, this
> patch needs kmem_cache_create_usercopy() which just landed in Linus's
> tree last week, in case you've not merged yet.

Understood, and 'net' has it.
