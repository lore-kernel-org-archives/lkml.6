Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1DBC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E0E25A9B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="J3NTeHmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E0E25A9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966098AbeF0RNH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:13:07 -0400
Received: from vern.gendns.com ([206.190.152.46]:42113 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964947AbeF0RNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DMX9A5oyOIeVJQjIVy+hzkDpUaED+CKvPTf9n/Zuhfk=; b=J3NTeHmpM2cNK8kY7pOOGr16HT
        lOQ1QLyekFsWthHrxUhETLQUTrj/WXx0tmAI/f7r5gnsi0w5ajUSM71bOIaDQU6x9Ma+A5XE3HBc2
        DBR0/YmdJM6/MEHSnjCFHXpHccyRM6tZT1yKjfpHb1P/mRfsWo05tylPu5s5aXgIWE21VAqSfVIh/
        +uUhV6GmBwR1AI8b5LbU1COq9fY73G4k6xd9PE0YizvevzWkQkTnzAymictJQ7VSIFCMhd54l9zY3
        CBwsBe4eCEGbyR6gbVyTC6pBBg/jh4HdMh5wWp7b1VHi1aNK5e1+NGtekxeKRwI7l5SKdiykQm3J1
        XFV0T6wQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50064 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fYE07-00ArdG-Vi; Wed, 27 Jun 2018 13:13:04 -0400
Subject: Re: [PATCH 2/2] ARM: davinci_all_defconfig: Enable Bluetooth
To:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org
Cc:     Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531202549.11255-1-david@lechnology.com>
 <20180531202549.11255-3-david@lechnology.com>
 <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <0525829c-3070-6aee-39cf-1154dcbb1e75@lechnology.com>
Date:   Wed, 27 Jun 2018 12:13:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 06:11 AM, Sekhar Nori wrote:
> On Friday 01 June 2018 01:55 AM, David Lechner wrote:
>> This enables Bluetooth modules in davinic_all_defconfig needed for LEGO
> 
> davinci_all_defconfig
> 
>> MINDSTORMS EV3.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   arch/arm/configs/davinci_all_defconfig | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
>> +CONFIG_SERIAL_DEV_BUS=y
> 
> Any reason to build this into the kernel?
> 

Yes:


config SERIAL_DEV_CTRL_TTYPORT
	bool "Serial device TTY port controller"
	help
	  Say Y here if you want to use the Serial device bus with common TTY
	  drivers (e.g. serial drivers).

	  If unsure, say Y.
	depends on TTY
	depends on SERIAL_DEV_BUS != m
	default y

endif

