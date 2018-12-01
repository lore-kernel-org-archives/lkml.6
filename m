Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4259C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C45920867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="evzTZsBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C45920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725755AbeLBHre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:47:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49572 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WT+OC4/cot2h1DYQiTZZNyOQz9Dr5p6Kl4Dl5Z3gJLY=; b=evzTZsBK+7kfAmDWsvZ1t1fkIU
        8sgmIUV+yFH77FUVlL72FYBssMGLyC4cF9g5SXvyW5/cwasAmt/x/Obc2T7kEE6LC8YMO6KvmFNYH
        4LeF/dgHWrxLdRFDJEOGVxLZ59MdK06hp3JkMn/wYJqbBYRty9lsWHxWHflLRL9YEhWHQZFqad4nq
        xjyP4xaohrLMjxXEpuasmw8vzocRZMNwNjLkyIVHXbFM5xp5LLdSSP96HE9ANebCtTILpOqhqveeH
        WlrRZLob+5eEdK4w4mWkDObuiL/ABhBsUOj/no64LuvAMl5D3wGYZgHJSdT/MSbPZEibPRJtEB0yN
        y1IEKxNw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTBxp-0004IK-Dv; Sat, 01 Dec 2018 20:34:10 +0000
Subject: Re: [PATCH 2/2] hwmon: Remove multiple space after dot
To:     Joe Perches <joe@perches.com>,
        Corentin Labbe <clabbe@baylibre.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543522155-17406-1-git-send-email-clabbe@baylibre.com>
 <1543522155-17406-2-git-send-email-clabbe@baylibre.com>
 <188e822951d0b3a30cf4eea8ec0ea7b6d3bb4fca.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1819f01-3de8-2e76-bfb9-950a98e0326c@infradead.org>
Date:   Sat, 1 Dec 2018 12:34:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <188e822951d0b3a30cf4eea8ec0ea7b6d3bb4fca.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/18 12:27 PM, Joe Perches wrote:
> On Thu, 2018-11-29 at 20:09 +0000, Corentin Labbe wrote:
>> This patch remove extra space after a dot.
> []
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> ---
>>  drivers/hwmon/Kconfig | 236 +++++++++++++++++++++---------------------
>>  1 file changed, 118 insertions(+), 118 deletions(-)
> []
>> @@ -11,7 +11,7 @@ menuconfig HWMON
>>  	  of a system. Most modern motherboards include such a device. It
>>  	  can include temperature sensors, voltage sensors, fan speed
>>  	  sensors and various additional features such as the ability to
>> -	  control the speed of the fans.  If you want this support you
>> +	  control the speed of the fans. If you want this support you
>>  	  should say Y here and also to the specific driver(s) for your
>>  	  sensors chip(s) below.
> 
> Please no.

Ack.  No need for such a patch.


-- 
~Randy
