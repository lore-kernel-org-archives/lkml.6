Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC5FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2249F24997
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmUPIP3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2249F24997
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbeGCKIq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933660AbeGCKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:08:45 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B7921A0C;
        Tue,  3 Jul 2018 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530612524;
        bh=bmqch2fSogfXOTGO2W77/hBor23kKPfWEmxEVLcf6UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmUPIP3Xi7t52pYNJZy4teT1mHRhl3jBmiMBmWjK3VRZXWOkYafTeEz6uXe/7fn5N
         Lx7I/OQmV9nkHarba8oHSB7tFUZr+L3Y87eCbXu2CWXmoj48CEgmlZeDuCFWl4dW2Y
         54Ln1EzeDEwt7h4PkhnMTO3HrmnQQFuKH96zpXC4=
Date:   Tue, 3 Jul 2018 18:08:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] arm64: dts: freescale: Add missing cooling device
 properties for CPUs
Message-ID: <20180703100827.GP4348@dragon>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
 <CAAQ0ZWRsroAAKRyxdd9ZCreriAjdBecmJy01sRy+6i_iQsMKgw@mail.gmail.com>
 <20180703083431.l4rbnept2lwjocol@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703083431.l4rbnept2lwjocol@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:04:31PM +0530, Viresh Kumar wrote:
> On 03-07-18, 15:34, Shawn Guo wrote:
> > Please use my kernel.org email address for future patches.
> 
> As there were many patches I relied on get_maintainers to do that
> stuff and it didn't pick you up by default. Maybe try fixing
> MAINTAINERS to add an entry against your email id ?

Good point.  Will patch MAINTAINERS for arm64 freescale DTS.

Shawn
