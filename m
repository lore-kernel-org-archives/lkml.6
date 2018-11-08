Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890DEC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E4C2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E4C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strongswan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKHQV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:21:27 -0500
Received: from sitav-80046.hsr.ch ([152.96.80.46]:38897 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:21:27 -0500
Received: from book (61.225.197.178.dynamic.wless.zhbmb00p-cgnat.res.cust.swisscom.ch [178.197.225.61])
        by mail.strongswan.org (Postfix) with ESMTPSA id 29199409E0;
        Thu,  8 Nov 2018 07:47:32 +0100 (CET)
Message-ID: <757b2f06657d68929ce14d2bac3eb111bb06e6ab.camel@strongswan.org>
Subject: Re: [RFC PATCH v3 00/15] crypto: Adiantum support
From:   Martin Willi <martin@strongswan.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Date:   Thu, 08 Nov 2018 07:47:23 +0100
In-Reply-To: <20181105232526.173947-1-ebiggers@kernel.org>
References: <20181105232526.173947-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> This patchset adds Adiantum to Linux's crypto API, focusing on
> generic and ARM32 implementations.  Patches 1-9 add support for
> XChaCha20 and XChaCha12.  Patches 10-13 add NHPoly1305 support,
> needed for Adiantum hashing. Patch 14 adds Adiantum support as a
> skcipher template.

Nice work. I did a quick review only, but you may add my

  Acked-by: Martin Willi <martin@strongswan.org>

for patches 1-5, 10 and 11.

Thanks,
Martin

