Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2946384-1523873565-2-2356323033253870844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523873564; b=SCgLwTHNx/nXzQ554AykQufmOYAHE4rE7Xz212NS3LQ/WJTHki
    Dd5+vgUv56/5t4uL5+nIqreWY09iNHIIX5hpnvZCXSw1D4yVAP7Bg/j2vxQka17L
    j8uLkj9LIpreYMa5b5SPeMt/8pOyJXi5Pnn9/s1A4qZ5QrSSFKxyQ2FN27iLF1/q
    ccDXkvERe+aUDCqz1N6vm8vdfxWIaYJdgYgoYZkaa3p8nThnIG1tD/vJD2BzW8Ju
    9HmxaIDUreECjgEBonuQIFOYnIy5yejM3kzW4tQ85nt2QD1mB9rWSOK2geQYQjpi
    zchNZlE0w7c0AkGHMthrCHY75AJVw1W0jIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523873564; bh=KlB65/qEIBN
    562v0LEhuVmpcxua1eXEx8IyYLG28Myc=; b=AbVyIWGC8J7we4RHM/EeeyOt6RB
    VQYHbeZcyeHOsRPIsBPYAi+Z7euwuZnFbybpMll1vMTGNaarM/CDbw01MPw8X6er
    fytmpA52kQuz827SW2jJ9i53KpOUq12olJSU/x4pqVBWJK+VfbEvGd9qCoUNh0YJ
    cmfPVDCAXCkVW8cFrACM4is6+bSd6rRU03Yk2XnAfsBC0i/2w1nm2NYEvrzl+Rvl
    GdGe7wuQ/ERJCxpqfZDV7paEHtiD4UKQrBCOou2DtLCkDpmW8z61E7m9MWxXDiDA
    IrlinS+BYTrWk9oz4t7DK56vymscCEvSp0+GWnGL07GfyXYj3KeaXvSoCMQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEflynhTs+q+jyj8MCkNnIAO3FDYeAgLfb1FQi9JEEdbzEIIK2a6r7LcM3uVDgJrXlhlYCZajwfoH8Jnykc6D5XecUnDzu0EQOarE4YKOrNnKe7qBA5z
    fAgji9+gbqzt8vH00JFOD6jgrjbRgQinVd8WoREcL/holyzNhrcpGt2EEDYU9D/LpcEpCU4H72A11PeUeo6aQ6ShIyYJz0j5DIN6TfUt4IWoD9LvzkCuX5FU
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VGM_zImtL_u0-SLEFQgA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeDPKMn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 06:12:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeDPKMm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 06:12:42 -0400
Date: Mon, 16 Apr 2018 12:10:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lei Chen <chenl.lei@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.128
Message-ID: <20180416101007.GA17839@kroah.com>
References: <20180413202432.GA23021@kroah.com>
 <CAB5AJuW_09u4kRAM9qj3M05QvZSkcbhDa-CeOC=nxUNt8FU20Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB5AJuW_09u4kRAM9qj3M05QvZSkcbhDa-CeOC=nxUNt8FU20Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 05:58:26PM +0800, Lei Chen wrote:
> Hi Greg,
> This release has build failure on file tools/perf/tests/code-reading.c:
> 
> tests/code-reading.c: In function ‘read_object_code’:
> tests/code-reading.c:186:19: error: ‘KMOD_DECOMP_LEN’ undeclared
> (first use in this function)
>   char decomp_name[KMOD_DECOMP_LEN];
>                    ^

Thanks for the info, I'm going to revert the offending patch from the
next release.

greg k-h
