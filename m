Date: Fri, 13 Apr 2018 08:21:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: Greg Hackmann <ghackmann@google.com>,
	Adam Wallis <awallis@codeaurora.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "xhci: plat: Register shutdown for xhci_plat"
Message-ID: <20180413062128.GA22147@kroah.com>
References: <20180413002951.155762-1-ghackmann@google.com>
 <F4A1736F-B00A-4EA6-94CD-BCD6CC7758C3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4A1736F-B00A-4EA6-94CD-BCD6CC7758C3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 08:12:31AM +0530, Harsh Shandilya wrote:
> On 13 April 2018 5:59:51 AM IST, Greg Hackmann <ghackmann@google.com> wrote:
> >Pixel 2 field testers reported that when they tried to reboot their
> >phones with some USB devices plugged in, the reboot would get wedged
> >and
> >eventually trigger watchdog reset.  Once the Pixel kernel team found a
> >reliable repro case, they narrowed it down to this commit's 4.4.y
> >backport.  Reverting the change made the issue go away.
> 
> Are you allowed to make the repro steps public? I'm writing this from
> a walleye and would be grateful if I could test for this in the
> modifed tree I'm running atm.  -- 

I was told the steps are pretty simple:
	- reboot the phone a lot
eventually it will hang.  There's a fix in the code aurora kernel tree
for this that they never sent upstream for some odd reason (they sent
the first patch, why not the second?)

I'll go revert this for now, thanks for the patch!

greg k-h
