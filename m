Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3886BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F32186A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbeLUFNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 00:13:48 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:51009 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeLUFNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 00:13:47 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id DD593440072;
        Fri, 21 Dec 2018 07:13:43 +0200 (IST)
References: <20181217153706.25873-1-marek.behun@nic.cz> <20181217153706.25873-2-marek.behun@nic.cz> <20181220214447.GA18008@bogus> <20181220230821.3f21163a@nic.cz>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/3] dt-bindings: mailbox: Document armada-37xx-rwtm-mailbox binding
In-reply-to: <20181220230821.3f21163a@nic.cz>
Date:   Fri, 21 Dec 2018 07:13:43 +0200
Message-ID: <8736qr8nso.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Marek Behun writes:
>> > +- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"  
>> 
>> Don't use wildcards in compatible strings.
>
> You mean that "mailbox" shouldn't be there?

You should use '3700' instead of '37xx'.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
