Date: Thu, 15 Mar 2018 17:43:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
	torvalds@linux-foundation.org, mingo@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>,
	x86@kernel.org
Subject: Re: [RFC PATCH 13/35] syscalls: do not call sys_ioperm() within the
 kernel
Message-ID: <20180315164324.GA4060@kroah.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-14-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311105557.20807-14-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 11:55:35AM +0100, Dominik Brodowski wrote:
> While at it, use SYSCALL_DEFINE3() instead of a hand-crafted syscall
> definition.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Jiri Slaby <jslaby@suse.com>
> CC: x86@kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  arch/x86/include/asm/syscalls.h | 1 +
>  arch/x86/kernel/ioport.c        | 7 ++++++-
>  drivers/tty/vt/vt_ioctl.c       | 6 +++---
>  3 files changed, 10 insertions(+), 4 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
