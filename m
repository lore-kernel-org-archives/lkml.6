Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F647C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6595120833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeGYSLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:11:33 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44688 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:11:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fiN7r-0000Ti-Pp; Wed, 25 Jul 2018 10:58:59 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fiN7b-0002Gw-S4; Wed, 25 Jul 2018 10:58:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <87sh4so5jv.fsf@xmission.com> <20180709145726.GA26149@redhat.com>
        <877em4nxo0.fsf@xmission.com>
        <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
        <87lgakm4ol.fsf@xmission.com>
        <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
        <20180710134639.GA2453@redhat.com>
        <CA+55aFxcjSYAj-CZFEuDwiwZyMg+prV_jeP_Vuh06RJA0BboSw@mail.gmail.com>
        <877em2jxyr.fsf_-_@xmission.com> <87efft5ncd.fsf_-_@xmission.com>
        <20180725160527.GA21007@redhat.com>
Date:   Wed, 25 Jul 2018 11:58:40 -0500
In-Reply-To: <20180725160527.GA21007@redhat.com> (Oleg Nesterov's message of
        "Wed, 25 Jul 2018 18:05:28 +0200")
Message-ID: <87fu07z1z3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fiN7b-0002Gw-S4;;;mid=<87fu07z1z3.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nEEyUsNBreREsTUtt3x1jPZ7XmMtf+7M=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/20] PIDTYPE_TGID removal of fork restarts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/23, Eric W. Biederman wrote:
>>
>>       signal: Add calculate_sigpending()
>>       fork: Have new threads join on-going signal group stops
>>       signal: Don't restart fork when signals come in.
>
> Oh, I need to re-read these patches tomorrow. I have some concerns, but perhaps
> I am wrong. Will write another email tomorrow.

Thank you.  I look forward to seeing what you think after you have
re-read them.

Eric

