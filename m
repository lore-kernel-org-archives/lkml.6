Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeEaTs2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:48:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40848 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeEaTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:48:26 -0400
X-Google-Smtp-Source: ADUXVKLHls4Z2ncIko2jSWsWuBvexBKCZBxe5LBrAneR/XhD5611aqBlgWlO9aKBpNu+WumpXc801Q==
Subject: Re: [PATCH 1/3] staging: rtlwifi: Fix "Trafic"->"Traffic"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180531110314.3760-1-sabin.rapan@gmail.com>
 <20180531165747.GA28898@kroah.com>
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
Message-ID: <438a4c2c-5bf8-8149-aaff-1f58493cdc79@gmail.com>
Date: Thu, 31 May 2018 21:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531165747.GA28898@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first patch series I forgot to CC linux-kernel@vger.kernel.org and
assumed (wrongly) that the patch series will be ignored.
In an attempt to fix that, I sent the second patch series with proper
CC added. I should have sent it as a reply to the first one and version
it.
I will do as you said and resend the patch series.

Sabin.

On 05/31/2018 06:57 PM, Greg KH wrote:
> On Thu, May 31, 2018 at 01:03:12PM +0200, Sabin Mihai Rapan wrote:
>> Trivial fix to spelling mistake in comment text.
>>
>> Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
>> ---
>>  drivers/staging/rtlwifi/phydm/phydm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> You sent a previous set of 4 patches with these same exact subject lines
> :(
> 
> I've now dropped both of these series from my pending queue, please fix
> up the subject lines and resend all of them at once.
> 
> thanks,
> 
> greg k-h
> 
