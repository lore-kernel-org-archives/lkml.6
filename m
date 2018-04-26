Date: Thu, 26 Apr 2018 09:00:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 1/7] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as
 valid identifiers
Message-ID: <20180426070040.GF14025@kroah.com>
References: <20180425203020.594959448@linutronix.de>
 <20180425203703.137893509@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425203703.137893509@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:30:21PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner tglx@linutronix.de
> 
> Quite some files have been flagged with the new GPL-2.0-only and
> GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
> GPL-2.0+ identifiers in the SPDX license identifier specification, but the
> identifiers are not mentioned as valid in the GPL-2.0 license file.
> 
> Add them to the license file and to the Linux-syscall-note exception to
> make everything consistent again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>

I think you dropped my review of the v1 of this series :(

Anyway:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
