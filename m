Date: Wed, 28 Mar 2018 13:29:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martijn Coenen <maco@android.com>
Cc: John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	Martijn Coenen <maco@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ANDROID: binder: prevent transactions into own process.
Message-ID: <20180328112921.GB26219@kroah.com>
References: <20180328072903.155938-1-maco@android.com>
 <20180328081921.GA14201@kroah.com>
 <CAB0TPYF_zs=rL5qQ=C737rBVx_Z0utaihJhv9dnRqvpJ0sp7Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYF_zs=rL5qQ=C737rBVx_Z0utaihJhv9dnRqvpJ0sp7Hw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:06:54AM +0200, Martijn Coenen wrote:
> On Wed, Mar 28, 2018 at 10:19 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > Does this need to go to older kernels as well?
> 
> Yes, this should apply cleanly to 4.14 as well. It won't apply to
> pre-4.14 kernels because of the fine-grained locking changes, but the
> same issue exists there and I suspect it would cause the same crash.
> Do you want me to send a separate patch for pre-4.14?

I can mark it for stable, and then when you get the "this did not apply
to this tree" email, you can send a backported patch to me so I know to
take that one then.

thanks,

greg k-h
