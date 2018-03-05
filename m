Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeCERJz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:09:55 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:47065 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeCERJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:09:53 -0500
X-Google-Smtp-Source: AG47ELsfvODN+sQffCPUP4G8lOFp+fcRdGjmkQo5BFYzuojwOxb4Vl1TDpXkwwHyTB22uydpM/WJtw==
Subject: Re: [PATCH] i2c: core: report OF style module alias for devices
 registered via OF
To: Wolfram Sang <wsa@the-dreams.de>,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
References: <20171203214050.11482-1-javierm@redhat.com>
 <CABxcv=nQpd-RPPzWbCpdWQjK7VzZyXtWSCTB3JHBA-uLygoC+A@mail.gmail.com>
 <CABxcv=myJZw1zVtbkSW-5xhxeK71YtV3jOvBdGgoB92m67R4bw@mail.gmail.com>
 <20180305153051.w3b7ern7u4e4fy23@ninjato>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <3c84d542-1441-b0c0-f24c-660b909dd34d@redhat.com>
Date: Mon, 5 Mar 2018 18:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305153051.w3b7ern7u4e4fy23@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 04:30 PM, Wolfram Sang wrote:
> 
>> Is this patch under your radar? Should I keep pushing for it or just give up?
> 
> Applied to for-next, thanks for your patience and your preparational
> work needed to get this upstream!
> 

Great, thanks a lot for your help!

> We will see in linux-next if there slipped in some new drivers which
> need fixing, but we have a full cycle to get them adapted.
>

Yes, I'll check tomorrow's linux-next to see if I can find these and
post patches for them.
 
> And hopefully the benefits will shine through right away.
> 
> Thanks again!
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
