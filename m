Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B72B20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B72B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeINRO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:14:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbeINRO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCCAAAD1A;
        Fri, 14 Sep 2018 12:00:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6646CDA737; Fri, 14 Sep 2018 14:00:44 +0200 (CEST)
Date:   Fri, 14 Sep 2018 14:00:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/50] ipwireless: switch to ->[sg]et_serial()
Message-ID: <20180914120044.rndjn25ee3aobvav@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Al Viro <viro@ZenIV.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-11-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-11-viro@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716-389-46ff60
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:10AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David Sterba <dsterba@suse.com>
