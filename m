Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B65624012
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B65624012
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeGFKwp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:52:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38944 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeGFKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:52:44 -0400
Received: from [192.168.0.117] (188.146.34.1.nat.umts.dynamic.t-mobile.pl [188.146.34.1])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2563ACF2A7;
        Fri,  6 Jul 2018 12:59:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] bluetooth: remove unused bt-nokia-h4p.h header
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
Date:   Fri, 6 Jul 2018 12:52:41 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <521D496D-4F2A-4D78-AA86-9AA19B2C974D@holtmann.org>
References: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

> Nothing in tree use this header which seems a remains of a staging
> driver.
> This patch remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> include/linux/platform_data/bt-nokia-h4p.h | 38 ------------------------------
> 1 file changed, 38 deletions(-)
> delete mode 100644 include/linux/platform_data/bt-nokia-h4p.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

