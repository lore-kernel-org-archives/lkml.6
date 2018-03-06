Date: Mon, 5 Mar 2018 18:38:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Rodolfo Giometti <giometti@enneenne.com>, linux-kernel@vger.kernel.org
Subject: Re: [1/2] pps: client: use new parport device model
Message-ID: <20180306023823.GB4454@kroah.com>
References: <1517181729-5839-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20180305214521.GA5844@sudip-tp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305214521.GA5844@sudip-tp>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 09:45:21PM +0000, Sudip Mukherjee wrote:
> On Sun, Jan 28, 2018 at 11:22:08PM +0000, Sudip Mukherjee wrote:
> > Modify pps client driver to use the new parallel port device model.
> > In that process, added an index to mention the device number when we
> > have more than one parallel port.
> > 
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > ---
> 
> Hi Greg,
> 
> A gentle reminder for this one.

Hah, I have over 1000 patches in my to-review queue right now.  That's
what I get for trying to go on vacation for a few days...

don't worry, it's not lost...

greg k-h
