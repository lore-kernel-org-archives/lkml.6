Date: Wed, 25 Apr 2018 08:09:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 1/2] tty/nozomi: cleanup DUMP() macro
Message-ID: <20180425060931.GA595@kroah.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
 <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524606061.git.joeypabalinas@gmail.com>
 <20180425053848.GB30843@kroah.com>
 <20180425054530.gifahvwftdbjuo7x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425054530.gifahvwftdbjuo7x@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 07:45:30PM -1000, Joey Pabalinas wrote:
> On Wed, Apr 25, 2018 at 07:38:48AM +0200, Greg Kroah-Hartman wrote:
> > How are you sending these patches?  How are you creating them?  What is
> > taking part of the diffstat off and just leaving that line?
> 
> Hm, my `git format-patch` alias included --shortstat for some odd reason,
> very sorry about that.
> 
> Going to resend.

Ah, never seen that before.  Just use the defaults and you should be
fine.  Having the normal diffstat is good.

thanks,

greg k-h
