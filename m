Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D99E222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438844AbfBNPCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:02:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:10944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390644AbfBNPCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:02:43 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 07:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="143455940"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2019 07:02:42 -0800
Date:   Thu, 14 Feb 2019 06:56:15 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Message-ID: <20190214145615.GA116987@romley-ivt3.sc.intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 06:50:29PM -0800, Fenghua Yu wrote:
> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.

Hi, Thomas, Ingo, and Borislav,

Do you have any comments on the resctrl selftest tool?

Do you have any plan to push the patches to upstream?

The tool has been tested on both Intel RDT and AMD QoS.

Thanks.

-Fenghua
