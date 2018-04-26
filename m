Date: Thu, 26 Apr 2018 19:04:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V3 7/7] scripts: Add SPDX checker script
Message-ID: <20180426170428.GA18248@kroah.com>
References: <20180425203020.594959448@linutronix.de>
 <20180425203703.650160358@linutronix.de>
 <20180426070246.GL14025@kroah.com>
 <alpine.DEB.2.21.1804261552000.1584@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804261552000.1584@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 03:54:27PM +0200, Thomas Gleixner wrote:
> +#!/usr/bin/env python
> +# SPDX-License-Identifier: GPL2.0

You didn't run the tool on itself :)

Other than that, looks good, if you fix the above line feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
