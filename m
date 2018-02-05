Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeBEOtA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeBEOsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:48:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7577321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Feb 2018 11:48:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resend, PATCH v2] perf tools: substitute yet another strtoull()
Message-ID: <20180205144850.GA10162@kernel.org>
References: <20180129130359.1490-1-andriy.shevchenko@linux.intel.com>
 <20180129154605.GA7759@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129154605.GA7759@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 29, 2018 at 04:46:05PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 29, 2018 at 03:03:59PM +0200, Andy Shevchenko wrote:
> > Instead of home grown function let's use what library provides us.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks, applied.

- Arnaldo
