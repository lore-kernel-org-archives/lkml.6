Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E569FC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41B12146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41B12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strongswan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeLBEAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:00:00 -0500
Received: from sitav-80046.hsr.ch ([152.96.80.46]:41277 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeLBEAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:00:00 -0500
Received: from book.fritz.box (unknown [IPv6:2a01:2a8:8106:7c01:b5f0:8f23:2aa:553])
        by mail.strongswan.org (Postfix) with ESMTPSA id A978E40128;
        Sat,  1 Dec 2018 17:47:02 +0100 (CET)
Message-ID: <972ec5f157fc4e0b96311eafba50759b61cd4436.camel@strongswan.org>
Subject: Re: [PATCH v2 6/6] crypto: x86/chacha - add XChaCha12 support
From:   Martin Willi <martin@strongswan.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 01 Dec 2018 17:47:02 +0100
In-Reply-To: <20181129230217.158038-7-ebiggers@kernel.org>
References: <20181129230217.158038-1-ebiggers@kernel.org>
         <20181129230217.158038-7-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Now that the x86_64 SIMD implementations of ChaCha20 and XChaCha20
> have been refactored to support varying the number of rounds, add
> support for XChaCha12.  This is identical to XChaCha20 except for the
> number of rounds, which is 12 instead of 20.  This can be used by
> Adiantum.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Martin Willi <martin@strongswan.org>


