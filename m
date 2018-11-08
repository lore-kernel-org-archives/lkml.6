Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3126C2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3126C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKHWDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:03:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39834 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeKHWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:03:47 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8CSKd5053449;
        Thu, 8 Nov 2018 06:28:20 -0600
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8CSKun036524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 06:28:20 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 06:28:19 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 06:28:19 -0600
Received: from [172.22.219.239] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8CSGW6005881;
        Thu, 8 Nov 2018 06:28:17 -0600
From:   Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181108091931.3342-1-vigneshr@ti.com>
 <20181108091931.3342-4-vigneshr@ti.com> <20181108092320.GC951@kunai>
Message-ID: <d57ace5e-d42a-0a0e-2813-4a25cc6b37bb@ti.com>
Date:   Thu, 8 Nov 2018 17:58:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108092320.GC951@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/18 2:53 PM, Wolfram Sang wrote:
> On Thu, Nov 08, 2018 at 02:49:31PM +0530, Vignesh R wrote:
>> Add separate entry for i2c-omap and add my name as reviewer for this
>> driver.
> 
> Thanks for stepping up, yet out of curiosity: why not maintainer?
> 

I wasn't sure whether the convention is to add Reviewer or Maintainer
entry for individual driver. I would be glad to change entry to maintainer.


-- 
Regards
Vignesh
