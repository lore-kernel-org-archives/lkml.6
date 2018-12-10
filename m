Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A562C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45662086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45662086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeLJNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:50:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33712 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeLJNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:50:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADnwOx014245;
        Mon, 10 Dec 2018 07:49:58 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADnw5S074360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 07:49:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:49:58 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:49:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADnwdo024647;
        Mon, 10 Dec 2018 07:49:58 -0600
Date:   Mon, 10 Dec 2018 07:49:38 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <kishon@ti.com>,
        <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
Message-ID: <20181210134938.hh4543yig6fngyrj@kahuna>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan>
 <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:10-20181210, Sekhar Nori wrote:
> 
> I think you can rely on the author to tell you when something is
> actually ready to be merged (and you can tell him/her to remind you).
> 
> For the review itself, doing it by having a look at the dependencies
> mentioned in the cover letter (like available for this series) should be
> good enough (I feel).

Dependencies can be for multiple things.. anyways, Sigh..

> I am not sure if there is a need to post an "RFC version", and then
> follow it up with an actual "PATCH version" once dependencies are
> cleared though.
Heads up for the maintainers will be useful. For example:

Will be good to state in cover-letter instead of just stating
https://patchwork.kernel.org/cover/10717641/

State:

Bindings are in discussion[2], will confirm if approved and will
check if rebase is necessary.

This will indicate to the maintainer that patches are preliminary and
subject to change depending on bindings discussion and developer has
taken ownership of maintaining patch sanity.

-- 
Regards,
Nishanth Menon
