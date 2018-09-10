Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3601820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeIJUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:04:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:50940 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeIJUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:04:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 08:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="90452461"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 10 Sep 2018 08:09:10 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Sep 2018 18:09:10 +0300
Date:   Mon, 10 Sep 2018 18:09:10 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180910150910.GS5565@intel.com>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
 <20180910140710.GR5565@intel.com>
 <20180910144720.GA28349@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910144720.GA28349@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:47:20PM +0200, Borislav Petkov wrote:
> On Mon, Sep 10, 2018 at 05:07:10PM +0300, Ville Syrjälä wrote:
> > You're reading way too much into this. The revert is just a point to
> > start the conversion. I've found that it's the best way to get the
> > attention of the relevant developers. Other kind of regression
> > reports have an unfortunate habit of disappearing into /dev/null.
> 
> That's some strange "logic".
> 
> You're sending a patch which has "[PATCH]" in the subject but now you
> say it is not really a patch but only a way to get people's attention?!?

But it is a patch, and if it happens to get accepted as is so be
it. If not, it's a good place where to start the conversation on
how to fix the bug in another way.

You guys seem to have a notion that anything which says '[PATCH]'
is somehow final. In my book any patch is up for debate. Nothing
special about this one in that regard.

-- 
Ville Syrjälä
Intel
