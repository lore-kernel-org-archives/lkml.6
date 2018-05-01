Date: Tue, 1 May 2018 11:58:43 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Ingo Flaschberger <ingo.flaschberger@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1wire: family module autoload fails because of
 upper/lower case mismatch.
Message-ID: <20180501185843.GA2666@kroah.com>
References: <629ce39b-e3ad-1a4a-be11-7eb3da064ce6@gmail.com>
 <5841141525200877@web25j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5841141525200877@web25j.yandex.ru>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 09:54:37PM +0300, Evgeniy Polyakov wrote:
> Hi Ingo
> 
> Sorry for late reply and because of forcing you to resend the patch, your changes are correct
> 
> 01.05.2018, 17:10, "Ingo Flaschberger" <ingo.flaschberger@gmail.com>:
> > 1wire family module autoload fails because of upper/lower
> >   case mismatch.
> >
> > Signed-off-by: Ingo Flaschberger <ingo.flaschberger@gmail.com>
> 
> Greg, please pull this patch into your tree.
> Should it be stable material?

Looks like it, I'll queue it up to the proper place, thanks!

greg k-h
