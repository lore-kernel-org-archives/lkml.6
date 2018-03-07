Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeCGNm7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:42:59 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:40452 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:42:58 -0500
Date: Wed, 7 Mar 2018 14:42:36 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH 1/2] vsprintf: distinguish between (null), (err) and
 (invalid) pointer derefs
Message-ID: <20180307134236.mfmzu7h4ib7thfsc@angband.pl>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <20180306181122.11449-1-kilobyte@angband.pl>
 <1520428639.10722.461.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520428639.10722.461.camel@linux.intel.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:17:19PM +0200, Andy Shevchenko wrote:
> On Tue, 2018-03-06 at 19:11 +0100, Adam Borowski wrote:
> 
> Thanks for the patch, my comments below.

(Review snipped.)

It looks pretty obvious that it'd take a lot less of your time to roll new
patch[es] from scratch than to try to educate me wrt how you'd want to see
it done; thus I'll sit out this one.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
