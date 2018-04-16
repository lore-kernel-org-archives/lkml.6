Date: Mon, 16 Apr 2018 17:26:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] uio: Change return type to vm_fault_t
Message-ID: <20180416152658.GA6398@kroah.com>
References: <20180416145440.GA26704@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416145440.GA26704@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 08:24:40PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler
> in struct vm_operations_struct. For now, this is
> just documenting that the function returns a 
> VM_FAULT value rather than an errno.  Once all
> instances are converted, vm_fault_t will become
> a distinct type.

Odd line length to wrap at, your editor should have told you to use 72
columns, right?

> Reference commit id->
> 1c8f422059ae5da07db7406ab916203f9417e396

1c8f422059ae ("mm: change return type to vm_fault_t")

Is the "canonical" way to reference git commit ids, it's easy to set up
an alias for this:
	alias gsr='git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> v2: Modified the change log

3rd time's the charm?

thanks,

greg k-h
