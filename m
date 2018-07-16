Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A12208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A12208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeGPIbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:31:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:12466 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeGPIbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:31:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 01:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="67301085"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.135])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2018 01:05:08 -0700
Date:   Mon, 16 Jul 2018 16:05:08 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Xiao Ni <xni@redhat.com>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [LKP] [lkp-robot] [MD] 5a409b4f56: aim7.jobs-per-min -27.5%
 regression
Message-ID: <20180716080507.GB16185@intel.com>
References: <20180604064203.GG16472@yexl-desktop>
 <20180716075430.GA16185@intel.com>
 <1483728110.50978686.1531728104115.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483728110.50978686.1531728104115.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 04:01:44AM -0400, Xiao Ni wrote:
> Hi Aaron
> 
> I have no update for this yet. I'll have a look this week and give response later.

Good to hear this, thanks for your time.
