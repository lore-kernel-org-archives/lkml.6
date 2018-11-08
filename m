Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8907E20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="e7Zsp1Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8907E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeKII1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:27:14 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:58138 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeKII1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:27:14 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id A651BB6B;
        Thu,  8 Nov 2018 23:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1541717367; x=1543531768; bh=6PZMS76KLpnj53Siy7GY2/9msC3LEeyMASz
        xAQy/Ugg=; b=e7Zsp1Iiyv6wonsiPvLeqmHMVOmQJVJ4yo1DFmWZecPAwbN0tDm
        kq2Mbc8+ac0stqb1hgbmyiguRUDEmP0UCsxN+WF6Kcm7yrGL3TCVHrlTxZ3UJJ9y
        qKm268FqLekmyATOeHzyyIyFVMoslDgXg2emyTmoxZsHYbfyiz05/DpUuup+GbpW
        IFQXFdNrXB2sTiZPmbABU1VYAyzMBulwmUHt7xafNHm8fUya6N0yz/tK1r/Emf35
        E7hp/xLjjrUVUG8tPSB3D+FCMlGg0FV7LDfc6CsZUJ01dpiOZ3PC6OsjQpqgJfFp
        5zZvBE8kgRSO1pWEFG7951iAtQ7m7Fm/58zGtM/U2bbw65hUYkVCx792v3R7EuzM
        PtCAr4+n4LtdhkyezaNYa7wsw9dpgKB2njtsSwrxFm1T91Qh9IObnbrXdV2oRikG
        WOj2PIVaJk04PXyjVOrWOl8uqoxXF+X0lgWrdBHYP8k0tD3UNfxvES1mmcUFHN1t
        KhYDv+qLRSa6vAa+ROGUUH3ifvG1BOqL4YDcQZ5OnD/m23CZjHYT34jajk/VgM0b
        66Pjd59ZhWG5aQSMmXy6GalXaE36JDN611ZTfmCCPri/hXFzATBz1sPYrjDWhTzr
        1pMxvfsUSAiNZZ0UUBsPwm/kCvIma1z04cD8f7N9ZoJONIqYagIiseK8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a1ubzPj_Btjw; Thu,  8 Nov 2018 23:49:27 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id A634D813;
        Thu,  8 Nov 2018 23:49:27 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 245AC2517;
        Thu,  8 Nov 2018 23:49:27 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc:it_IT: add some process/* translations
Date:   Thu, 08 Nov 2018 23:49:25 +0100
Message-ID: <8336640.hExbF9JPVd@harkonnen>
In-Reply-To: <20181107152258.48267a2a@lwn.net>
References: <20181005185157.27819-1-federico.vaga@vaga.pv.it> <20181107152258.48267a2a@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 7, 2018 11:22:58 PM CET Jonathan Corbet wrote:
> On Fri,  5 Oct 2018 20:51:57 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > This patch does not translate entirely the subfolder "process/"
> > but only part of it (to begin with).
> > 
> > In order to avoid broken links, I included empty documents
> > for those which are not yet translated.
> > 
> > In order to be able to refer to all documents in "process/",
> > I added a sphinx label to those which had not one.
> > 
> > Translated documents:
> > - howto
> > - 1.Intro
> > - clang-format
> > - coding-style
> > - kernel-driver-statement
> > - magic-number
> > - volatile-considered-harmful
> > - development-process
> 
> So I'm (finally) ready to apply this, but it has conflicts against current
> docs-next.  Could I ask you, please, to send me a respin?

Ok, I'm going to prepare it. I will send also a couple of minor fixes that I 
ported to the Italian translation from the main documents.



