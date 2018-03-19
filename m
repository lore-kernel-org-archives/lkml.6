Date: Mon, 19 Mar 2018 11:37:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Stultz <john.stultz@linaro.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Colin Cross <ccross@android.com>,
	David Riley <davidriley@chromium.org>
Subject: Re: [patch 03/3] time: Remove license boilerplates and sloppy
 references
Message-ID: <20180319103723.GC21397@kroah.com>
References: <20180319100441.809595337@linutronix.de>
 <20180319100810.428470014@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319100810.428470014@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:04:44AM +0100, Thomas Gleixner wrote:
> Now that the SPDX tag is in all time(r) core files, that identifies the
> license in a specific and legally-defined manner.  So the extra GPL text
> wording can be removed as it is no longer needed at all.
>     
> This is done on a quest to remove the 700+ different ways that files in the
> kernel describe the GPL license text.  And there's unneeded stuff like the
> address (sometimes incorrect) for the FSF or other entities which is never
> needed.
>     
> No copyright headers or other non-license-description text was removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
