Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeDAJTF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 05:19:05 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60334 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeDAJTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 05:19:04 -0400
From: Richard Weinberger <richard@nod.at>
To: Adam Borowski <kilobyte@angband.pl>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        pantelis.antoniou@konsulko.com, mark.rutland@arm.com, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com, corbet@lwn.net,
        me@tobin.cc, sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 1/2] lib: vsprintf: Implement %pCOW
Date: Sun, 01 Apr 2018 11:18:56 +0200
Message-ID: <4175240.C9idGaHF5e@blindfold>
In-Reply-To: <20180401091549.lvtqox3adp73mgwk@angband.pl>
References: <20180401085622.7754-1-richard@nod.at> <20180401085622.7754-2-richard@nod.at> <20180401091549.lvtqox3adp73mgwk@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. April 2018, 11:15:49 CEST schrieb Adam Borowski:
> On Sun, Apr 01, 2018 at 10:56:21AM +0200, Richard Weinberger wrote:
> > +		.cow_lines = {
> > +			"\\   ^__^",
> > +			" \\  (oo)\\_______",
> > +			"    (__)\\       )\\/\\",
> > +			"        ||----w |",
> > +			"        ||     ||",
> 
> Userspace cowsay(6) knows of different cows.  What about using those as a
> visual indication of message level?

Yeah, this will be implemented for April 1st 2019 if we get funding.
I think of a eBPF cow engine such that usespace can load different cow types.

Thanks,
//richard
