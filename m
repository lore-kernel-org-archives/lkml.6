Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AA1C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5464B21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeLRTXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:23:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:57494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeLRTXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:23:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A7D2B0C2;
        Tue, 18 Dec 2018 19:23:16 +0000 (UTC)
Subject: Re: [PATCH v2] ima: define ima_post_create_tmpfile() hook and add
 missing call
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@ZenIV.linux.org.uk>
References: <1545158873.4206.86.camel@linux.ibm.com>
From:   Ignaz Forster <iforster@suse.de>
Message-ID: <e0830c44-d93e-5c6e-ef85-a35631b6f3c5@suse.de>
Date:   Tue, 18 Dec 2018 20:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545158873.4206.86.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.12.18 um 19:47 schrieb Mimi Zohar:
> If tmpfiles can be made persistent, then newly created tmpfiles need to
> be treated like any other new files in policy.
> 
> This patch indicates which newly created tmpfiles are in policy, causing
> the file hash to be calculated on __fput().
> 
> Reported-by: Ignaz Forster <ignaz.forster@gmx.de>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Ignaz Forster <iforster@suse.com>

Thanks a lot, the patch is working as expected.

Ignaz
