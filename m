Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F45C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC75920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC75920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeIGVCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:02:35 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45170 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:02:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 10A6D2182C;
        Fri,  7 Sep 2018 16:20:56 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FYtp1KSdQx-7; Fri,  7 Sep 2018 16:20:56 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id C77422149F;
        Fri,  7 Sep 2018 16:20:47 +0000 (UTC)
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org>
 <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org>
Date:   Fri, 7 Sep 2018 10:20:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 10:14 AM, Dmitry Vyukov wrote:
> On Fri, Sep 7, 2018 at 6:03 PM, Shuah Khan <shuah@kernel.org> wrote:
>> Hi Dmitry,
>>
>> On 09/07/2018 04:54 AM, Dmitry Vyukov wrote:
>>> Hi,
>>>
>>> I am getting the following error while booting kernel on upstream
>>> commit a49a9dcce802b3651013f659813df1361d306172, config is attached.
>>> Seems there is some kind of resource leak.
>>>
>>> Thanks
>>
>> Odd. This commit has nothing to do with vudc.
> 
> This is not the guilty commit, I just described state of my tree.
> 

Can you send me the full dmesg?

thanks,
-- Shuah

