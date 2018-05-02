Date: Wed, 2 May 2018 07:25:44 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Dan Haab <dhaab@luxul.com>,
	Dan Haab <riproute@gmail.com>, Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Relicense most DTS files to the GPL
 2.0+ / MIT
Message-ID: <20180502142544.GB10928@kroah.com>
References: <20180502141102.31769-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502141102.31769-1-zajec5@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 04:11:02PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> These files were created and ever touched by a group of three people
> only: Dan, Hauke and me. They were licensed under GNU/GPL or ISC.
> 
> Introducing and discussing SPDX-License-Identifier resulted in a
> conclusion that ISC is a not recommended license (see also a
> license-rules.rst). Moveover an old e-mail from Alan Cox was pointed
> which explained that dual licensing is a safer solution than depending
> on a common compatibility belief.
> 
> This commit switches most of BCM5301X DTS files to dual licensing using:
> 1) GPL 2.0+ to make sure they are compatible with Linux kernel
> 2) MIT to allow sharing with more permissive projects
> Both licenses belong to the preferred ones (see LICENSES/preferred/).
> 
> An attempt to relicense remaining files will be made separately and will
> require approve from more/other developers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Many thanks for doing this, it makes the license "confusion" a bit less
now :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
