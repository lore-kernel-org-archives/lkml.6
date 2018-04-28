Date: Sat, 28 Apr 2018 08:01:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Efstratios Gavas <xtrat@elg.io>
Cc: devel@driverdev.osuosl.org,
	Thibaut SAUTEREAU <thibaut.sautereau@telecom-sudparis.eu>,
	Christopher H Pezley <chris@pezley.net>,
	linux-kernel@vger.kernel.org,
	AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>,
	Aviya Erenfeld <aviyae42@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Aviv Palivoda <palaviv@gmail.com>
Subject: Re: [PATCHv3] staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Message-ID: <20180428060141.GC18371@kroah.com>
References: <20180427065801.GC4361@kroah.com>
 <2ac130bd.AMIAAAY8Aw8AAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa45e6@mailjet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac130bd.AMIAAAY8Aw8AAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa45e6@mailjet.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 09:33:34PM +0000, Efstratios Gavas wrote:
> Fixed format/style issues found with checkpatch. No code changes.
> Corrected alignment of variables after open parenthesis and line breaks.
> Checkpatch now returns clean except for line over 80 char warnings.
> 
> Signed-off-by: Efstratios Gavas <xtrat@elg.io>
> ---
> v2(unlabled): changed title info
> v3: improved changlog description
> ---
>  drivers/staging/wlan-ng/prism2sta.c | 52 +++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)

Why was this sent twice?  Which one should I take?

I'm dropping both, please only send 1 patch next time.

thanks,

greg k-h
