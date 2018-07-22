Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A29BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6C720849
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jj6jUOMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6C720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeGVDlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 23:41:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbeGVDlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 23:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F+xipt9lGzqUPlZkrM6ay3akgV25GfIuY/GGb/aSJG0=; b=Jj6jUOMb+E/5STSb4bUrNffAQ
        EHVZMFD7xbS5SHx7izO0Ew8H5rt0NBfsOkQAhIKNelbDMiX3fFFaUhFuZiAu6bPFWh/0xwXVGyPFJ
        ORDN98nF7kEapisQT/R+wNr3pWXUbjShVTbd6rJgP7zx6fE79GjqVlKTS+/CYLEemWtna5QZA0LRY
        xZxgnVyklXPxYua9541YhTpx/S8hHSosOF/SfkK45hvDzHZ78N44HiW58TEgKfIxnUL0saV/4LSDi
        4jDZjkv6X7fyfTHGwtfm9asxVR68/GuxobhzVdKEDH/7YaSEVJKuzs+ekQH/IAnLZ9p0BH+mO+omY
        j+g/Tx9wg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fh4Nv-0008H2-Pm; Sun, 22 Jul 2018 02:46:11 +0000
Subject: Re: Does Linux kernel 4.18-rc5 have drivers for IEEE 802.11AC Wave 2
 USB Wireless Adapters?
To:     Turritopsis Dohrnii Teo En Ming 
        <turritopsis.dohrnii@teo-en-ming.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <de6161f3fe0549fba89f81d8db571981@teo-en-ming.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e3f493b-f7a7-c493-9bae-ac3038c29ada@infradead.org>
Date:   Sat, 21 Jul 2018 19:46:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <de6161f3fe0549fba89f81d8db571981@teo-en-ming.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-wireless mailing list]

On 07/20/2018 08:49 PM, Turritopsis Dohrnii Teo En Ming wrote:
> Good morning from Singapore,
> 
> Does Linux kernel 4.18-rc5 have drivers for IEEE 802.11AC Wave 2 USB Wireless Adapters?
> 
> I noted that Linux usually has poor support for USB Wireless AC Adapters.
> 
> Thank you.     
>  
>  ===BEGIN SIGNATURE=== 
> Turritopsis Dohrnii Teo En Ming's Academic Qualifications as at 30 Oct 2017 
> [1] https://tdtemcerts.wordpress.com/ 
> [2] http://tdtemcerts.blogspot.sg/ 
> [3] https://www.scribd.com/user/270125049/Teo-En-Ming 
> ===END SIGNATURE=== 


-- 
~Randy
