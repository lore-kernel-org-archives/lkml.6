Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DDD2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DDD2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeGYPkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:40:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13772 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbeGYPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:40:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5889150000>; Wed, 25 Jul 2018 07:28:37 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 25 Jul 2018 07:28:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 25 Jul 2018 07:28:31 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 25 Jul
 2018 14:28:32 +0000
Date:   Wed, 25 Jul 2018 17:28:26 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Peter Geis <pgwipeout@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] Update the pad autocal procedure
Message-ID: <20180725172826.2658feb5@dhcp-10-21-25-168>
In-Reply-To: <f41a905c-5364-14a5-122b-09cbd1efa2f9@gmail.com>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
        <f41a905c-5364-14a5-122b-09cbd1efa2f9@gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 08:06:18 -0400
Peter Geis <pgwipeout@gmail.com> wrote:

> On 07/24/2018 10:29 AM, Aapo Vienamo wrote:
> > Aapo Vienamo (10):
> > 
> >    mmc: tegra: Enable pad calibration on Tegra210 and Tegra186  
> 
> Good Morning,
> 
> You seem to be missing patch 10/10.
> Checked 
> https://lore.kernel.org/patchwork/project/lkml/list/?series=360525 to be 
> sure.

Missing patch sent. Thanks for pointing that out.

 -Aapo
