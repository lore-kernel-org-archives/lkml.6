Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeB0WXG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:23:06 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40987 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbeB0WXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:23:05 -0500
Date: Tue, 27 Feb 2018 23:23:00 +0100
From: Willy Tarreau <w@1wt.eu>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: geert@linux-m68k.org, andy.shevchenko@gmail.com, rabel@robertabel.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3] auxdisplay: charlcd: Fix and clean up handling of
 x/y commands
Message-ID: <20180227222300.GA27591@1wt.eu>
References: <20180227220952.57wc3wpc26b2fdyq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227220952.57wc3wpc26b2fdyq@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 11:09:52PM +0100, Miguel Ojeda wrote:
> The current version is not parsing multiple x/y commands as the code
> originally intended. On top of that, kstrtoul() expects
> NULL-terminated strings. Finally, the code does two passes over
> the string.
> 
> Some explanations about the supported syntax are added as well.

Looks much better, thank you ;-)

Willy
