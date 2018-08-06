Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87732C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3950C219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3950C219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeHFIuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:50:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:44262 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725739AbeHFIuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:50:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 23:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="78806736"
Received: from zlv7-mobl.ccr.corp.intel.com ([10.255.28.235])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2018 23:29:39 -0700
Message-ID: <1533536978.2158.86.camel@intel.com>
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
From:   Zhang Rui <rui.zhang@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Aug 2018 14:29:38 +0800
In-Reply-To: <20180803084000.73ofs6cttnqc6uiq@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
         <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
         <1533016858.2550.21.camel@intel.com>
         <20180803084000.73ofs6cttnqc6uiq@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 五, 2018-08-03 at 14:10 +0530, Viresh Kumar wrote:
> On 31-07-18, 14:00, Zhang Rui wrote:
> > 
> > I suppose this patch should go via Eduardo' tree.
> > Eduardo, can you please take a look at this patch set?
> Zhang,
> 
> Since Eduardo isn't replying, will it be possible for you to pick it
> up as I
> don't want to miss 4.19-rc1.
> 
Okay, I will keep queue it in my tree first.

thanks,
rui
