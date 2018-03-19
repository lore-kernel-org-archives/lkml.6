Date: Mon, 19 Mar 2018 14:37:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH 4.9 1/2] Revert "led: core: Fix brightness setting when
 setting delay_off=0"
Message-ID: <20180319133711.GB27855@kroah.com>
References: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
 <1521271862-4599-2-git-send-email-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521271862-4599-2-git-send-email-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 08:31:01AM +0100, Jacek Anaszewski wrote:
> This reverts commit 86b9fa2190907f4f550d9d6bf490c5f89ca33836.
> 
> The commit being reverted has two flaws:
>  - it introduces a regression, fixed in the upstream
>    commit 7b6af2c53192f1766892ef40c8f48a413509ed72.
>  - it has truncated commit message
> ---
>  drivers/leds/led-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I need a signed-off-by :(

And maybe a few "reported-by:" lines as well, that email thread seemed
to have lots of people on it...

thanks,

greg k-h
