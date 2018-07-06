Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFAC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F5B2147E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mh56oOZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F5B2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934596AbeGFR5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:57:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49342 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933801AbeGFRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D5A658EE212;
        Fri,  6 Jul 2018 10:53:22 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GSCvJv6ZZ0kg; Fri,  6 Jul 2018 10:53:22 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 720C58EE02B;
        Fri,  6 Jul 2018 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1530899602;
        bh=fgSepSXeqnKs4Pf0n07SDY5qTcH7XtYlc30Y3F4Qm9o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mh56oOZuDS6EmhDVihoKEJ7NjgS+HZ01xQMuFfGJSBzrddUliSILuF9TmiYUYN4G9
         06hNDiHyaMbn6BlT6j+kQO/aSZuuIfhAqD3mZDpXYjB6cxJ6at+JiRHWoQJ0i21Z+8
         eFfZuqao2+tAkbFP+s6+rUrQ5YY6T2Ahn6HQNZ18=
Message-ID: <1530899576.3142.3.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/2] Remove remainig MCR SCSI drivers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Date:   Fri, 06 Jul 2018 10:52:56 -0700
In-Reply-To: <20180706133349.28508-1-jthumshirn@suse.de>
References: <20180706133349.28508-1-jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 15:33 +0200, Johannes Thumshirn wrote:
> MCR Support was ripped out of the kernel in 2012. I think 6 years
> later we can kill the remaining drivers which couldn't have been
> compiled since then.
> 
> Johannes Thumshirn (2):
>   scsi: remove NCR_D700 driver
>   scsi: remove NCR_Q720 driver

Since they're my drivers,

Acked-by: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>

James

