Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF17ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C520818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37C520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeKIAi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:38:29 -0500
Received: from muru.com ([72.249.23.125]:53406 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeKIAi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:38:28 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 135FC8047;
        Thu,  8 Nov 2018 15:02:33 +0000 (UTC)
Date:   Thu, 8 Nov 2018 07:02:31 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
Message-ID: <20181108150231.GF56134@atomide.com>
References: <20181108091931.3342-1-vigneshr@ti.com>
 <20181108091931.3342-4-vigneshr@ti.com>
 <20181108092320.GC951@kunai>
 <d57ace5e-d42a-0a0e-2813-4a25cc6b37bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57ace5e-d42a-0a0e-2813-4a25cc6b37bb@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [181108 12:28]:
> 
> 
> On 08/11/18 2:53 PM, Wolfram Sang wrote:
> > On Thu, Nov 08, 2018 at 02:49:31PM +0530, Vignesh R wrote:
> >> Add separate entry for i2c-omap and add my name as reviewer for this
> >> driver.
> > 
> > Thanks for stepping up, yet out of curiosity: why not maintainer?
> > 
> 
> I wasn't sure whether the convention is to add Reviewer or Maintainer
> entry for individual driver. I would be glad to change entry to maintainer.

Great, yes please do!

Regards,

Tony
