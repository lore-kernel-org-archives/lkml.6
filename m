Date: Sun, 29 Apr 2018 15:19:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Efstratios Gavas <xtrat@elg.io>
Cc: devel@driverdev.osuosl.org,
	Thibaut SAUTEREAU <thibaut.sautereau@telecom-sudparis.eu>,
	Christopher H Pezley <chris@pezley.net>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>,
	Aviv Palivoda <palaviv@gmail.com>
Subject: Re: [PATCH] [v4] staging: wlan-ng: prism2sta: fixed indent coding
 style issues.
Message-ID: <20180429131954.GA5972@kroah.com>
References: <4127cb6a.ANAAAAZc5IEAAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa5NlE@mailjet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4127cb6a.ANAAAAZc5IEAAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa5NlE@mailjet.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 08:26:29PM +0000, Efstratios Gavas wrote:
> Fixed format/style issues found with checkpatch. No code changes.
> Corrected alignment of variables after open parenthesis and line breaks.
> Checkpatch now returns clean except for "line over 80 char" warnings.
> 
> Signed-off-by: Efstratios Gavas <xtrat@elg.io>
> ---
> v2(unlabled): changed title info
> v3: improved changlog description
> v4: corrected patch versioning
> ---
>  drivers/staging/wlan-ng/prism2sta.c | 52 +++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)

I see 2 different emails here again :(

I don't know what you are doing that causes this, but you should try to
fix it up...

v5?

thanks,

greg k-h
