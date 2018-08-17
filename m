Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B22188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0B22188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHQSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:43:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:9603 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeHQSn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:43:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 08:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,251,1531810800"; 
   d="scan'208";a="66020821"
Received: from mmena-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.254])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2018 08:40:06 -0700
Date:   Fri, 17 Aug 2018 08:40:06 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Current LTS and their EOL
Message-ID: <20180817154006.GA3725@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Ben, and all

Is https://www.kernel.org/category/releases.html updated in terms of EOL?

Some news out of Linaro conference [2] generated a lot of doubts and questions
around.

Specially because on the way it was stated by the news 3.16 wouldn't be active
anymore. So I'm not sure about the news, but I'd like confirmation from you about
expected EOL.

[2] https://itsfoss.com/linux-lts-kernel-six-years/

Thanks in advance,
Rodrigo.
