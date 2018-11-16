Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED162087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED162087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbeKQAqY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:46:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:50190 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbeKQAqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:46:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 06:33:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="274550652"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.4.118])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2018 06:33:41 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "'igvt-g@lists.01.org'" <igvt-g@lists.01.org>,
        "'intel-gfx@lists.freedesktop.org'" <intel-gfx@lists.freedesktop.org>,
        "'kvm@vger.kernel.org'" <kvm@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Xu, Terrence" <terrence.xu@intel.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <EE92950F97EE42469CA4F508D4691F5E3CD21CFA@SHSMSX104.ccr.corp.intel.com>
Cc:     "Li, Susie" <susie.li@intel.com>,
        "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
        "Cowperthwaite, David J" <david.j.cowperthwaite@intel.com>,
        "Reddy, Raghuveer" <raghuveer.reddy@intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Yuan, Hang" <hang.yuan@intel.com>,
        "Lv, Zhiyuan" <zhiyuan.lv@intel.com>,
        "Jin, Gordon" <gordon.jin@intel.com>,
        "Downs, Mike" <mike.downs@intel.com>,
        "Wang, Hongbo" <hongbo.wang@intel.com>
References: <EE92950F97EE42469CA4F508D4691F5E3CD21CFA@SHSMSX104.ccr.corp.intel.com>
Message-ID: <154237881992.14497.12677363726001385709@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [GVT-g] [ANNOUNCE] 2018-Q3 release of KVMGT (Intel GVT-g for
 KVM)
Date:   Fri, 16 Nov 2018 16:33:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xu, Terrence (2018-10-19 10:04:47)
> Platform Support:
> 
> -    Server platforms: Intel(r) Xeon(r) E3_v4, E3_v5 and E3_v6 with Intel
> Graphics processor
> 
> -    Client platforms: Intel(r) Core(tm) 5th generation (code name: Broadwell),
> 6th generation (code name: Skylake), 7th generation (code name: Kabylake) and
> 7th SoC generation (code name: Broxton), the Broxton is new supported platform

Does this mean that all SKUs from those platforms are supported so that when
users report bugs, they will be worked on?

Regards, Joonas
