Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBDFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5B520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeIXWE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:04:26 -0400
Received: from cock.li ([185.100.85.212]:59978 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeIXWE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:04:26 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537804892; bh=URh9qHFeCo38PKQdUpck3eEvRCHNHalmUuyYg8Id3A0=;
        h=Date:From:To:Subject:From;
        b=frrEtdBq/7uKZLaD3qLe3Ljr5NEGjbSSOdBSideB91XK3UWtCSPXENWf+vJD2EfXA
         MGhsiQy9K7yxi1V10J5VuEQnGIcgH6uqMcYFeVgoFExKDBQ9uZ+6rxHkYCDOjeGpy2
         erwL4KeyuhhXjxXMGo0d/Rjw6Z+JmrleQakgiZwwEa9uWXYu96c1zzMQlAOB8mhg8o
         EBEFybNbct3SyYMz3dkH4vxkYcv2gfBVKvm0kd+1Vd5SgYm/6ru9g9woY8hittGysb
         sGqrRqKmjtVHqSsw+yJTdxxwdSdYWmq6yWCTZ5lQsYL2AG31boEKL99hZC+dCXV9v5
         ZFXXg3ZQrwSGg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Sep 2018 16:01:31 +0000
From:   gratuitouslicensesarerevocable@redchan.it
To:     linux-kernel@vger.kernel.org, dng@lists.dyne.org
Subject: Code of Conduct: Yes mjg59 (Matthew Garrett) Consent _is_ important.
 gratuitous licenses are revocable at will.
Message-ID: <cc250c152beff5435a88965798b05790@redchan.it>
X-Sender: gratuitouslicensesarerevocable@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spurned linux contributors SHOULD revoke the license grant they have 
given regarding their code. In the case of the linux kernel; These are 
typically gratuities and can be rescinded at the will of the grantor.

> ecree wrote:
> That is presuming my consent against me, and consent is very important 
> to me.

> mjg59 (Matthew Garrett) wrote:
> It's not presuming your consent at all, it's adding a condition to your 
> future participation. If you find that condition unacceptable then you 
> should let your employers know - they can either make a case to the 
> Linux Foundation or move you to another role. Remember that 
> participation in the kernel is a privilege, not a right, and our 
> involvement as always been at the whims of Linus. I'm well aware of how 
> much it sucks when he makes decisions I don't like without consulting 
> with the rest of the community, and I'm also aware that there's nothing 
> I can do about it.

Consent is important, keeping the rights-holders happy is important.
A gratuitous license is revocable at the will of the grantor.
If ecree holds copyright to his contributions, and he sought no 
consideration (usually money) from the licensee, he can revoke the 
license grant at any time under US property law.

Contributors to the linux code base do not typically sign over their 
copyrights to linux or a foundation, instead retaining the copyright 
themselves.
Contributors (here specifically: copyright holders) to the linux code 
base do not typically take money from those to whom they license their 
work.

Do the math.
Property 101.
There is a reason Moglen required assignments to the FSF for gnu related 
work, and the public story does not give the whole truth regarding 
intent.
(estopple won't save you, nor will it save would-have-been potential 
future licensees)

(And yes, I am a lawyer (but not yours))
