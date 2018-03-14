Date: Wed, 14 Mar 2018 11:48:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mathias.nyman@intel.com,
	bhelgaas@google.com, richard.leitner@skidata.com
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
Message-ID: <20180314104849.GB32615@kroah.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314102933.21367-3-dev@g0hl1n.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:29:32AM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> pci_ids.h

Why?  It's only being used in one file, so it should not be in
pci_ids.h, right?

thanks,

greg k-h
