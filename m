Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED6D20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED6D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLAIJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:09:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:34144 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAIJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:09:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="121030962"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2018 12:59:12 -0800
Date:   Fri, 30 Nov 2018 12:59:12 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, Sam Creasey <sammy@sammy.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH RFC 04/15] m68k: replace **** with a hug
Message-ID: <20181130205912.GB22338@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-5-jarkko.sakkinen@linux.intel.com>
 <e1571a6d-b71a-3324-1d73-fa9e74a7d687@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1571a6d-b71a-3324-1d73-fa9e74a7d687@physik.fu-berlin.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:44:24PM +0100, John Paul Adrian Glaubitz wrote:
> On 11/30/18 8:27 PM, Jarkko Sakkinen wrote:
> > In order to comply with the CoC, replace **** with a hug.
> > 
> > -/* master list of VME vectors -- don't fuck with this */
> > +/* master list of VME vectors -- don't hug with this */
> 
> Never in my dreams would I have expected that the dystopia predicted
> in "Demolition Man" would ever come true and that so early.
> 
> I'm waiting for the automatic punishment machines which spit out tickets
> whenever someone in their proximity utters a swearword.

Sorry I had 10h flight, internet connection not properly working and too
much time :-) I thought that with the new CoC I could not grep the
f-word from the kernel tree but there it was...

/Jarkko
