Date: Thu, 15 Mar 2018 18:27:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: base: add description for .coredump() callback
Message-ID: <20180315172719.GB28917@kroah.com>
References: <1518167637-1948-1-git-send-email-aspriel@gmail.com>
 <5AA8E61F.9090500@broadcom.com>
 <5AAA3DC5.4070101@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AAA3DC5.4070101@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:32:53AM +0100, Arend van Spriel wrote:
> On 3/14/2018 10:06 AM, Arend van Spriel wrote:
> > On 2/9/2018 10:13 AM, Arend van Spriel wrote:
> > > Commit 3c47d19ff4dc ("drivers: base: add coredump driver ops") added
> > > a new callback in struct device_driver, but not a kerneldoc description
> > > so here it is.
> > 
> > Hi Greg,
> > 
> > Revisiting the header file I notice this patch is not yet applied. I am
> > pretty sure I got an automated email from you regarding the merge
> > window, but nothing else so did this one slip the cracks?
> 
> Hi Greg,
> 
> As I am touching this in follow-up patch, can we just drop this one? I will
> be posting a couple of new patch assuming it is fine to drop this. Let me
> know how you want to handle this.

Just applied this, it's trivial and should be simple to merge around.

thanks,

greg k-h
