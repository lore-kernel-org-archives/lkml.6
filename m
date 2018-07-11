Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D26C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5155A20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5155A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbeGKP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:28:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18839 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbeGKP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:28:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4620e10000>; Wed, 11 Jul 2018 08:23:13 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 08:23:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 08:23:18 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 15:23:16 +0000
Subject: Re: [PATCH v2 3/7] soc/tegra: pmc: Implement
 tegra_io_pad_is_powered()
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531317693-3520-1-git-send-email-avienamo@nvidia.com>
 <1531317693-3520-4-git-send-email-avienamo@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3ced704b-2a8b-b78c-3b1e-6c2d7562edcc@nvidia.com>
Date:   Wed, 11 Jul 2018 16:23:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531317693-3520-4-git-send-email-avienamo@nvidia.com>
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


On 11/07/18 15:01, Aapo Vienamo wrote:
> Implement a function to query whether a pad is in deep power down mode.
Can you elaborate on why this public function is needed and who will be
using this?

Cheers
Jon

-- 
nvpublic
