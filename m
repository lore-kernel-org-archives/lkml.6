Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeCLH3X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:29:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38739 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeCLH3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:29:21 -0400
X-Google-Smtp-Source: AG47ELsYjbZ8N9TNrXJw/ZTTdvsiKhV1hSbAlF1mmiU4YuC6v2dX+nBPERsVOuurKfLs8dhXlblRxA==
Date: Mon, 12 Mar 2018 08:29:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, "Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC PATCH 02/35] syscalls: use kernel_wait4() instead of
 sys_wait4()
Message-ID: <20180312072918.nac7orkrcwqzabf4@gmail.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311105557.20807-3-linux@dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> All call sites of sys_wait4() set *rusage to NULL. Therefore, there is
> no need for the copy_to_user() handling of *rusage, and we can use
> kernel_wait4() directly.
> 
> CC: Luis R. Rodriguez <mcgrof@kernel.org>
> CC: Al Viro <viro@zeniv.linux.org.uk>
> CC: Andrew Morton <akpm@linux-foundation.org>

Could you please fix the Cc: tags in all your patches, the canonical form is:

 s/CC:/Cc:

Thanks,

	Ingo
