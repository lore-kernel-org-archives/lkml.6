Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9FC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821C621C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C621C36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeHIFSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:18:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:35987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbeHIFSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:18:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 19:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,213,1531810800"; 
   d="scan'208";a="63706772"
Received: from sofia.sh.intel.com (HELO sofia) ([10.239.147.112])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2018 19:55:18 -0700
Date:   Thu, 9 Aug 2018 10:54:28 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     broonie@opensource.wolfsonmicro.com, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        changcheng.liu@intel.com
Subject: [PATCH v2 0/2] ASoC: trace: format file and add trace field
Message-ID: <20180809025428.GD161967@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Some typecast are not needed 
2. trace dapm type in snd_soc_dapm_widget class event

Liu Changcheng (2):
  ASoC: trace: remove unnecessary typecast
  ASoC: trace: track dapm type in snd_soc_dapm_widget

v1->v2
  correct code style to meet kernel requirement.

 include/trace/events/asoc.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.7.4

