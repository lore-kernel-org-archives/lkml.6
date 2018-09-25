Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624A620C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624A620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeIYK0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:26:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:16038 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeIYK0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:26:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 21:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,300,1534834800"; 
   d="scan'208";a="77020493"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.167])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2018 21:21:02 -0700
Date:   Tue, 25 Sep 2018 12:32:38 +0800
From:   Philip Li <philip.li@intel.com>
To:     kbuild-all@01.org, lkp@01.org, LKML <linux-kernel@vger.kernel.org>
Subject: [0-Day CI notification] 0-Day CI test service will be unavailable
 from Sep 30 to Oct 8
Message-ID: <20180925043238.GA14135@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this is Philip who maintains the 0-Day CI test service. Thanks for
subscribing to the service. We will have site level power down during China
national holiday, so the service will be unavailable from Asia Pacific Time
Sep 30 5PM to Oct 8 5PM. We will recover it as soon as we can. Sorry for any
inconvenience caused during this period.

Thanks
