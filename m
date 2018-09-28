Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FFAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B76206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B76206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeI2BlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:41:14 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57088 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbeI2BlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:41:13 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1g5yF5-00011S-PJ; Fri, 28 Sep 2018 15:15:59 -0400
Date:   Fri, 28 Sep 2018 15:15:58 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Mark Fasheh <mark@fasheh.com>
Subject: Re: [PATCH] fs: fix access beyond unterminated strings in prints
Message-ID: <20180928191558.5xzf73soxogjm4ba@cs.cmu.edu>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Mark Fasheh <mark@fasheh.com>
References: <20180928180048.14259-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928180048.14259-1-amir73il@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 09:00:48PM +0300, Amir Goldstein wrote:
> I chose not to split the patches per fs in the hope that maintainers
> would quickly ack the patch and ask you to carry it for them.

Ack for Coda. I actually have a patch queued somewhere that dropped
printing the name and only prints the length, but this works too.

Jan

