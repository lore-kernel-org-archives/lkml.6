Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBJS6d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:58:33 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40514 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeBJS6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:58:32 -0500
Date: Sat, 10 Feb 2018 19:58:26 +0100
From: Willy Tarreau <w@1wt.eu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
Message-ID: <20180210185826.GD21587@1wt.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu>
 <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
 <CAMuHMdXmqANSaciMtPad4Q6k-i9LXGO1O8Q36bEB0r+vhp9fCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXmqANSaciMtPad4Q6k-i9LXGO1O8Q36bEB0r+vhp9fCA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 07:31:54PM +0100, Geert Uytterhoeven wrote:
> The redefinition feature definitely works with hex characters.
> I've used it in the past, cfr. the picture on my Google+ profile ;-)
> https://plus.google.com/u/0/+GeertUytterhoeven

I've used it as well which is why I never noticed. However it's the
first time I see the driver used with a 4-lines device, so apparently
it works :-)

Willy
