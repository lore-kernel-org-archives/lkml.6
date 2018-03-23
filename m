Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCWPZf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:25:35 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:43430 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbeCWPZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:25:34 -0400
Subject: Re: [PATCH] X.509: unpack RSA signatureValue field from BIT STRING
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
 <30085.1520437454@warthog.procyon.org.uk>
 <593f6dbe-4ab4-0149-43d9-388cf0fee9f3@maciej.szmigiero.name>
Message-ID: <9264ee5d-e793-22c3-6aad-6bd7b8737dbf@maciej.szmigiero.name>
Date: Fri, 23 Mar 2018 16:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <593f6dbe-4ab4-0149-43d9-388cf0fee9f3@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2018 18:56, Maciej S. Szmigiero wrote:
> On 07.03.2018 16:44, David Howells wrote:
>> Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:
>>
>>> +	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {
>>
>> I'm going to change this to '== 0' rather than '!'.
> 
> No problem. 

I cannot find this patch in any tree that I have looked at.
Are you going to pick it up later or am I not looking at the right
place?

Thanks,
Maciej
