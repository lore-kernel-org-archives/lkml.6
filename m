Date: Wed, 28 Feb 2018 13:29:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 07/13] tty: Remove metag DA TTY and console driver
Message-ID: <20180228122923.GA10075@kroah.com>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-8-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221233825.10024-8-jhogan@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:38:19PM +0000, James Hogan wrote:
> Now that arch/metag/ has been removed, remove the metag DA TTY and
> console driver. It is of no value without the architecture code.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-metag@vger.kernel.org
> ---
>  drivers/tty/Kconfig    |  13 -
>  drivers/tty/Makefile   |   1 -
>  drivers/tty/metag_da.c | 665 -------------------------------------------------
>  3 files changed, 679 deletions(-)
>  delete mode 100644 drivers/tty/metag_da.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
