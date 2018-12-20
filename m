Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84959C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61267218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbeLTUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:07:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbeLTUHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:07:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C224B9F754;
        Thu, 20 Dec 2018 20:07:14 +0000 (UTC)
Received: from flask (unknown [10.43.2.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id C08441F2;
        Thu, 20 Dec 2018 20:07:12 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 20 Dec 2018 21:07:12 +0100
Date:   Thu, 20 Dec 2018 21:07:11 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: report failed stage when exit reason is
 unexpected
Message-ID: <20181220200711.GD25497@flask>
References: <20181219111518.25487-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219111518.25487-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 20 Dec 2018 20:07:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-19 12:15+0100, Vitaly Kuznetsov:
> When we get a report like
> 
> ==== Test Assertion Failure ====
>   x86_64/state_test.c:157: run->exit_reason == KVM_EXIT_IO
>   pid=955 tid=955 - Success
>      1	0x0000000000401350: main at state_test.c:154
>      2	0x00007fc31c9e9412: ?? ??:0
>      3	0x000000000040159d: _start at ??:?
>   Unexpected exit reason: 8 (SHUTDOWN),
> 
> it is not obvious which particular stage failed. Add the info.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Queued, thanks.
