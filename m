Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0835C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7705120833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="L9VvyvmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7705120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeGYS4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:56:37 -0400
Received: from imap.thunk.org ([74.207.234.97]:55884 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeGYS4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rve/0iIARHKCCUbVt5kuC37KcraSFdg1F/Wz/TLgPGo=; b=L9VvyvmLrQVUgO1P/kRQPuSUnh
        yyhV943ddjZLjDt3AN/Gb0/AcIyQq+WHMRoxCsHUfIkHzZn3ye6K97lyHGElYpIDFzlN4WP7m0liF
        fnRnf6bXvvgps7Yoe42hh5Lnk0j4QXKab85+VU+vNfJGvPFhMJ8f4Eaq07BZdPOCK/TA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fiNpL-00026c-Fh; Wed, 25 Jul 2018 17:43:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CFA577A5985; Wed, 25 Jul 2018 13:43:17 -0400 (EDT)
Date:   Wed, 25 Jul 2018 13:43:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?5byg5a6B?= <zhangn1985@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: no public email address excluding Gmail
Message-ID: <20180725174317.GB11473@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?5byg5a6B?= <zhangn1985@gmail.com>,
        linux-kernel@vger.kernel.org
References: <CAC2xsYKxv_4-n19LwuoR=RJL_yP+zSqn6+HFpQyVtrsqmyv7OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2xsYKxv_4-n19LwuoR=RJL_yP+zSqn6+HFpQyVtrsqmyv7OA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 03:25:07PM +0800, 张宁 wrote:
> Hi, everyone
> 
> I notice each developer in this email list has a company email address
> or Gmail, or maybe selfhosted email.
> 
> last night I have tried my outlook.com, yahoo.com, QQ.com email, all
> of them are rejected by mechine.

There are a number of reasons why e-mail to the mailing list might
have gotten rejected by the mailer.  The most common reason is if you
forgot to disable HTML --- the vger mailer requires text-only e-mails,
since the use of HTML mail is most commonly SPAM.

You may want to take a look at some of these web pages:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/email-clients.html#email-clients

Good luck!

					- Ted
					曹子德
