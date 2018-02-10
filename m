Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeBJSDz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:03:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52844 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeBJSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:03:54 -0500
Date: Sat, 10 Feb 2018 18:03:52 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
Message-ID: <20180210180352.GO30522@ZenIV.linux.org.uk>
References: <20180210165845.18852-1-metux@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210165845.18852-1-metux@gmx.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 04:58:45PM +0000, Enrico Weigelt, metux IT consult wrote:
> From: "Enrico Weigelt, metux IT consult" <info@metux.net>

> +MODULE_LICENSE("GPLv3");

... which is incompatible with GPLv2.  I'm not even going to look at that
thing - same as with proprietary code.  You CAN'T combine any derivatives
of that code with the kernel.  Not without GPL violation.

And yes, there is GPLv2-only code all over the place in Linux VFS (at
least), with at least some of the copyright holders not going to permit
violations of clause 6.  Not going to happen.

If you want it in the kernel, you need a GPLv2-compatible license.  GPLv3
does not qualify, and while it can be combined with GPLv2+ (yielding GPLv3
for combination), the kernel is not GPLv2+ - some parts are, but GPLv2-only
ones render the whole thing GPLv2-only.
