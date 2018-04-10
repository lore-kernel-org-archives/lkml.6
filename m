Date: Tue, 10 Apr 2018 14:32:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: GyeDo Park <gyedo.park@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitor@vger.kernel.org
Subject: Re: [PATCH] staging:rtl8712: required line 80 over and multiple line
Message-ID: <20180410123209.GB6229@kroah.com>
References: <20180406024723.GA20534@h00ker192.168.219.101>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406024723.GA20534@h00ker192.168.219.101>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 11:47:23AM +0900, GyeDo Park wrote:
> clean up checkpatch warning:
> Warning: line over 80 characters
> Warning: Avoid multiple line dereference

Please break this up into 2 different patches, and properly cc: the
needed people and lists that get_maintainers.pl says to use.

thanks,

greg k-h
