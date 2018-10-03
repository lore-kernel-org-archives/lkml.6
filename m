Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38140C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB07720835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KynTYKZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB07720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCTMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:12:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56892 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeJCTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:12:43 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93COSBC107821;
        Wed, 3 Oct 2018 07:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538569468;
        bh=+3o92bx725ADkwPDTsfdbDeUaKuyYZ+1Ik8PK2YKSAU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KynTYKZAlV13lnr4M1smIwGbFaNVj0MzL80Jolw2p6JX87CqWwhfZduVIJNCdo7af
         Dai0J35bwMxM/4ephMBnsSg4bGPT+UYr1oeqa2IeT78aM3vCppIKkJj5AoWI0CrenH
         CJoORFvYqzJImKu8V7ZLkrXboiODh2HPjtfPU/jo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93COSX3014601;
        Wed, 3 Oct 2018 07:24:28 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 07:24:28 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 07:24:28 -0500
Received: from [172.22.137.207] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93COS4A008608;
        Wed, 3 Oct 2018 07:24:28 -0500
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com> <20181002072827.GA19677@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <fef2c612-ac35-126e-669e-335fb3075f64@ti.com>
Date:   Wed, 3 Oct 2018 07:24:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002072827.GA19677@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 10/02/2018 02:28 AM, Pavel Machek wrote:
> On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
>> Remove support for the LM3697 LED device
>> from the ti-lmu.  The LM3697 will be supported
>> via a stand alone LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> NAK, for reasons I explained before. Please add it to the patch so
> that it does not get applied by mistake. Ouch and AFAICT Rob was not
> happy with this either.
> 
> Yes, you are creating new drivers, ok; but that does _not_ mean you
> should create new binding.

I am copying my comment here on the review of this original binding for
records

I found the review or at least the reference for the ti-lmu.txt binding.

https://lore.kernel.org/patchwork/patch/764180/

Does not appear that the binding was sent to the device tree mail list.
(Maybe that email list did not exist in Feb 2017).

Especially with the amount of change that is being submitted in the
newer patchsets.

<new content>
Having found this submission and no comments on the review I would think
we need to take an exception on these bindings.

Dan


> 									Pavel
> 


-- 
------------------
Dan Murphy
