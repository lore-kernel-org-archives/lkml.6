Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0990C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CD820879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025648;
	bh=u5UuxBRh42uEo9ULYO5NsmpEcnbrk3DReKNA1hzrThA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iRfpkgBcKoLC+wSdiOoyFYxyY1CkZiHokGpkIkqE/nI7JLhbXbSYR38mU/HdxEpFr
	 wWemy70Bjbxyo3y99+jyNYMaqL+c6tUFQxCEaDoAh/5uzP00K6nBgnkX6tUj96MQVy
	 EJshVVO8F0gj+Ny7klsfVIT96/aH0yzXmLrK7I7g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CD820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeLEQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbeLEQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:00:47 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AA120850;
        Wed,  5 Dec 2018 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544025646;
        bh=u5UuxBRh42uEo9ULYO5NsmpEcnbrk3DReKNA1hzrThA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haCdcNkuRyydUXgb133QDgc7sBd6Jsu2Z7sd8AUjQoSTSUoETLzHBLFfpzcAX/wvb
         dff0NzNO+XF/3JNQi/Ffd/YCtfLm+y0mnCTkI6dPDR9iPeTP6hGRVUS928FsiaWSiq
         GB4SDPAAyvwwK9/ogCsnxGi1vZzaYqi9qvvlKUtY=
Date:   Wed, 5 Dec 2018 11:00:42 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Connor McAdams <conmanx360@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH AUTOSEL 4.19 40/68] ALSA: hda/ca0132 - Add new ZxR quirk
Message-ID: <20181205160042.GB1992@sasha-vm>
References: <20181129055559.159228-1-sashal@kernel.org>
 <20181129055559.159228-40-sashal@kernel.org>
 <CAM8Agx1xcN1P9y7r+Y7xgbt5Dqyk3ESU0QU7Ogc+c3iBsiHetA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAM8Agx1xcN1P9y7r+Y7xgbt5Dqyk3ESU0QU7Ogc+c3iBsiHetA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:51:55AM -0500, Connor McAdams wrote:
>This patch won't break anything, but it also won't fix anything
>either. Not sure if that matters or not.

I'll remove it then, thank you.

--
Thanks,
Sasha
