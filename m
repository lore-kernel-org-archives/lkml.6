Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeBRVwK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 16:52:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43633 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751549AbeBRVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 16:52:09 -0500
X-ME-Sender: <xms:iPWJWrWdOY4HCf7Eu6nHUQ0bfM1V86KqDPBP8Cx2t_BFeXKUBHs0nw>
Date: Mon, 19 Feb 2018 08:52:04 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@rasmusvillemoes.dk, Petr Mladek <pmladek@suse.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/9] lib/test_printf: Mark big constant with ULL
Message-ID: <20180218215204.GB22942@eros>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:07:03PM +0200, Andy Shevchenko wrote:
...

Hi Andy,

What tree does this set apply to please?  I tried mainline rc1 and
next-20180216.  Happy to see some code duplication removal from
vsprintf.c :)

thanks,
Tobin.
