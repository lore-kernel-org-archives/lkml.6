Date: Mon, 23 Apr 2018 14:03:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] platform: provide early_platform_add_device()
Message-ID: <20180423120330.GD7951@kroah.com>
References: <20180420163924.5227-1-brgl@bgdev.pl>
 <20180420163924.5227-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420163924.5227-2-brgl@bgdev.pl>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 06:39:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently we only have early_platform_add_devices() which takes struct
> platform_device ** as argument, requiring the users to have an
> intermediate array of platform_device pointers even if we're only
> adding a single device. Provide a helper for adding a single device at
> a time.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Feel free to take these with your driver cleanups:

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
