Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79809C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176EA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176EA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeJaW35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:29:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53044 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJaW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:29:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9VDVTnv062591;
        Wed, 31 Oct 2018 08:31:29 -0500
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9VDVT7P045375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 08:31:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 31
 Oct 2018 08:31:29 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 31 Oct 2018 08:31:28 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9VDVQe2011648;
        Wed, 31 Oct 2018 08:31:27 -0500
Subject: Re: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>
References: <20181016060402.18756-1-vigneshr@ti.com>
 <20181016111541.GE8852@ulmo>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
Date:   Wed, 31 Oct 2018 19:02:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016111541.GE8852@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 16/10/18 4:45 PM, Thierry Reding wrote:
> On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
>> Couple of patches to enable pwm-tiecap driver to be used with TI's new
>> AM654 platforms.
>>
>> Vignesh R (2):
>>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
>>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
>>
>>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>>  drivers/pwm/Kconfig                                  | 5 ++---
>>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Applied, thanks.
> 

I could not see this patch series in pwm tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
Is this queued for v4.20?

-- 
Regards
Vignesh
