Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ADAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925132146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbh8Kd7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925132146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeK3JBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeK3JBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:01:09 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C03921019;
        Thu, 29 Nov 2018 21:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543528457;
        bh=ortKk2O4EC0nv9Q1OTcxa6pdyUU2m3A/5L6ZdMrKcmE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sbh8Kd7Z8JAEne7GFMX38UO9jOMbfBnMj6eHMktH+l0T4KHGBoRi/+8DPLKSCuu/V
         y4PkIULOwvIcXq8SaltD4azy1vOXdxqBxBuzXYNpteKU1PUT2YhoGYlr6kWJapqnlM
         EzaRg0+S3AnfXRuOWYuhcddcdl9P3dmy88LhX684=
Subject: Re: [PATCH] selftests/ftrace: Fix invalid SPDX identifiers
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, shuah@kernel.org
References: <alpine.DEB.2.21.1811121108000.14703@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1811292220010.1657@nanos.tec.linutronix.de>
From:   shuah <shuah@kernel.org>
Message-ID: <b69b7168-330f-28b5-ec28-8ce91f63dd09@kernel.org>
Date:   Thu, 29 Nov 2018 14:54:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811292220010.1657@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 2:20 PM, Thomas Gleixner wrote:
> On Mon, 12 Nov 2018, Thomas Gleixner wrote:
> 
> Polite reminder....

Thanks for the reminder.

> 
>> While GPL2.0 looks about right, the correct and valid identifiers for GPL v2
>> only code are 'GPL-2.0' or 'GPL-2.0-only'.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Shuah Khan (Samsung OSG) <shuah@kernel.org>
>>

Hi Masami,

I am pulling this in for 4.21-rc1.

thanks,
-- Shuah

