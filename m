Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965655AbeBMTt4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:49:56 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:37879 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965551AbeBMTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:49:53 -0500
X-Google-Smtp-Source: AH8x225tWJOmqDbcbb/8WJ5xjlCA7oe/oVyZKM51LIqeKZcBRcsEo8vw2xx8/ntykVzfSSDPOhucSQ==
Subject: Re: [PATCH 14/14] x86/crypto: aesni: Update aesni-intel_glue to use
 scatter/gather
To: Dave Watson <davejwatson@fb.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
References: <cover.1518211765.git.davejwatson@fb.com>
 <20180212195128.GA61087@davejwatson-mba.local>
 <dc69bdfa-6dc2-da54-9d9a-b171aeb3212b@google.com>
 <20180213182203.GA2122@davejwatson-mba.local>
From: Junaid Shahid <junaids@google.com>
Organization: Google
Message-ID: <188ad18b-adb1-714c-0327-acfca77a145b@google.com>
Date: Tue, 13 Feb 2018 11:49:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180213182203.GA2122@davejwatson-mba.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending after delivery failure]

Hi Dave,

On 02/13/2018 10:22 AM, Dave Watson wrote:
>
> Yes, these both sound reasonable.  I will send a V2.
>
> Thanks!

Another minor suggestion for v2:

It might be a good idea to check if the first assoclen bytes are already contiguous and only do the kmalloc if that isn't the case.

Thanks,
Junaid
