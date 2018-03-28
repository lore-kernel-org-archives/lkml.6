Date: Wed, 28 Mar 2018 13:28:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martijn Coenen <maco@android.com>
Cc: john.stultz@linaro.org, tkjos@google.com, arve@android.com,
	amit.pundir@linaro.org, devel@driverdev.osuosl.org, maco@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ANDROID: binder: prevent transactions into own
 process.
Message-ID: <20180328112838.GA26219@kroah.com>
References: <20180328091450.85073-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328091450.85073-1-maco@android.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:14:50AM +0200, Martijn Coenen wrote:
> This can't happen with normal nodes (because you can't get a ref
> to a node you own), but it could happen with the context manager;
> to make the behavior consistent with regular nodes, reject
> transactions into the context manager by the process owning it.
> 
> Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/android/binder.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

What is different from "v2" you sent before this?  No change information
from v1?

I'm totally confused as to which is the "latest" patch here :(

thanks,

greg k-h-
