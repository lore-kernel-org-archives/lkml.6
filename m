Date: Thu, 29 Mar 2018 12:01:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: stable@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
	"Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
Message-ID: <20180329100146.GA23906@kroah.com>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
 <20180218171927.6414-1-paweldembicki@gmail.com>
 <20180314135902.GA21622@kroah.com>
 <CAJN1Kkzsys9XAJcDS2-CvE5+Z+z=kkvi6YN96G+kufqh9xakag@mail.gmail.com>
 <20180317115556.GA17545@kroah.com>
 <CAJN1KkyrJLBVtzjnE69v-NNed3rjrXt+o46ALnN+wurHzecPTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkyrJLBVtzjnE69v-NNed3rjrXt+o46ALnN+wurHzecPTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 11:47:25AM +0200, Paweł Dembicki wrote:
> 2018-03-17 12:55 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> 
> > Where is this patch supposed to go?  Is this a stable backport patch, or
> > something to go into Linus's tree?
> 
> I tested it in 4.9 and 4.14 kernels in OpenERT. So it is a stable
> backport patch.

What commit is being backported.

> In current release this bug is fixed because w1-gpio use gpiod.

Then why can we not just use the actual patch that fixes this?

> Sorry. This was my first patch.

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to submit a patch for the stable tree.

thanks,

greg k-h
