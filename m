Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA48C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C6C20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C6C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLGSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:12:53 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:56097 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeLGSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:12:53 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gVKcM-0005Id-P9; Fri, 07 Dec 2018 18:12:50 +0000
Message-ID: <1544206370.2867.118.camel@codethink.co.uk>
Subject: Re: [PATCH 4.9 100/101] f2fs: fix to do sanity check with
 cp_pack_start_sum
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Fri, 07 Dec 2018 18:12:50 +0000
In-Reply-To: <20181206143018.979787297@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
         <20181206143018.979787297@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 15:39 +0100, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
>
> commit e494c2f995d6181d6e29c4927d68e0f295ecf75b upstream.
[...]

I accidentally reset the author for this while backporting it.  The
correct author is: Chao Yu <yuchao0@huawei.com>

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
