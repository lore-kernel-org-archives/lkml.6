Date: Tue, 10 Apr 2018 09:10:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] kobject: add kobject_read()
Message-ID: <20180410071051.GA19397@kroah.com>
References: <87bmerv9ll.wl%kuninori.morimoto.gx@renesas.com>
 <87a7ubv9kg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7ubv9kg.wl%kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 06:53:50AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We are counting kobject by using kobject_get/put(), but
> not have kobject_read() which can be used to check count.
> Let's add

No, please do not.  You should never care about this "count", and if we
do provide this, people will abuse it.

I understand that this might make some debugging harder, but if you
really need to write custom debugging code, then just use the internal
values.

sorry,

greg k-h
