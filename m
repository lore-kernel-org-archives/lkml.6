Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_NUMERIC_HELO,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F30208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F30208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeGJNmD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:42:03 -0400
Received: from olimex.com ([184.105.72.32]:33950 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933145AbeGJNmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:42:01 -0400
Received: from 195.238.85.143 ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:41:58 -0700
Subject: Re: [PATCH v2 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1529909093-17021-1-git-send-email-stefan@olimex.com>
 <20180710103250.GG1504@ulmo> <e1229a90-1bdb-0c8e-c371-cde0bc30ea56@gmail.com>
 <20180710132740.GA19600@kroah.com>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <a5aaf30e-4fd5-b47c-664b-55d00b862262@olimex.com>
Date:   Tue, 10 Jul 2018 16:41:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710132740.GA19600@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 04:27 PM, Greg Kroah-Hartman wrote:
> On Tue, Jul 10, 2018 at 04:08:54PM +0300, Stefan Mavrodiev wrote:
>> On 07/10/2018 01:32 PM, Thierry Reding wrote:
>>>> +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com>");
>>>> +MODULE_DESCRIPTION("LCD-OLinuXino driver");
>>>> +MODULE_LICENSE("GPL v2");
>>> This seems to contradict the GPL-2.0+ in the SPDX header.
>> Can you elaborate on this?
> Please read module.h for what this string means.
Oh.... My bad. License should be "GPL", not "GPL v2".
>
> thanks,
>
> greg k-h

Regards,
Stefan Mavrodiev
