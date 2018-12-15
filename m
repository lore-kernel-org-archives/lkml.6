Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A486C2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeLOTu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:50:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:34186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbeLOTu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:50:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67717AEB0;
        Sat, 15 Dec 2018 19:50:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 15 Dec 2018 20:50:54 +0100
From:   jwiesner <jwiesner@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Peter Oskolkov <posk@google.com>,
        Per Sundstrom <per.sundstrom@redqube.se>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 01/89] ipv4: ipv6: netfilter: Adjust the frag mem
 limit when truesize changes
In-Reply-To: <20181214115729.731269763@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
 <20181214115729.731269763@linuxfoundation.org>
Message-ID: <0bff96d20671f9def745c374dbdac82b@suse.de>
X-Sender: jwiesner@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-14 12:59, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me 
> know.
> 
> ------------------
> 
> From: Jiri Wiesner <jwiesner@suse.com>
> 
> [ Upstream commit ebaf39e6032faf77218220707fc3fa22487784e0 ]

I am sorry for forgetting to mention (and to include a tag) that the 
patch actually fixed v4.10-rc4-868-g158f323b9868, which introduced 
changing the truesize member in pskb_expand_head(). The patch under 
review needs to be applied to 4.14-stable and 4.19-stable only.
