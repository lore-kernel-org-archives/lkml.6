Date: Thu, 22 Mar 2018 11:44:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
	Linux-doc <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 1/2] COPYING: create a new file with points to the Kernel
 license files
Message-ID: <20180322104452.GA4570@kroah.com>
References: <20180322095414.24019-1-mchehab@s-opensource.com>
 <20180322095414.24019-2-mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322095414.24019-2-mchehab@s-opensource.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:54:13AM -0300, Mauro Carvalho Chehab wrote:
> With the addition of SPDX patchset, the contents of COPYING file
> is now duplicated at two other files under LICENSE:
> 	LICENSES/preferred/GPL-2.0
> 	LICENSES/exceptions/Linux-syscall-note
> 
> It is easy to check that the contents of the licence written on
> those files are identical with COPYING using:
> 
> 	$ diff -upr COPYING LICENSES/preferred/GPL-2.0
> 	$ diff -upr COPYING LICENSES/exceptions/Linux-syscall-note|less
> 
> Also, a new file was added, with describes how SPDX should work at
> the Kernel source files:
> 	Documentation/process/license-rules.rst
> 
> Instead fo having it copying the contents of two files, and not
> even mentioning the third one, replace it by a file whose content
> points to the other tree files, preserving the Kernel's license.
> 
> Adjust license-rules.rst accordingly.
> 
> Please notice that this file preserves the Kernel license as
> is, without any changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
