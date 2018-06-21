Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7869A20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7869A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeFUIoN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:44:13 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:51910 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932459AbeFUIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:44:10 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d76 with ME
        id 1Lk81y00f41oiFu03Lk8ve; Thu, 21 Jun 2018 10:44:09 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 Jun 2018 10:44:09 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     David Miller <davem@davemloft.net>
Cc:     daniel@zonque.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/14] net: smc91x: remove the dmaengine compat need
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180617170217.24177-9-robert.jarzmik@free.fr>
        <87lgb9pebm.fsf@belgarion.home>
        <20180621.084002.1771429251320622962.davem@davemloft.net>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 21 Jun 2018 10:44:08 +0200
In-Reply-To: <20180621.084002.1771429251320622962.davem@davemloft.net> (David
        Miller's message of "Thu, 21 Jun 2018 08:40:02 +0900 (KST)")
Message-ID: <87r2l0o7fr.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> Acked-by: David S. Miller <davem@davemloft.net>
Thanks David.

Queued to pxa/for-next.

Cheers.

-- 
Robert

