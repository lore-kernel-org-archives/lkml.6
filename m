Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78C5ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4DB2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4DB2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJQXYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:24:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43389 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJQXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:24:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 00BB7C061B;
        Wed, 17 Oct 2018 15:28:41 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n2XMF9wTGIvQ; Wed, 17 Oct 2018 15:28:40 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 931E9C03B6;
        Wed, 17 Oct 2018 15:28:16 +0000 (UTC)
Subject: Re: [PATCH 00/10] tools: Various build flags fixes
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Thomas Renninger <trenn@suse.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <1915425.8MElBxF9G6@house>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <afaa611b-a44d-70f8-9908-8bad14986db4@kernel.org>
Date:   Wed, 17 Oct 2018 09:28:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1915425.8MElBxF9G6@house>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 07:23 AM, Thomas Renninger wrote:
> On Tuesday, October 16, 2018 5:06:05 PM CEST Jiri Olsa wrote:
>> hi,
>> while hardening some of the tools rpm, we noticed we
>> can't pass build flags to some of them.
>>
>> Sending separate tools fixes for what we found. It's
>> mostly override for CFLAGS and adding LDFLAGS to the
>> build commands.
> 
> Looks fine for the cpupower patches 3/10 and 4/10.
> (Feel free to add a Reviewed-by or Acked-by for them
> if you have to resend).
> 

Thanks Thomas.

Hi Jiri,

Same here for cpupower patches 3/10 and 4/10. Please let me know
if you would like me to take these through the cpupower patch flow.

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah

