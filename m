Date: Tue, 6 Feb 2018 14:38:15 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: rtc: remove unused rtc_control() API
Message-ID: <20180206223815.GE23990@kroah.com>
References: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:12:26PM +0100, Alexandre Belloni wrote:
> Since commit 34ce71a96dcb ("ALSA: timer: remove legacy rtctimer"), the
> rtc_register/rtc_control/rtc_unregister API is unused. As it is highly
> unlikely to be needed again, remove it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> Hi,
> 
> I'd like that one to go through the RTC tree as I have other changes in rtc.h
> planned for the next release.
> 

Fine with me!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
