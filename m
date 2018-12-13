Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE18CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C78D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C78D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeLMTkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:40:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbeLMTkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:40:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42D9A307CDFA;
        Thu, 13 Dec 2018 19:40:42 +0000 (UTC)
Received: from flask (unknown [10.43.2.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id E4CA31974F;
        Thu, 13 Dec 2018 19:40:39 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 13 Dec 2018 20:40:39 +0100
Date:   Thu, 13 Dec 2018 20:40:39 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3]  kvm:x86 :remove unnecessary recalculate_apic_map
Message-ID: <20181213194038.GA24224@flask>
References: <1543916570-55054-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543916570-55054-1-git-send-email-peng.hao2@zte.com.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Dec 2018 19:40:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-04 17:42+0800, Peng Hao:
> In the previous code, the variable apic_sw_disabled influences
> recalculate_apic_map. But in "KVM: x86: simplify kvm_apic_map"
> (commit:3b5a5ffa928a3f875b0d5dd284eeb7c322e1688a),
> the access to apic_sw_disabled in recalculate_apic_map has been
> deleted.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
