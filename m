Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeEGOpg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:45:36 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53766 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeEGOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:45:30 -0400
Date: Mon, 7 May 2018 10:45:19 -0400
From: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
Message-ID: <20180507144519.GH1392@brightrain.aerifal.cx>
References: <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 01:00:17PM +0200, John Paul Adrian Glaubitz wrote:
> On 05/07/2018 03:40 AM, Yoshinori Sato wrote:
> >>@Yoshinori:
> >>
> >>Did the HDL-160U LANDISK device you have use u-boot by default or
> >>did you convert it from lilo?
> >
> >Yes.
> >Replace sh-lilo's second stage with u-boot.
> >With this method it is unnecessary to rewrite Flash for boot.
> 
> Great, thank you. I will give it a try on my USL-5P and write down
> the individual steps once I have figured it out.

Please let me know once you figure it out. I haven't made much
progress yet and it would be really helpful to have some simple
directions/outline of what to do, especially one that's not in terms
of black box tools ("run this command") but how it all works (where
the different bootloader components live when installed -- MBRs?
partition boot records? files in a filesystem (who interprets it?)?
etc.)

Rich
