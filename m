Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315B1C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035AC217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeLPJ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:56:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:54162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeLPJ4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 04:56:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BCA9AF3F;
        Sun, 16 Dec 2018 09:56:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 16 Dec 2018 10:56:43 +0100
From:   jwiesner <jwiesner@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Peter Oskolkov <posk@google.com>,
        Per Sundstrom <per.sundstrom@redqube.se>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 01/51] ipv4: ipv6: netfilter: Adjust the frag mem
 limit when truesize changes
In-Reply-To: <20181214115713.491383576@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
 <20181214115713.491383576@linuxfoundation.org>
Message-ID: <391da4b5b20f2d5632102ac03f337c5d@suse.de>
X-Sender: jwiesner@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-14 13:00, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me 
> know.
> 
> ------------------
> 
> From: Jiri Wiesner <jwiesner@suse.com>
> 
> [ Upstream commit ebaf39e6032faf77218220707fc3fa22487784e0 ]
> 

Commit v4.10-rc4-868-g158f323b9868, which the patch under review fixes, 
is not in 4.9-stable, so the patch is not necessary.
