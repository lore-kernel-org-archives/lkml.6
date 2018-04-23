Date: Mon, 23 Apr 2018 10:24:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martijn Coenen <maco@android.com>
Cc: Amit Pundir <amit.pundir@linaro.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Martijn Coenen <maco@google.com>,
	John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2] ANDROID: binder: prevent transactions into own
 process.
Message-ID: <20180423082401.GA20746@kroah.com>
References: <20180328091450.85073-1-maco@android.com>
 <20180328112838.GA26219@kroah.com>
 <CAB0TPYHAMmbW8Nfqxr94MyB_dR3zeE+5JtSGAadkaNaMyrD46Q@mail.gmail.com>
 <CAB0TPYEt2Hp+dsFU6g3aAkS8AxvAb9cz3wOZ9+ZJqwAiqX5wnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYEt2Hp+dsFU6g3aAkS8AxvAb9cz3wOZ9+ZJqwAiqX5wnw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:07:43AM +0200, Martijn Coenen wrote:
> On Wed, Mar 28, 2018 at 1:34 PM, Martijn Coenen <maco@android.com> wrote:
> > On Wed, Mar 28, 2018 at 1:28 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> What is different from "v2" you sent before this?  No change information
> >> from v1?
> 
> Greg, is this in your queue, or should I just send a v3 to clean this
> up? See below for my original reply.

It's in my queue, I couldn't do anything during the merge window and I
was gone all last week, so am catching up on stuff now.  Should get to
it by the end of this week, sorry for the delay.

thanks,

greg k-h
