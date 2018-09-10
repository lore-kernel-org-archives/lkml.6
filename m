Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12BAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203620892
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5203620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeIJVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:18:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39972 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:18:45 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzOyc-0004dQ-CR; Mon, 10 Sep 2018 18:23:50 +0200
Date:   Mon, 10 Sep 2018 18:23:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
In-Reply-To: <20180910140710.GR5565@intel.com>
Message-ID: <alpine.DEB.2.21.1809101816320.1419@nanos.tec.linutronix.de>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com> <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de> <20180910140710.GR5565@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1878809270-1536596630=:1419"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1878809270-1536596630=:1419
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 10 Sep 2018, Ville Syrjälä wrote:
> On Mon, Sep 10, 2018 at 02:48:45PM +0200, Thomas Gleixner wrote:
> > On Mon, 10 Sep 2018, Ville Syrjala wrote:
> > I asked for that before and I really do not understand why you do not even
> > make an attempt to report an issue first and allow the developers to work
> > with you to figure out what exactly is the problem. All you do is to send
> > an revert patch with a changelog which describes symptoms and probably
> > breaks more than it cures. Not really helpful, really.
> 
> You're reading way too much into this. The revert is just a point to
> start the conversion. I've found that it's the best way to get the
> attention of the relevant developers. Other kind of regression
> reports have an unfortunate habit of disappearing into /dev/null.

1) My workflow makes things tagged as BUG and REGRESSION urgent
   automatically while [PATCH] just is queued to the normal pile of
   backlog, i.e. at the end. It just sprang into my eyes by chance, but in
   general you might just get the contrary of what you are looking for.

2) A proper bug report with proper information (it's documented what should
   be provided), is way more worth than a patch with a mostly useless
   change log, which forces me to ask for the proper information instead of
   having it right away.

Thanks,

	tglx


--8323329-1878809270-1536596630=:1419--
