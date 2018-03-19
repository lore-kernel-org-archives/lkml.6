Date: Mon, 19 Mar 2018 11:37:17 +0100
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
Subject: Re: [patch 02/3] time: Add SPDX license identifiers
Message-ID: <20180319103717.GB21397@kroah.com>
References: <20180319100441.809595337@linutronix.de>
 <20180319100810.345952155@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319100810.345952155@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:04:43AM +0100, Thomas Gleixner wrote:
> Update the time(r) core files files with the correct SPDX license
> identifier based on the license text in the file itself. The SPDX
> identifier is a legally binding shorthand, which can be used instead of the
> full boiler plate text.
> 
> This work is based on a script and data from Philippe Ombredanne, Kate
> Stewart and myself. The data has been created with two independent license
> scanners and manual inspection.
> 
> The following files do not contain any direct license information and have
> been omitted from the big initial SPDX changes:
> 
>   timeconst.bc: The .bc files were not touched
>   time.c, timer.c, timekeeping.c: Licence was deduced from EXPORT_SYMBOL_GPL
> 
> As those files do not contain direct license references they fall under the
> project license, i.e. GPL V2 only.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
