Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED71C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736DD205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736DD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeGSQRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:17:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731126AbeGSQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96390406E968;
        Thu, 19 Jul 2018 15:33:49 +0000 (UTC)
Received: from treble (ovpn-120-141.rdu2.redhat.com [10.10.120.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B3F42026D6B;
        Thu, 19 Jul 2018 15:33:49 +0000 (UTC)
Date:   Thu, 19 Jul 2018 10:33:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame
Message-ID: <20180719153347.buoe6pavpqc75zbb@treble>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Jul 2018 15:33:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Jul 2018 15:33:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 01:33:54PM +0900, Prashant Bhole wrote:
> Hi Peter, Josh,
> 
> Found following bug. This bug can not be seen with this fix:
> https://lkml.org/lkml/2018/5/10/280.

Peter, care to clean that up and submit it?

-- 
Josh
