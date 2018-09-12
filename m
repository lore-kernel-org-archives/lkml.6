Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442AC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90862087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90862087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeIMFDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:03:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:58928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeIMFDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:03:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 16:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="89529279"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2018 16:56:42 -0700
Date:   Wed, 12 Sep 2018 16:54:08 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Xiaochen Shen <xiaochen.shen@intel.com>
Subject: Re: [PATCH] x86/intel_rdt: Show missing resctrl mount options
Message-ID: <20180912235408.GA59943@romley-ivt3.sc.intel.com>
References: <1536110984-154868-1-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1809081405580.1402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809081405580.1402@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 02:07:41PM +0200, Thomas Gleixner wrote:
> On Tue, 4 Sep 2018, Fenghua Yu wrote:
> > 
> > Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Sigh. Am I supposed to assume that this patch is authored by Xiaochen?

Yes, Xiaochen is the author. Sorry for the mistake.

I just now sent out v2 patch to use right author Xiaochen in the patch.

Thanks.

-Fenghua
