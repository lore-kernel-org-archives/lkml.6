Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PHP_ORIG_SCRIPT,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB98C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0036F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=thousandxoaks.gq header.i=@thousandxoaks.gq header.b="L60KDnvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfANRnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:43:22 -0500
Received: from 192-227-134-34-host.colocrossing.com ([192.227.134.34]:52920
        "EHLO cpanel.success-gateway.top" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbfANRnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=thousandxoaks.gq; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Reply-To:From:Date:Subject:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eiiwfhzDPNuDGwTvVkVxpbrN6euMF9M4c5+lzxHawEw=; b=L60KDnvTy5g5eBKbxnzGofhooE
        qtWRHHqoItDbr/o6tggIbnFyWWv6DxSpYrKrWEPEY8Ac5gJRkkj8iIJVWduf/7+IJGv3g7amsLP/u
        ivlSTRXvack7F+M2fZZsnpZfF3HMka0pa8TZtubiDTRRGIIvDilBI9ivhpgWPydnKi1U+fWAT659j
        6LKjLV2nNbaN+jxADt3lJ/iiaXxFN81MMOYcctxSgWq/mYijz6VnhH36aj8HdZ8mizEaue5ciUe2T
        qjBJi9938OhDhhzvRwsptqo6DJe9t3waA2FRhvHUwB3JcGyNjcBsfoOpsZbUmtHCGWb3Wa1FSb0ek
        V+XvRB3w==;
Received: from gqthousandxoaks by cpanel.success-gateway.top with local (Exim 4.91)
        (envelope-from <khimleang03@gmail.com>)
        id 1gj6Gd-0004Aj-Qt
        for linux-kernel@vger.kernel.org; Mon, 14 Jan 2019 12:43:20 -0500
To:     linux-kernel@vger.kernel.org
Subject: Ree...
X-PHP-Script: thousandxoaks.gq/mail/leafmailer-encoded.php for 197.220.169.139, 141.101.98.97
X-PHP-Originating-Script: 1002:leafmailer-encoded.php(5317) : eval()'d code(2) : eval()'d code(1) : eval()'d code(1) : eval()'d code(1) : eval()'d code(1) : eval()'d code(1) : eval()'d code(1) : eval()'d code
Date:   Mon, 14 Jan 2019 17:43:19 +0000
From:   KHIM LEANG <khimleang03@gmail.com>
Reply-To: khimleang7@yahoo.com
Message-ID: <a0f533e04f454422021161c3e1f0dd06@thousandxoaks.gq>
X-Mailer: Leaf PHPMailer 2.7 (leafmailer.pw)
MIME-Version: 1.0
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.success-gateway.top
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1002 992] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Get-Message-Sender-Via: cpanel.success-gateway.top: authenticated_id: gqthousandxoaks/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel.success-gateway.top: gqthousandxoaks
X-Source: 
X-Source-Args: php-fpm: pool thousandxoaks_gq                           
X-Source-Dir: thousandxoaks.gq:/public_html/mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings! I sent this letter to you 2days ago,but I'm not sure if you get it,and this is the reason i repeat it again.Please get back to me for more details.
Regards,
Khim Leang

