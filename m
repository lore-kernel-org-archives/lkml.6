Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837962084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="JnLkIwmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837962084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeJAKgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:36:39 -0400
Received: from cock.li ([185.100.85.212]:39380 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbeJAKgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:36:39 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538366453; bh=rYdWdZJSb7lCnLB9Q1OMAwbOJ0p2gPMQGZF/1G6lqKY=;
        h=Date:From:To:Cc:Subject:From;
        b=JnLkIwmP0v65uA8Pbo3PJPnEMZo9El5SZ3G+wEXRAD0StD1w0fXSQ1XXOCSPKqgJe
         kJJP+r7LtYiLH6aoViJplykVX9Yii5WEXNX1JWOXdXUDo19PKBCzsNQAUbL5QTsgZW
         eFVX7ynXUctMc8APzVfTU0NnHKfSDMA2tHNfuLfpdlJdFg83HXH2XbMyRd4EibxA0G
         j/JxUiqhLEOXqZlAB8WwVchia8RamvdL8nYqn7TH3AttLwa3n9g8enw6iSuCenBt1L
         rs2rPolaN+N71KADJ/ehP/siCDH4WgNg3o40ygPs0/DKUK7Mjp6SvkEF7se87EPQpe
         LE9R8fIeQQIPQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 04:00:52 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     rms@gnu.org, bruce@perens.com, esr@thyrsus.com,
        moglen@columbia.edu, bkuhn@sfconservancy.org, editor@lwn.net
Subject: Why the FSF collects copyright assignments.
Message-ID: <37a015230e6aaa658a85809671cc98a0@redchan.it>
X-Sender: freedomfromruin@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paramount reason Eben Moglen has the FSF accepting contributions 
only with copyright assignment is because the grantor of a license that 
is a gratuity (no consideration (read: usually money) given) can remove 
the permission regarding the use of his property at his pleasure.

(Regardless of the story was promulgated for the public)
