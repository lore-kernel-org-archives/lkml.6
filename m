Date: Wed, 23 May 2018 10:22:33 +0200
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
Subject: Re: [PATCH 2/5] PCI/AER: Add sysfs stats for AER capable devices
Message-ID: <20180523082233.GC7247@kroah.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-3-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522222805.80314-3-rajatja@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 03:28:02PM -0700, Rajat Jain wrote:
> Add the following AER sysfs stats to represent the counters for each
> kind of error as seen by the device:
> 
> dev_total_cor_errs
> dev_total_fatal_errs
> dev_total_nonfatal_errs

You need Documentation/ABI/ updates for new sysfs files please.

thanks,

greg k-h
