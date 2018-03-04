Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeCDWuG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:50:06 -0500
Received: from server.atrad.com.au ([150.101.241.2]:49106 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeCDWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 17:50:04 -0500
Date: Mon, 5 Mar 2018 09:19:24 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
Message-ID: <20180304224924.GA29081@marvin.atrad.com.au>
References: <20180227211539.5708-1-kernel@kempniu.pl>
 <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au>
 <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 08:44:26PM +0100, Micha?? K??pie?? wrote:
> > On Wed, Feb 28, 2018 at 06:08:52PM +0200, Andy Shevchenko wrote:
> > > And plain 0 doesn't look right in this concept (something like (0 <<
> > > 0) would probably do it).
> > 
> > Given that all other definitions are in terms of BIT(), to my eye "(0 << 0)"
> > looks as much out of place as plain "0".  However, if the convention in this
> > case would be to use the former then I have no objections.  I presume the
> > "(0 << 0)" idea comes from the fact that BIT() ultimately expands to some
> > form of shift.
> 
> Yes, I would guess so.  The syntax suggested by Andy looked odd and
> superfluous to me at first, but grepping the tree for this construct
> seems to suggest that it is a pretty common thing.  So no problem, I
> will tweak this in v2.  I understand I should apply the same concept in
> these cases:
> 
> +/* Constants related to FUNC_BACKLIGHT */
> +#define FEAT_BACKLIGHT_POWER		BIT(2)
> +#define STATE_BACKLIGHT_OFF		(BIT(0) | BIT(1))
> +#define STATE_BACKLIGHT_ON		0
> 
> +#define FEAT_RADIO_LED			BIT(5)
> +#define STATE_RADIO_LED_OFF		0
> +#define STATE_RADIO_LED_ON		BIT(5)
> 
> Right?

I suspect so.

Regards
  jonathan
