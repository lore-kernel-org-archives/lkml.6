Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D352075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D352075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIGWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:14:53 -0400
Received: from namei.org ([65.99.196.166]:46392 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbeIGWOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:14:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w87HWoM7027269;
        Fri, 7 Sep 2018 17:32:50 GMT
Date:   Sat, 8 Sep 2018 03:32:50 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Marcel Holtmann <marcel@holtmann.org>
cc:     David Howells <dhowells@redhat.com>,
        Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
In-Reply-To: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
Message-ID: <alpine.LRH.2.21.1809080332420.25924@namei.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <alpine.LRH.2.21.1809061007140.23269@namei.org> <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018, Marcel Holtmann wrote:

> Hi James,
> 
> >> Here's a set of patches that does the following, if you could pull it please:
> > 
> > Thanks, it would be good to see more review / acks, though.
> 
> so I have reviewed and tested this code. In addition, we have test cases for it in ELL (embedded linux library).
> 
> Tested-by: Marcel Holtmann <marcel@holtmann.org>
> Reviewed-by: Marcel Holtmann <marcel@holtmann.org>

Thanks!

-- 
James Morris
<jmorris@namei.org>

