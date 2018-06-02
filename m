Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeFBWLz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 18:11:55 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33806 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeFBWLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 18:11:53 -0400
Subject: Re: [SIL2review] [PATCH] media: tc358743: release device_node in
 tc358743_probe_of()
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Mats Randgaard <matrandg@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ldv-project@linuxtesting.org, sil2review@lists.osadl.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-media@vger.kernel.org
References: <1527285240-12762-1-git-send-email-khoroshilov@ispras.ru>
 <20180526143834.GA28325@osadl.at>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=khoroshilov@ispras.ru; prefer-encrypt=mutual; keydata=
 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
 NoYGZfNAuA==
Message-ID: <a89812ad-8cbb-129f-4bb2-0c1d92d28598@ispras.ru>
Date: Sun, 3 Jun 2018 01:11:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180526143834.GA28325@osadl.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2018 17:38, Nicholas Mc Guire wrote:
> On Sat, May 26, 2018 at 12:54:00AM +0300, Alexey Khoroshilov wrote:
>> of_graph_get_next_endpoint() returns device_node with refcnt increased,
>> but these is no of_node_put() for it.
> 
> I think this is correct - but would it not be simpler to do
> 
>    endpoint = v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep));
>    of_node_put(ep);
>    if (IS_ERR(endpoint)) {
>    ....
> 
> As the of_node_put(np) actually is unconditional anyway I think this
> should be semantically equivalent.

You are right. But the same is true for
v4l2_fwnode_endpoint_free(endpoint);
that is already correctly handled by the driver.
So, I have preferred to follow the same pattern.


> 
>>
>> The patch adds one on error and normal paths.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>


Thank you,
Alexey
