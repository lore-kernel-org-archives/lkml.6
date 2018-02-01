Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeBATKp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:10:45 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:38184 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeBATKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:10:38 -0500
X-Google-Smtp-Source: AH8x227nHlEYDDsruwzSGtboxuXPutYzk3vA9SLlt04bMVRvAzRUkgC8tg4B5bF0ayJqxkDsnecf3Q==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5b84a166-c71b-3a41-9e7f-a7624a8441f6@codeaurora.org>
 <38cdcae5-ec0f-d1be-b024-1990d4387731@gmail.com>
 <9e23d32f-05a0-ce8a-41f8-9a1a3d66be37@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <fd9f5f63-b08e-602e-1510-85a65889f550@gmail.com>
Date: Thu, 1 Feb 2018 11:10:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9e23d32f-05a0-ce8a-41f8-9a1a3d66be37@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 02:31, Chintan Pandya wrote:
> 
>>> Anyways, will fix this locally and share test results.
>>
>> Thanks, I look forward to the results.
>>
> 
> Set up for this time was slightly different. So, taken all the numbers again.
> 
> Boot to shell time (in ms): Experiment 2
> [1] Base            : 14.843805 14.784842 14.842338
> [2] 64 sized fixed cache    : 14.189292 14.200003 14.266711
> [3] Dynamic freeable cache    : 14.112412 14.064772 14.036052
> 
> So, [3] (this patch) looks to be improving 750ms (on avg from base build).
> 

Is this with the many debug options enabled?  If so, can you repeat with
a normal configuration?

Thanks,

Frank
