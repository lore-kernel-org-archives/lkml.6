Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303AB2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303AB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeLAJFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:05:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:61821 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeLAJFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:05:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 13:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="121363483"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2018 13:54:29 -0800
Date:   Fri, 30 Nov 2018 13:54:29 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Miller <davem@davemloft.net>
Cc:     James.Bottomley@HansenPartnership.com, dave@stgolabs.net,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, dja@axtens.net,
        linux@dominikbrodowski.net, dri-devel@lists.freedesktop.org,
        edumazet@google.com, federico.vaga@vaga.pv.it,
        geert+renesas@glider.be, deller@gmx.de, corbet@lwn.net,
        kumba@gentoo.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, paul.burton@mips.com, pmladek@suse.com,
        robh@kernel.org, sean.wang@mediatek.com,
        sergey.senozhatsky@gmail.com, shannon.nelson@oracle.com,
        sbrivio@redhat.com, rostedt@goodmis.org, me@tobin.cc,
        makita.toshiaki@lab.ntt.co.jp, willemb@google.com, yhs@fb.com,
        yanjun.zhu@oracle.com
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
Message-ID: <20181130215429.GA24415@linux.intel.com>
References: <20181130205521.GA21006@linux.intel.com>
 <1543611662.3031.20.camel@HansenPartnership.com>
 <20181130214405.GG23772@linux.intel.com>
 <20181130.134808.1785785556132211918.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130.134808.1785785556132211918.davem@davemloft.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:48:08PM -0800, David Miller wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Date: Fri, 30 Nov 2018 13:44:05 -0800
> 
> > On Fri, Nov 30, 2018 at 01:01:02PM -0800, James Bottomley wrote:
> >> No because use of what some people consider to be bad language isn't
> >> necessarily abusive, offensive or degrading.  Our most heavily censored
> >> medium is TV and "fuck" is now considered acceptable in certain
> >> contexts on most channels in the UK and EU.
> > 
> > This makes following the CoC extremely hard to a non-native speaker as
> > it is not too explicit on what is OK and what is not. I did through the
> > whole thing with an eye glass and this what I deduced from it.
> 
> It would be helpful if you could explain what part of the language
> is unclear wrt. explaining how CoC does not apply to existing code.
> 
> That part seems very explicit to me.

Well, now that I re-read it, it was this part to be exact:

"Maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other
contributions that are not aligned to this Code of Conduct, or to ban
temporarily or permanently any contributor for other behaviors that they
deem inappropriate, threatening, offensive, or harmful."

How this should be interpreted?

I have not really followed the previous CoC discussions as I try to
always use polite language so I'm sorry if this duplicate.

/Jarkko
