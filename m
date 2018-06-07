Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XNgTG5OTGFsNHQAAmS7hNA
	; Thu, 07 Jun 2018 02:11:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 056C6608BA; Thu,  7 Jun 2018 02:11:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 60283607DC;
	Thu,  7 Jun 2018 02:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60283607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeFGCLN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:11:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:51382 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbeFGCLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:11:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 19:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,485,1520924400";
   d="scan'208";a="61058734"
Received: from unknown (HELO localhost) ([10.238.157.61])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2018 19:11:01 -0700
Date: Thu, 7 Jun 2018 10:00:01 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v5 01/28] docs: fpga: add a document for FPGA Device
 Feature List (DFL) Framework Overview
Message-ID: <20180607020001.GA9260@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-2-git-send-email-hao.wu@intel.com>
 <CANk1AXRAsSE2oMrAiTsmScPUk1vD9L_Yfjy8p4jivSm0VYrbxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRAsSE2oMrAiTsmScPUk1vD9L_Yfjy8p4jivSm0VYrbxw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:16:03AM -0500, Alan Tull wrote:
> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> I've acked the remaining patches with some changes requested.  In your
> v6, please add a patch to add yourself to the MAINTAINERS file or
> whoever is planning on maintaining fpga/drivers/*dfl*

Hi Alan,

Sure, I will fix these in the next version. Thanks a lot for the review.

Hao

> 
> > Add a document for FPGA Device Feature List (DFL) Framework Overview.
> >
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> 
> Thanks,
> Alan
