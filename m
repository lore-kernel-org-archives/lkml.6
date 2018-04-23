Date: Mon, 23 Apr 2018 14:03:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/2] platform: provide
 early_platform_driver_register_probe_all()
Message-ID: <20180423120335.GE7951@kroah.com>
References: <20180420163924.5227-1-brgl@bgdev.pl>
 <20180420163924.5227-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420163924.5227-3-brgl@bgdev.pl>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 06:39:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> All users of early_platform_driver_register_all() subsequently call
> early_platform_driver_probe(). Provide a helper that calls both
> functions.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
