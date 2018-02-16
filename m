Date: Fri, 16 Feb 2018 07:48:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Daniel Drake <drake@endlessm.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180216064850.GA26224@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
> On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> Consider this an objection:
> 
> I'm currently arguing that this is unnecessarily regressing power
> consumption here:
> 
> https://patchwork.kernel.org/patch/10149195/
> 
> I'll leave it up to you what to do with this, but if this ends up in
> Chromium OS kernels, I'm likely to revert it there...

Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
here.

thanks,

greg k-h
