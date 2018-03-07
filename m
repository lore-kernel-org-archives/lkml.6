Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754517AbeCGR4r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:56:47 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:46764 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbeCGR4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:56:45 -0500
Subject: Re: [PATCH] X.509: unpack RSA signatureValue field from BIT STRING
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <88da0c24-385c-64a9-6d56-36696d433bc7@maciej.szmigiero.name>
 <30085.1520437454@warthog.procyon.org.uk>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <593f6dbe-4ab4-0149-43d9-388cf0fee9f3@maciej.szmigiero.name>
Date: Wed, 7 Mar 2018 18:56:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <30085.1520437454@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2018 16:44, David Howells wrote:
> Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:
> 
>> +	if (!strcmp(ctx->cert->sig->pkey_algo, "rsa")) {
> 
> I'm going to change this to '== 0' rather than '!'.

No problem. 
> David
> 

Thanks,
Maciej
