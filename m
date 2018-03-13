Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeCMTZv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:25:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCMTZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:25:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8330E60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH V1] Input: pm8941-pwrkey: add resin key capabilities
To: Tirupathi Reddy T <tirupath@codeaurora.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520410173-2507-1-git-send-email-tirupath@codeaurora.org>
 <20180307202147.GB195580@dtor-ws> <20180310182714.GD260013@dtor-ws>
 <d0991385-d03b-a42e-9303-679f0c16de34@codeaurora.org>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <d6b2f611-f7fc-3404-b49a-b28a873105be@codeaurora.org>
Date: Tue, 13 Mar 2018 12:25:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <d0991385-d03b-a42e-9303-679f0c16de34@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tirupathi,

On 3/13/2018 1:25 AM, Tirupathi Reddy T wrote:
> Hi Dmitry,
>
> On 3/10/2018 11:57 PM, Dmitry Torokhov wrote:
>> On Wed, Mar 07, 2018 at 12:21:47PM -0800, Dmitry Torokhov wrote:
>>> Hi Tirupathi,
>>>
>>> On Wed, Mar 07, 2018 at 01:39:33PM +0530, Tirupathi Reddy wrote:
>>>> Add resin key support to handle different types of key events
>>>> defined in different platforms.
>>
I replied to your patch without looking at response from Dmitry :) and 
you will see some comments matching... you can check my comments too 
though ...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
