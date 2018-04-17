Date: Tue, 17 Apr 2018 12:29:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ahbong Chang <cwahbong@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Todd Poynor <toddpoynor@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] trace: add missing forward declaration
Message-ID: <20180417102909.GA8057@kroah.com>
References: <20180416023626.139915-1-cwahbong@google.com>
 <20180416092444.05ec6434@gandalf.local.home>
 <CAEvWiR--DLM2Tp8-OaZSh4LV9o8x2K47c9=-+VZFoDhedy=nZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvWiR--DLM2Tp8-OaZSh4LV9o8x2K47c9=-+VZFoDhedy=nZQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 02:18:47AM +0000, Ahbong Chang wrote:
> It does not fail with any config without this fix. This is for new work.

Then why not submit it as part of the "new work" patch series?  That's
how dependancies are normally handled.

thanks,

greg k-h
