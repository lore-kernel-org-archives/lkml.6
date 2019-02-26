Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987E121850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfBZPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:51:14 -0500
Received: from muru.com ([72.249.23.125]:40802 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfBZPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:51:14 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4983480CD;
        Tue, 26 Feb 2019 15:51:25 +0000 (UTC)
Date:   Tue, 26 Feb 2019 07:51:11 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: cpcap: Remove unused vsel_shift from
 struct cpcap_regulator
Message-ID: <20190226155111.GB39872@atomide.com>
References: <20190226055230.25482-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226055230.25482-1-axel.lin@ingics.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Axel Lin <axel.lin@ingics.com> [190226 05:52]:
> This driver uses regulator_get/set_voltage_sel_regmap so it does not use
> vsel_shift. Actually, vsel_shift can be calculated by vsel_mask setting.

Thanks for doing this, still works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
