Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4725BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146620672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g2oexKlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeLKFyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:54:44 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19816 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLKFyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:54:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0f51210000>; Mon, 10 Dec 2018 21:54:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Dec 2018 21:54:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Dec 2018 21:54:43 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 05:54:41 +0000
Subject: Re: [PATCH v5 0/3] Fixes for Tegra soctherm
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1543816523-10525-1-git-send-email-wni@nvidia.com>
 <56fd1fc8-f70f-2d86-6a05-799a7bd0ff7e@nvidia.com>
Message-ID: <7c82b0cc-9d96-2d94-3428-ad75a0600fd8@nvidia.com>
Date:   Tue, 11 Dec 2018 13:54:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <56fd1fc8-f70f-2d86-6a05-799a7bd0ff7e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544507681; bh=8LBseuUmvbF/uKqq68CqrTen/KGgrxOU3+9/ZOtjFgM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=g2oexKlmwcTHejrTkVcIN/VdkfkSOFIMyld87N7ZAvYLlhCuf9OAts4gTg9ikbEGb
         M9lukF+cRyQYJqrSuMxZm8j4emVk/U6sJWm1Cp7+ExF0nNZT7wRW5lD5GB+pvEdR3T
         LUq55eod7/xyRG5St1vnML1tgBBI50xc3Jj/p86RQa7uptWWoFGeL223uDftV50Pm2
         4zbjyE5SQgMBO3VEC0BLpr4zOC/4HIW+iUk6JhskNqMUVxj8+OnlrOdvz/KBKGlDJ8
         iSE+Ch/bfqovJ6ECS9Qfg6kOZMYUCV24fNru5csUyrbest9OxqUOnrlKY+7dAoW4l/
         X0NwbMMZPrXpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui & Eduardo,
It looks no more comments on this version, could you please take this
serial?

Thanks.
Wei.

On 5/12/2018 4:31 PM, Wei Ni wrote:
> Hi,
> Does there have any comments on this serial?
> 
> Thanks.
> Wei.
> 
> On 3/12/2018 1:55 PM, Wei Ni wrote:
>> This series fixed some issues for Tegra soctherm
>>
>> Main changes from v4:
>> 1. fixed for the parsing sensor id.
>> 2. keep warning for missing critical trips.
>>
>> Main changes from v3:
>> 1. updated codes for parsing sensor id, per Thierry's comments
>>
>> Main changes from v2:
>> 1. add codes to parse sensor id to avoid registration
>> failure.
>>
>> Main changes from v1:
>> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
>> "thermal: tegra: fix memory allocation".
>> 2. Print out the sensor name when register failed.
>> 2. Remove patch "thermal: tegra: fix coverity defect"
>>
>> Wei Ni (3):
>>   thermal: tegra: remove unnecessary warnings
>>   thermal: tegra: fix memory allocation
>>   thermal: tegra: parse sensor id before sensor register
>>
>>  drivers/thermal/tegra/soctherm.c | 51 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 46 insertions(+), 5 deletions(-)
>>
