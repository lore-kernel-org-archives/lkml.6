Date: Mon, 23 Apr 2018 08:52:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [patch 4/9] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid
 identifiers
Message-ID: <20180423065229.GD4208@kroah.com>
References: <20180422220208.772527041@linutronix.de>
 <20180422220833.078058446@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422220833.078058446@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:02:12AM +0200, Thomas Gleixner wrote:
> Quite some files have been flagged with the new GPL-2.0-only and
> GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
> GPL-2.0+ identifiers in the SPDX license identifier specification, but the
> identifiers are not mentioned as valid in the GPL-2.0 license file.
> 
> Add them to make everything consistent again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>

As much as I dislike the "new" identifiers, I guess trying to hold them
back is a pointless exercise :(

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
