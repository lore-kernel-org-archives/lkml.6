Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C96217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C96217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeHELXu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 07:23:50 -0400
Received: from vs23.mail.saunalahti.fi ([193.64.193.199]:35546 "EHLO
        vs23.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHELXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 07:23:49 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2018 07:23:48 EDT
Received: from vs23.mail.saunalahti.fi (localhost [127.0.0.1])
        by vs23.mail.saunalahti.fi (Postfix) with ESMTP id EEDF220102;
        Sun,  5 Aug 2018 12:14:38 +0300 (EEST)
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi [195.197.172.116])
        by vs23.mail.saunalahti.fi (Postfix) with ESMTP id E419F200CB;
        Sun,  5 Aug 2018 12:14:38 +0300 (EEST)
Received: from kais-mac-mini.makisara.private (87-92-22-65.bb.dnainternet.fi [87.92.22.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kh8831)
        by gw02.mail.saunalahti.fi (Postfix) with ESMTPSA id C171F4012E;
        Sun,  5 Aug 2018 12:14:32 +0300 (EEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] st: remove redundant pointer STbuffer
From:   =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= 
        <kai.makisara@kolumbus.fi>
In-Reply-To: <20180803104752.17081-1-colin.king@canonical.com>
Date:   Sun, 5 Aug 2018 12:14:32 +0300
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5FB12D0E-73B3-4A5B-BAB8-7D3DF7979EF1@kolumbus.fi>
References: <20180803104752.17081-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 3 Aug 2018, at 13.47, Colin King <colin.king@canonical.com> wrote:
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer STbuffer is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'STbuffer' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Kai Mäkisara <kai.makisara@kolumbus.fi>

Has been unused at least since 2005 :-)

Thanks,
Kai

