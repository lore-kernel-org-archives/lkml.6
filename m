Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85C218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbeLTSWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:22:04 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:60366 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730855AbeLTSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:22:02 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=[192.168.66.118]); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ga2xK-00078S-Gd; Thu, 20 Dec 2018 19:21:58 +0100
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
 <96fc8865-c54f-5c6c-f6c8-d7a5a12735e6@leemhuis.info>
 <20181220082819.69fc3e5c@lwn.net>
 <a02caf89-9221-8e31-4a2d-44b46b81cda2@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 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
 5iv6NKaV29GWHbY=
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <0996ba55-e5e1-49e2-f0ed-82cb1619ee03@leemhuis.info>
Date:   Thu, 20 Dec 2018 19:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a02caf89-9221-8e31-4a2d-44b46b81cda2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1545330121;a92d69e3;
X-HE-SMSGID: 1ga2xK-00078S-Gd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.12.18 um 17:38 schrieb Randy Dunlap:
> On 12/20/18 7:28 AM, Jonathan Corbet wrote:
>> On Thu, 20 Dec 2018 16:23:38 +0100
>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>>> While at it: Jonathan, you mentioned putting the script in scripts/, but
>>> according to the Makefile in that directory it is "for various helper
>>> programs used throughout the kernel for the build process". That's one
>>> reason why it feels wrong to put it there. Another one: that script
>>> targets users and thus we should try to make sure they can access it
>>> easily. That's why I'm currently inclined to put it in tools/ somewhere.
>> Yeah, tools/ is a better place.  Maybe a tools/debugging directory or some
>> such?
> chktaint

BTW, I renamed it to kernel-taintstatus, sounded more appropriate to me.
Does anyone mind?

> is similar (IMO) to scripts/decodecode though.

Hmmm. Maybe it would be better to move this to tools/? Will take a quick
look, guess sooner or later by current endeavours will lead me to the
documentation that refers to this script anyway.

> @Thorsten:
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thx. And thx for the feedback in the other reply.

BTW, for those following this thread and my earlier quest for a simple
cmd to decode /proc/sys/kernel/tainted: looks like @apexo on twitter
(thx again!) found a trick to do what I want which should work on most
systems out-of-the-box:

$ for i in $(seq 18); do echo $i $(($(cat
/proc/sys/kernel/tainted)>>($i-1)&1));done

Ciao, Thorsten
