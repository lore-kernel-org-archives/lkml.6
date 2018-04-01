Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeDAJQF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 05:16:05 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37596 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbeDAJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 05:16:04 -0400
Date: Sun, 1 Apr 2018 11:15:49 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        pantelis.antoniou@konsulko.com, mark.rutland@arm.com, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com, corbet@lwn.net,
        me@tobin.cc, sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 1/2] lib: vsprintf: Implement %pCOW
Message-ID: <20180401091549.lvtqox3adp73mgwk@angband.pl>
References: <20180401085622.7754-1-richard@nod.at>
 <20180401085622.7754-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180401085622.7754-2-richard@nod.at>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 10:56:21AM +0200, Richard Weinberger wrote:
> +		.cow_lines = {
> +			"\\   ^__^",
> +			" \\  (oo)\\_______",
> +			"    (__)\\       )\\/\\",
> +			"        ||----w |",
> +			"        ||     ||",

Userspace cowsay(6) knows of different cows.  What about using those as a
visual indication of message level?


Meow! err... Moo!
-- 
ᛊᚨᚾᛁᛏᚣ᛫ᛁᛊ᛫ᚠᛟᚱ᛫ᚦᛖ᛫ᚹᛖᚨᚲ
