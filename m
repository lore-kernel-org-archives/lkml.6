Date: Wed, 11 Apr 2018 10:04:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Miller <davem@davemloft.net>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
	jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 4.14 134/138] vhost: validate log when IOTLB is enabled
Message-ID: <20180411080413.GC2137@kroah.com>
References: <20180410212902.121524696@linuxfoundation.org>
 <20180410212917.818627954@linuxfoundation.org>
 <20180411023210-mutt-send-email-mst@kernel.org>
 <20180410.205553.264864966341341110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410.205553.264864966341341110.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 08:55:53PM -0400, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Wed, 11 Apr 2018 02:33:16 +0300
> 
> > That's a bug, davem just queued a patch to fix this upstream.
> 
> It did not get queued up.
> 
> The patch series didn't apply so I asked the submitter to
> respin and resubmit:
> 
> 	https://marc.info/?l=linux-netdev&m=152337186209819&w=2

So should I drop this until a fix comes in?  Or keep it for now?
I have no objection to staying "bug compatible" with Linus's tree :)

thanks,

greg k-h
