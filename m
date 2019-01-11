Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FEE2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfAKNmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:42:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfAKNmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:42:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E21DD1E31B;
        Fri, 11 Jan 2019 13:42:10 +0000 (UTC)
Received: from flask (unknown [10.40.205.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id A08F1411A;
        Fri, 11 Jan 2019 13:42:08 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:42:07 +0100
Date:   Fri, 11 Jan 2019 14:42:07 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  kvm/eventfd : unnecessory conversion to bool
Message-ID: <20190111134206.GD14852@flask>
References: <1545891737-84095-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545891737-84095-1-git-send-email-peng.hao2@zte.com.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 11 Jan 2019 13:42:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-27 14:22+0800, Peng Hao:
> Conversion to bool is not needed in ioeventfd_in_range.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---

Fixed the typo in subject and queued, thanks.
