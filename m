Date: Wed, 25 Apr 2018 07:38:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 1/2] tty/nozomi: cleanup DUMP() macro
Message-ID: <20180425053848.GB30843@kroah.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
 <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524606061.git.joeypabalinas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524606061.git.joeypabalinas@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:39:14PM -1000, Joey Pabalinas wrote:
> Replace snprint() with strscpy() and use min_t() instead of
> the conditional operator to clamp buffer length.
> 
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> 
>  1 file changed, 13 insertions(+), 13 deletions(-)

Again, this is odd...

How are you sending these patches?  How are you creating them?  What is
taking part of the diffstat off and just leaving that line?

thanks,

greg k-h
