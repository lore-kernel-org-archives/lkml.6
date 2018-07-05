Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4326C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776F42244E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776F42244E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeGELWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:22:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56592 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753548AbeGELWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:22:35 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4C0C0108CE37A;
        Thu,  5 Jul 2018 04:22:34 -0700 (PDT)
Date:   Thu, 05 Jul 2018 20:22:32 +0900 (KST)
Message-Id: <20180705.202232.379343654393332455.davem@davemloft.net>
To:     vucnikm@gmail.com
Cc:     bjorn@mork.no, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] qmi_wwan: add support for Quectel EG91
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530720768-18349-1-git-send-email-vucnikm@gmail.com>
References: <1530720768-18349-1-git-send-email-vucnikm@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Jul 2018 04:22:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matevz Vucnik <vucnikm@gmail.com>
Date: Wed,  4 Jul 2018 18:12:48 +0200

> This adds the USB id of LTE modem Quectel EG91. It requires the
> same quirk as other Quectel modems to make it work.
> 
> Signed-off-by: Matevz Vucnik <vucnikm@gmail.com>

Applied and queued up for -stable.
