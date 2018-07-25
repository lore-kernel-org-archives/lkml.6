Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65DF20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65DF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeGYRRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:17:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728600AbeGYRRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:17:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B10A8185331;
        Wed, 25 Jul 2018 16:05:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE6F32026D68;
        Wed, 25 Jul 2018 16:05:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Jul 2018 18:05:30 +0200 (CEST)
Date:   Wed, 25 Jul 2018 18:05:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [PATCH 00/20] PIDTYPE_TGID removal of fork restarts
Message-ID: <20180725160527.GA21007@redhat.com>
References: <87sh4so5jv.fsf@xmission.com>
 <20180709145726.GA26149@redhat.com>
 <877em4nxo0.fsf@xmission.com>
 <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
 <87lgakm4ol.fsf@xmission.com>
 <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
 <20180710134639.GA2453@redhat.com>
 <CA+55aFxcjSYAj-CZFEuDwiwZyMg+prV_jeP_Vuh06RJA0BboSw@mail.gmail.com>
 <877em2jxyr.fsf_-_@xmission.com>
 <87efft5ncd.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 25 Jul 2018 16:05:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 25 Jul 2018 16:05:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Eric W. Biederman wrote:
>
>       signal: Add calculate_sigpending()
>       fork: Have new threads join on-going signal group stops
>       signal: Don't restart fork when signals come in.

Oh, I need to re-read these patches tomorrow. I have some concerns, but perhaps
I am wrong. Will write another email tomorrow.

Oleg.

