Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4A8208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4A8208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGJK2A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:28:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:38048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933131AbeGJK17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:27:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B8A5ADA2;
        Tue, 10 Jul 2018 10:27:58 +0000 (UTC)
Message-ID: <1531218026.15323.0.camel@suse.com>
Subject: Re: [PATCH] usb: cdc_acm: Add quirk for Castles VEGA3000
From:   Oliver Neukum <oneukum@suse.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 12:20:26 +0200
In-Reply-To: <20180710062849.915863-1-lkundrak@v3.sk>
References: <20180710062849.915863-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-07-10 at 08:28 +0200, Lubomir Rintel wrote:
> The device (a POS terminal) implements CDC ACM, but has not union
> descriptor.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Oliver Neukum <oneukum@suse.com>

