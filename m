Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B52064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7B52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbeGXQaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:30:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18131 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:30:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b57445a0001>; Tue, 24 Jul 2018 08:23:06 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 24 Jul 2018 08:23:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 24 Jul 2018 08:23:03 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 15:23:01 +0000
Subject: Re: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
 <c8a963fa-70c8-ea79-3c30-69bf723fb764@nvidia.com>
 <1531895430.16896.2.camel@toradex.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <197120a6-4c75-14ca-5d46-0e6cfbbb1ebd@nvidia.com>
Date:   Tue, 24 Jul 2018 16:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531895430.16896.2.camel@toradex.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/07/18 07:30, Marcel Ziswiler wrote:
> On Tue, 2018-07-17 at 13:57 +0300, Mikko Perttunen wrote:
>> Thanks!
> 
> Yes, that fixes Apalis TK1 crashing as of late as well.
> 
>> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Can someone pick this up? Without this some Tegra boards cannot boot.

Thanks!
Jon

-- 
nvpublic
