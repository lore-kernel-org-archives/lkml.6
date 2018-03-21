Date: Wed, 21 Mar 2018 14:28:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180321132829.GA28002@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
 <ba41bdff-3068-a2e5-717f-715aeab56197@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba41bdff-3068-a2e5-717f-715aeab56197@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 06:35:01AM -0700, Guenter Roeck wrote:
> On 03/19/2018 11:04 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.89 release.
> > There are 241 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.9.88-239-g393003b:
> 
> Build results:
> 	total: 145 pass: 143 fail: 2
> Failed builds:
> 	arm:allmodconfig
> 	x86_64:allnoconfig
> 
> arm:
> 
> sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
> sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below array bounds

Oops, missed this one for -rc3, let me go dig...


greg k-h
