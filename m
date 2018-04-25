Date: Wed, 25 Apr 2018 08:05:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v4 0/2] tty/nozomi: general module cleanup
Message-ID: <20180425060513.GA32729@kroah.com>
References: <cover.1524634929.git.joeypabalinas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524634929.git.joeypabalinas@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 07:48:02PM -1000, Joey Pabalinas wrote:
> The nozomi module has a few sections which could use a bit of cleanup;
> both style and clarity could be improved while maintaining equivalent
> semantics.
> 
> Cleanup messy portions of the module code while preserving existing
> behavior by:
> 
>  - Replacing constructs like `len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__`
>    with `min_t(u32, len__, TMP_BUF_MAX)` and function calls like
>    snprintf(tbuf, ..., "%s", ...). with strscpy(tbuf, ..., ...).
>  - Correct inconsistently indented lines and extraneous whitespace.
> 
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Jiri Slaby <jslaby@suse.cz>
> 
> Joey Pabalinas (2):
>   tty/nozomi: cleanup DUMP() macro
>   tty/nozomi: fix inconsistent indentation
> 
>  drivers/tty/nozomi.c | 100 +++++++++++++++++++++----------------------
>  1 file changed, 50 insertions(+), 50 deletions(-)

What changed between versions of this series?

greg k-h
