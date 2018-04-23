Date: Mon, 23 Apr 2018 10:51:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>, Tomasz Kramkowsk <tk@the-tk.com>
Subject: Re: [PATCH v2 1/4] tty/nozomi: cleanup DUMP() macro
Message-ID: <20180423085131.GA3894@kroah.com>
References: <20180324112732.29424-1-joeypabalinas@gmail.com>
 <20180324112732.29424-2-joeypabalinas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324112732.29424-2-joeypabalinas@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 01:27:29AM -1000, Joey Pabalinas wrote:
> Replace snprint() with strscpy() and use max_t() instead of
> the conditional operator.
> 
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> 
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 

Something is really odd here, look at what is in your changelog above :(

Same for all of these patches.  Can you please fix up and resend?

thanks,

greg k-h
