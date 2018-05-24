Date: Thu, 24 May 2018 08:08:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederick Lawler <fred@fredlawl.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH v2 1/5] PCI/AER: Define and allocate aer_stats structure
 for AER capable devices
Message-ID: <20180524060822.GA3016@kroah.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
 <20180523175808.28030-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523175808.28030-2-rajatja@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:58:04AM -0700, Rajat Jain wrote:
> ---
> v2: Fix the license header as per Greg's suggestions
>     (Since there is disagreement with using "//" vs "/* */" for license
>      I decided to keep the one preferred by Linus, also used by others
>      in this directory)

The rules are pretty simple for how to do this, and they are documented
in Documentation/process/license-rules.rst, please just follow that like
the rest of the kernel has done.

thanks,

greg k-h
