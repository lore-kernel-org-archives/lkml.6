Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ECAECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0861B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="B78iwaOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0861B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJ0CKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:10:55 -0400
Received: from cock.li ([185.100.85.212]:38108 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJ0CKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:10:54 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1540575179; bh=zo8bTgjEhZMaRe9lTXMEpYS5MSrZVqFsM5id+dHfnHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B78iwaOJaHqJU0MvF8TVZdEES8lNtsbLIvoZ2WlWNRZ2ZdUw1qHKcImWazA6xzPrS
         9F/vpXA6ATiyKyqbvagv0WulDn/SCzTLhSrPUr3W7u6DyCxA2O5BN2QLVUYHZfPjLf
         dFPqx8hbBHeLL59rmD5q2KS+DhY/cwYzJAkxJcD+85rGBOKGni+6csIx+5H73tnu+0
         YZiTEuqBy+izXsce8AhBND4g2qqipZXhc5ckTiJQlY+FDh45T51A8uF5ffaYeC6/oL
         yVJ1EHP5CivPOsMoxjurip0I7lZAbxtNE+ORrbLkT+i4iOTYLx23aCjxKJYRm4v/7Y
         TR/l2AcO+5i4w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Oct 2018 17:32:58 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     esr@thyrsus.com, gregkh@linuxfoundation.org,
        Eben Moglen <moglen@columbia.edu>, rms@gnu.org,
        bruce@perens.com, bkuhn@sfconservancy.org, editor@lwn.net,
        neil@brown.name, labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
 <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
Message-ID: <4c023302875de71cc58007301b180940@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-26 13:15, Eben Moglen wrote:
> They can do neither.  There is no "doctrine established in Jacobsen."
> The license terms of the GPLv2, GPLv3, and all related licenses
> provide a mode of termination---for imposition of additional
> restrictions or violation of other terms.  This termination provision,
> being explicit, is therefore the sole form of termination recognized
> under the terms of the Copyright Act.

Incorrect. This rule is only valid for bargained-for copyright licenses 
supported by consideration.
The GPLv2 is not such a situation for most licensees.

You are conflating case law dealing with commercial software and 
non-gratuitous licenses with the present situation, which would likely 
be a case of first-impression in nearly any jurisdiction.

The rule for gratuitous licenses is that they are revocable at the will 
of the grantor.
Raymond Nimmer (God rest his soul) was in agreement on this point, 
vis-a-vis the GPL and similar licenses.
