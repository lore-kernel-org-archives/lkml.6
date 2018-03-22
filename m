Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeCVJ1I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:27:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38924 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeCVJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:27:07 -0400
Date: Thu, 22 Mar 2018 10:27:04 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>,
        x86@kernel.org
Subject: Re: [PATCH 41/45] x86: remove compat_sys_x86_waitpid()
In-Reply-To: <20180322090059.19361-42-linux@dominikbrodowski.net>
Message-ID: <alpine.DEB.2.21.1803221026500.1579@nanos.tec.linutronix.de>
References: <20180322090059.19361-1-linux@dominikbrodowski.net> <20180322090059.19361-42-linux@dominikbrodowski.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018, Dominik Brodowski wrote:

> compat_sys_x86_waitpid() is not needed, as it takes the same parameters
> (int, *int, int) as the native syscall.
> 
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: x86@kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
