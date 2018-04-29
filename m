Date: Sun, 29 Apr 2018 15:24:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jefferson Capovilla <jefcap@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-eth: fix line over 80 char / extra line
 in mtk_set_link_ksettings()
Message-ID: <20180429132437.GD5972@kroah.com>
References: <20180427002909.GA1605@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427002909.GA1605@jefcap-VirtualBox>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 09:29:09PM -0300, Jefferson Capovilla wrote:
> Fix 'line over 80 characters' issue found by checkpatch.pl script in
> mtk_set_link_ksettings().
> Fix extra line before end of function.

That is two different things, please break this up into two different
emails and send them as a patch series.

thanks,

greg k-h
