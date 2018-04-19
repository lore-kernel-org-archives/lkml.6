Date: Thu, 19 Apr 2018 16:03:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
Message-ID: <20180419140305.GD16862@kroah.com>
References: <20180417155645.868055442@linuxfoundation.org>
 <20180418174244.ke5n4uhbj5geijco@xps>
 <20180419075608.GA4230@kroah.com>
 <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 04:42:56PM +0530, Naresh Kamboju wrote:
> >
> > Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
> > gets figured out.
> 
> After reverting this patch, network started works on arm32 x15 device.
> d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")

Thanks for letting me know, I've now reverted that commit.

greg k-h
