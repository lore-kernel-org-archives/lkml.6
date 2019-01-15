Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B48C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121DF20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbfAORmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:42:21 -0500
Received: from namei.org ([65.99.196.166]:56156 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfAORmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:42:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0FHgF2c004256;
        Tue, 15 Jan 2019 17:42:15 GMT
Date:   Wed, 16 Jan 2019 04:42:15 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com>
Subject: Re: [PATCH] seccomp: fix UAF in user-trap code
In-Reply-To: <CAGXu5jJKeO_-Vy5sffQugBKy4z1W7KGwUAySz=MN9ZvMsYqKFw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1901160442030.3929@namei.org>
References: <CAGXu5j+9ETYcavj2x3Up0FhvkopZohbJcS4CMvrrCWOwDurSFw@mail.gmail.com> <20190112182420.4669-1-tycho@tycho.ws> <CAGXu5jJKeO_-Vy5sffQugBKy4z1W7KGwUAySz=MN9ZvMsYqKFw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019, Kees Cook wrote:

> This makes sense to me. Thanks for fixing it!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> James, can you add this to your fixes tree for sending to Linus?

Sure.

-- 
James Morris
<jmorris@namei.org>

