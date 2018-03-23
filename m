Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCWP1k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:27:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:27:39 -0400
Date: Fri, 23 Mar 2018 16:27:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Frank Seidel <fseidel@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty/nozomi: refactor macros and functions
Message-ID: <20180323152737.GA25972@kroah.com>
References: <20180321043430.lbvd4fpswl6cy2gq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321043430.lbvd4fpswl6cy2gq@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 06:34:30PM -1000, Joey Pabalinas wrote:
> Cleanup a few messy sections of code by replacing constructs
> like `len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__` with
> `min_t(u32, len__, TMP_BUF_MAX)` and naming identifiers
> more descriptively (where appropriate).
> 
> A few sections were nested pretty deeply and have been
> replaced with shallower (but semantically equivalent) logic.
> 
> In addition, simplify and coalesce a few of the
> return paths / loop conditionals and correct a few
> pointless Initializations, redundant parentheses/break
> statements, and inconsistently indented line.

That's a lot of different things to do all in a single patch.

Please break this up into a patch series, doing only one logical "thing"
per patch.

thanks,

greg k-h
