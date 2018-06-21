Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB2BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FAE208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FAE208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFUIn6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:43:58 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:47760 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932727AbeFUIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:43:56 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d76 with ME
        id 1Ljt1y00241oiFu03Ljtti; Thu, 21 Jun 2018 10:43:54 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 Jun 2018 10:43:54 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     David Miller <davem@davemloft.net>
Cc:     daniel@zonque.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 07/14] net: smc911x: remove the dmaengine compat need
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180617170217.24177-8-robert.jarzmik@free.fr>
        <87muvppebs.fsf@belgarion.home>
        <20180621.083945.1673251234112481148.davem@davemloft.net>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 21 Jun 2018 10:43:52 +0200
In-Reply-To: <20180621.083945.1673251234112481148.davem@davemloft.net> (David
        Miller's message of "Thu, 21 Jun 2018 08:39:45 +0900 (KST)")
Message-ID: <87vaaco7g7.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Wed, 20 Jun 2018 19:17:43 +0200
>
>> Could you (or somebody from netdev) review it and either ack it (and I'll take
>> it through the pxa tree), or take it for v4.19 please ?
>
> Acked-by: David S. Miller <davem@davemloft.net>
Thanks David.

Queued to pxa/for-next.

Cheers.

-- 
Robert
