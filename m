Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7097C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921FB206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbeLQTdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:33:05 -0500
Received: from namei.org ([65.99.196.166]:52204 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeLQTdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:33:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBHJX3Q6029623;
        Mon, 17 Dec 2018 19:33:03 GMT
Date:   Tue, 18 Dec 2018 06:33:03 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for Linux v4.21
In-Reply-To: <20181217132033.GA31729@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1812180632420.29218@namei.org>
References: <20181217132033.GA31729@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Jarkko Sakkinen wrote:

> Hi James,
> 
> v4.21 updates:
> 
> * Support for partial reads of /dev/tpm0.
> * Clean up for TPM 1.x code: move the commands to tpm1-cmd.c and make
>   everything to use the same data structure for building TPM commands
>   i.e. struct tpm_buf.

Pulled to next-tpm and next-testing.

-- 
James Morris
<jmorris@namei.org>

