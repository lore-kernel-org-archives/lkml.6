Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312B2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E312B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIGWNg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:13:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60790 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeIGWNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:13:35 -0400
Received: from marcel-macpro.fritz.box (p4FF9F8A9.dip0.t-ipconnect.de [79.249.248.169])
        by mail.holtmann.org (Postfix) with ESMTPSA id D96AECF191;
        Fri,  7 Sep 2018 19:38:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <alpine.LRH.2.21.1809061007140.23269@namei.org>
Date:   Fri, 7 Sep 2018 19:31:36 +0200
Cc:     David Howells <dhowells@redhat.com>,
        Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <alpine.LRH.2.21.1809061007140.23269@namei.org>
To:     James Morris <jmorris@namei.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

>> Here's a set of patches that does the following, if you could pull it please:
> 
> Thanks, it would be good to see more review / acks, though.

so I have reviewed and tested this code. In addition, we have test cases for it in ELL (embedded linux library).

Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

