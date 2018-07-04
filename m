Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C8AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46334219D0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46334219D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeGDNIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:08:12 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25306 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGDNIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:08:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=date:from:reply-to:to:cc:message-id:in-reply-to:references:subject:mime-version:content-type:user-agent; 
  b=jJILKjfU5cl98c9pq9GvhgZEpGZ6ZeHfVxOrrC1mT3LGYaPj4fR2piWf1VhRzdT8F1BLfkHT0MxE
    co0er4QBbEQ2/R1buD1mPTpzV/vsnhlDkOuJAlGQ96bWyMXCdkWg  
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1530709655954389.37906206134755; Wed, 4 Jul 2018 06:07:35 -0700 (PDT)
Received: from  [123.120.80.137] by mail.zoho.com
        with HTTP;Wed, 4 Jul 2018 06:07:35 -0700 (PDT)
Date:   Wed, 04 Jul 2018 21:07:35 +0800
From:   Huaisheng Ye <yehs2007@zoho.com>
Reply-To: yehs2007@zoho.com
To:     "\"Jan Kara\"" <jack@suse.cz>
Cc:     <linux-nvdimm@lists.01.org>, <dan.j.williams@intel.com>,
        <ross.zwisler@linux.intel.com>, <mawilcox@microsoft.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        <viro@zeniv.linux.org.uk>, <martin.petersen@oracle.com>,
        <axboe@kernel.dk>, <gregkh@linuxfoundation.org>,
        <bart.vanassche@wdc.com>, <jack@suse.com>, <chengnt@lenovo.com>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "\"Huaisheng Ye\"" <yehs1@lenovo.com>,
        "\"colyli\"" <colyli@suse.de>
Message-ID: <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
In-Reply-To: <20180704113012.trnfzeefao25clri@quack2.suse.cz>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <20180704064058.1344-3-yehs2007@zoho.com> <20180704113012.trnfzeefao25clri@quack2.suse.cz>
Subject: Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of dax_direct_access
 if useless
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 ---- On Wed, 04 Jul 2018 19:30:12 +0800 Jan Kara <jack@suse.cz> wrote ---- 
 > On Wed 04-07-18 14:40:58, Huaisheng Ye wrote: 
 > > From: Huaisheng Ye <yehs1@lenovo.com> 
 > >  
 > > Some functions within fs/dax don't need to get gfn from direct_access. 
 > > Assigning NULL to gfn of dax_direct_access is more intuitive and simple 
 > > than offering a useless local variable. 
 > >  
 > > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com> 
 >  
 > I like this. You can add: 
 >  
 > Reviewed-by: Jan Kara <jack@suse.cz> 
 >  
 > for the series. 
 >  
 >                                 Honza 
 >  
I am so happy you like them, thank you very much.

---
Cheers,
Huaisheng



