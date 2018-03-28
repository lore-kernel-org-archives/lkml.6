Date: Wed, 28 Mar 2018 20:05:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Manoj Gupta <manojgupta@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328180556.GB32098@kroah.com>
References: <20180327235553.210165-1-mka@chromium.org>
 <20180328061616.GA8212@kroah.com>
 <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Mar 28, 2018 at 07:47:53AM -0700, Manoj Gupta wrote:
> Please note that there is nothing wrong in the generated code, just
> that it confuses objtool.

Then fix the tool, the C code is correct :)

> Clang has simply omitted the statement where NULL is returned since
> the pointer was always dereferenced post inlining.

Then tell clang not to do that, like we tell gcc not to do that as that
is a foolish thing for a compiler to do when building the kernel.

thanks,

greg k-h
