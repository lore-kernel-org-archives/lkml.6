Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C86C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2412082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544437477;
	bh=iEKb4Hr2vAinH1+xyU9idv7m8d8jP14OFscmcipZB5A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=11jbD4iGI+7BLg9BvGNDBvg5/08nxQ9XNnvNN2gCfqj30VLekkPFNHtq/l1CeqkGI
	 E/uQitS4zmKY6r587tp+QwXTYapBycF1tvmehKWUV6JktehGr40ueu5lwKADDb8F0D
	 RkzMLAMHdHddWkp7XVIvK+xNmzkVnJ3d3DPSyg10=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2412082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeLJKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:24:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:48866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbeLJKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:24:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5728AEB2;
        Mon, 10 Dec 2018 10:24:33 +0000 (UTC)
Date:   Mon, 10 Dec 2018 11:24:32 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
In-Reply-To: <CAN+gG=ErkuyRNprp0b7i93pqPH2J4Tz1KTyVJTLTmBWJV2NeVg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1812101124100.17216@cbobk.fhfr.pm>
References: <20181205230336.GA23462@jelly> <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com> <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com> <20181206224605.GA27899@jelly> <20181206225619.GA34001@dtor-ws>
 <CAN+gG=ErkuyRNprp0b7i93pqPH2J4Tz1KTyVJTLTmBWJV2NeVg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Benjamin Tissoires wrote:

> OK, thanks Dmitry.
> 
> Jiri, I have pushed this in for-4.20/upstream-fixes.
> 
> I think the branch has enough now to justify a PR towards Linus.

Agreed. I will be sending it today. Thanks,

-- 
Jiri Kosina
SUSE Labs

