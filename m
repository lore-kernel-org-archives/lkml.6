Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA67C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6CD2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548252230;
	bh=ap8h6oG8+q3aCOcOLdhlE6/+rWHc/KqbXv9kX1o8sm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1JDAKtMGWHEl1wlL1qCwFH7otm/eDg9XzvyKFH2T8WzIZlXz1//9FArj5gqCFKMHY
	 hC9nM7sWXZNS2OpL8AHXZsitXGLoP6gZKRI0D77DEXS40ileB5ZRI5apZBbdL0kSx6
	 PpjbMRBPslbZUmjMAjSzw3YNQgqo31nwOARsYfj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfAWODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAWODr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:03:47 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC802133D;
        Wed, 23 Jan 2019 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548252227;
        bh=ap8h6oG8+q3aCOcOLdhlE6/+rWHc/KqbXv9kX1o8sm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLm7KNDrS+Hl0vgdH+ErywmQaXT/JXjNqGAuP/Vgn6Y+A3/j0dckVpGy2TIoUdZdv
         LQ75eMaV0s2UEj/pv1WzNa3kxjkRMIVNdu/YczIcL/4NYlAq+CfFta1FqDfgtOLc/f
         V1CbjHxYO4ajYkhDan9zadH/LMP6Hs6aw+Gb96Bc=
Date:   Wed, 23 Jan 2019 09:03:46 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.20 034/117] drm/amdgpu: Correct
 get_crtc_scanoutpos behavior when vpos >= vtotal
Message-ID: <20190123140346.GJ202535@sasha-vm>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-34-sashal@kernel.org>
 <199e52c4-7e19-03c0-2d60-c638dda86bd4@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <199e52c4-7e19-03c0-2d60-c638dda86bd4@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:20:49AM +0100, Michel Dänzer wrote:
>On 2019-01-08 8:25 p.m., Sasha Levin wrote:
>> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>
>> [ Upstream commit 520f08df45fbe300ed650da786a74093d658b7e1 ]
>>
>> When variable refresh rate is active [...]
>
>Variable refresh rate (FreeSync) support is only landing in 5.0,
>therefore this fix isn't needed in older kernels.

I'll drop it, thank you.

--
Thanks,
Sasha
