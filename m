Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF0C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C01217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfAXTt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:49:28 -0500
Received: from muru.com ([72.249.23.125]:35258 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732086AbfAXTtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:49:24 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CF2048181;
        Thu, 24 Jan 2019 19:49:31 +0000 (UTC)
Date:   Thu, 24 Jan 2019 11:49:20 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
Message-ID: <20190124194920.GU5720@atomide.com>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
 <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
 <20190124124032.aqp4ctqkpozbttwl@kahuna>
 <6b10e04d-47b7-09ed-9d03-d37732569b92@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b10e04d-47b7-09ed-9d03-d37732569b92@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190124 19:46]:
> I am not currently publishing -next branch, but I can start tracking one.

Yes please do as the patches should be sitting in
Linux next for at least two weeks before merging.
And there can be often delays of multiple days with
getting patches merged to armsoc next branch.

Regards,

Tony
