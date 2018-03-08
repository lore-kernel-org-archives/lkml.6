Date: Thu, 8 Mar 2018 09:15:26 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
	tglx@linutronix.de, torvalds@linux-foundation.org,
	gnomes@lxorguk.ukuu.org.uk, aarcange@redhat.com, luto@kernel.org,
	keescook@google.com, tim.c.chen@linux.intel.com,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
Message-ID: <20180308171526.GA21827@kroah.com>
References: <20180307214624.D4361772@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307214624.D4361772@viggo.jf.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 01:46:24PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I think we need to soften the language a bit.  It might scare folks
> off, especially the:
> 
> 	 We prefer to fully disclose the bug as soon as possible.
> 
> which is not really the case.  Linus says:
> 
> 	It's not full disclosure, it's not coordinated disclosure,
> 	and it's not "no disclosure".  It's more like just "timely
> 	open fixes".
> 
> I changed a bit of the wording in here, but mostly to remove the word
> "disclosure" since it seems to mean very specific things to people
> that we do not mean here.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@google.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
